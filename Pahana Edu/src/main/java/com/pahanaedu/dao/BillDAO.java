package com.pahanaedu.dao;

import com.pahanaedu.model.Bill;
import com.pahanaedu.model.BillItem;
import com.pahanaedu.util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BillDAO {

    
    public int createBill(String customerAccNo, List<BillItem> items) throws SQLException {
        if (items == null || items.isEmpty()) {
            throw new SQLException("No items in bill.");
        }

        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            con = DatabaseConnection.getConnection();
            con.setAutoCommit(false);

            double total = 0;
            int totalUnits = 0;

            // Lock and validate stock, compute totals, and get current price if not provided
            for (BillItem it : items) {
                // Lock row so stock can't change mid-transaction
                try (PreparedStatement psLock = con.prepareStatement(
                        "SELECT stock, price FROM books WHERE id = ? FOR UPDATE")) {
                    psLock.setInt(1, it.getBookId());
                    try (ResultSet rsLock = psLock.executeQuery()) {
                        if (!rsLock.next()) {
                            throw new SQLException("Book not found (id=" + it.getBookId() + ")");
                        }
                        int stock = rsLock.getInt("stock");
                        double dbPrice = rsLock.getDouble("price");

                        if (it.getUnitPrice() <= 0) {
                            it.setUnitPrice(dbPrice);
                        }
                        if (it.getQuantity() <= 0) {
                            throw new SQLException("Invalid quantity for book id " + it.getBookId());
                        }
                        if (stock < it.getQuantity()) {
                            throw new SQLException("Not enough stock for book id " + it.getBookId()
                                    + " (available=" + stock + ", requested=" + it.getQuantity() + ")");
                        }
                        it.setLineTotal(it.getQuantity() * it.getUnitPrice());
                        total += it.getLineTotal();
                        totalUnits += it.getQuantity();
                    }
                }
            }

            // Insert bill header
            ps = con.prepareStatement(
                    "INSERT INTO bills (customer_acc_no, total) VALUES (?, ?)",
                    Statement.RETURN_GENERATED_KEYS
            );
            ps.setString(1, customerAccNo);
            ps.setDouble(2, total);
            ps.executeUpdate();

            rs = ps.getGeneratedKeys();
            if (!rs.next()) {
                throw new SQLException("Failed to create bill id.");
            }
            int billId = rs.getInt(1);
            rs.close(); rs = null;
            ps.close(); ps = null;

            // Insert items & reduce stock
            try (PreparedStatement psItem = con.prepareStatement(
                    "INSERT INTO bill_items (bill_id, book_id, quantity, unit_price, line_total) VALUES (?, ?, ?, ?, ?)");
                 PreparedStatement psStock = con.prepareStatement(
                    "UPDATE books SET stock = stock - ? WHERE id = ?")) {

                for (BillItem it : items) {
                    psItem.setInt(1, billId);
                    psItem.setInt(2, it.getBookId());
                    psItem.setInt(3, it.getQuantity());
                    psItem.setDouble(4, it.getUnitPrice());
                    psItem.setDouble(5, it.getLineTotal());
                    psItem.addBatch();

                    psStock.setInt(1, it.getQuantity());
                    psStock.setInt(2, it.getBookId());
                    psStock.addBatch();
                }

                psItem.executeBatch();
                psStock.executeBatch();
            }

            // Increase customer's units_consumed by totalUnits
            try (PreparedStatement psCust = con.prepareStatement(
                    "UPDATE customers SET units_consumed = units_consumed + ? WHERE account_number = ?")) {
                psCust.setInt(1, totalUnits);
                psCust.setString(2, customerAccNo);
                int updated = psCust.executeUpdate();
                if (updated == 0) {
                    throw new SQLException("Customer account not found: " + customerAccNo);
                }
            }

            con.commit();
            return billId;

        } catch (SQLException ex) {
            if (con != null) con.rollback();
            throw ex;
        } finally {
            if (rs != null) try { rs.close(); } catch (Exception ignore) {}
            if (ps != null) try { ps.close(); } catch (Exception ignore) {}
            if (con != null) try { con.setAutoCommit(true); con.close(); } catch (Exception ignore) {}
        }
    }
    
 // Get all bills with optional search (by customer account or name)
    public List<Bill> getAllBills(String searchQuery) {
        List<Bill> bills = new ArrayList<>();
        try (Connection con = DatabaseConnection.getConnection()) {
            String sql = "SELECT b.id, b.customer_acc_no, b.bill_date, b.total, c.name " +
                         "FROM bills b JOIN customers c ON b.customer_acc_no = c.account_number ";
            if (searchQuery != null && !searchQuery.isEmpty()) {
                sql += "WHERE b.customer_acc_no LIKE ? OR c.name LIKE ? ";
            }
            sql += "ORDER BY b.bill_date DESC";

            PreparedStatement ps = con.prepareStatement(sql);

            if (searchQuery != null && !searchQuery.isEmpty()) {
                String q = "%" + searchQuery + "%";
                ps.setString(1, q);
                ps.setString(2, q);
            }

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Bill bill = new Bill();
                bill.setId(rs.getInt("id"));
                bill.setCustomerAccNo(rs.getString("customer_acc_no"));
                bill.setBillDate(rs.getTimestamp("bill_date"));
                bill.setTotal(rs.getDouble("total"));
                bills.add(bill);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bills;
    }

    // Get bill items by bill ID
    public List<BillItem> getBillItems(int billId) {
        List<BillItem> items = new ArrayList<>();
        try (Connection con = DatabaseConnection.getConnection()) {
            String sql = "SELECT * FROM bill_items WHERE bill_id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, billId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                BillItem item = new BillItem();
                item.setId(rs.getInt("id"));
                item.setBillId(rs.getInt("bill_id"));
                item.setBookId(rs.getInt("book_id"));
                item.setQuantity(rs.getInt("quantity"));
                item.setUnitPrice(rs.getDouble("unit_price"));
                item.setLineTotal(rs.getDouble("line_total"));
                items.add(item);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return items;
    }
    
    public Bill getBillById(int id) {
        Bill bill = null;
        String sql = "SELECT * FROM bills WHERE id=?";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    bill = new Bill();
                    bill.setId(rs.getInt("id"));
                    bill.setCustomerAccNo(rs.getString("customer_acc_no"));
                    bill.setBillDate(rs.getTimestamp("bill_date"));
                    bill.setTotal(rs.getDouble("total"));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bill;
    }

// for dashboard
    
    public int getTotalBillsToday() {
        int count = 0;
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT COUNT(*) FROM bills WHERE DATE(bill_date) = CURDATE()");
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) count = rs.getInt(1);
        } catch (Exception e) { e.printStackTrace(); }
        return count;
    }

    public double getTotalSalesToday() {
        double total = 0;
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement("SELECT SUM(total) FROM bills WHERE DATE(bill_date) = CURDATE()");
             ResultSet rs = ps.executeQuery()) {
            if (rs.next()) total = rs.getDouble(1);
        } catch (Exception e) { e.printStackTrace(); }
        return total;
    }


}
