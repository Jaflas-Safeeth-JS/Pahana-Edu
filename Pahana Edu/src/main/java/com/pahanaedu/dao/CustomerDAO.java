package com.pahanaedu.dao;

import java.sql.*;
import com.pahanaedu.model.Customer;
import com.pahanaedu.util.DatabaseConnection;
import java.util.List;
import java.util.ArrayList;
public class CustomerDAO {

	
	// Add customer
    public boolean addCustomer(Customer customer){
        String sql = "INSERT INTO customers (account_number, name, address, phone, units_consumed) VALUES (?,?,?,?,?)";
        try(Connection conn = DatabaseConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, customer.getAccountNumber());
            ps.setString(2, customer.getName());
            ps.setString(3, customer.getAddress());
            ps.setString(4, customer.getPhone());
            ps.setInt(5, customer.getUnitsConsumed());
            return ps.executeUpdate() > 0;

        } catch(Exception e){ e.printStackTrace(); return false; }
    }

    // Get last account number from DB
    public String getLastAccountNumber(){
        String lastAcc = null;
        String sql = "SELECT account_number FROM customers ORDER BY id DESC LIMIT 1";
        try(Connection conn = DatabaseConnection.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery()) {

            if(rs.next()) lastAcc = rs.getString("account_number");

        } catch(Exception e){ e.printStackTrace(); }
        return lastAcc;
    }

    // Generate next account number
    public String generateNextAccountNumber(){
        String lastAcc = getLastAccountNumber();
        if(lastAcc==null) return "PEAC01";
        int num = Integer.parseInt(lastAcc.substring(4));
        num++;
        return String.format("PEAC%02d", num);
    }

	
    //  check if account exists – useful if you add a UNIQUE index on account_number
    public boolean accountExists(String accountNumber) {
        String sql = "SELECT 1 FROM customers WHERE account_number = ? LIMIT 1";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, accountNumber);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next();
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
 // Fetch all customers
    public List<Customer> getAllCustomers() {
        List<Customer> list = new ArrayList<>();
        String sql = "SELECT * FROM customers ORDER BY id ASC";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Customer c = new Customer(
                    rs.getString("account_number"),
                    rs.getString("name"),
                    rs.getString("address"),
                    rs.getString("phone"),
                    rs.getInt("units_consumed")
                );
                list.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
 // Search customers by account number or name
    public List<Customer> searchCustomers(String query) {
        List<Customer> list = new ArrayList<>();
        String sql = "SELECT * FROM customers WHERE account_number LIKE ? OR name LIKE ? ORDER BY id ASC";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, "%" + query + "%");
            ps.setString(2, "%" + query + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Customer c = new Customer(
                        rs.getString("account_number"),
                        rs.getString("name"),
                        rs.getString("address"),
                        rs.getString("phone"),
                        rs.getInt("units_consumed")
                    );
                    list.add(c);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    
 // Get customer by account number
    public Customer getCustomerByAccount(String accountNumber) {
        String sql = "SELECT * FROM customers WHERE account_number = ?";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, accountNumber);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Customer(
                            rs.getString("account_number"),
                            rs.getString("name"),
                            rs.getString("address"),
                            rs.getString("phone"),
                            rs.getInt("units_consumed")
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    // Update customer
    public boolean updateCustomer(Customer customer) {
        String sql = "UPDATE customers SET name=?, address=?, phone=?, units_consumed=? WHERE account_number=?";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, customer.getName());
            ps.setString(2, customer.getAddress());
            ps.setString(3, customer.getPhone());
            ps.setInt(4, customer.getUnitsConsumed());
            ps.setString(5, customer.getAccountNumber());

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // Delete customer
    public boolean deleteCustomer(String accountNumber) {
        String sql = "DELETE FROM customers WHERE account_number=?";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, accountNumber);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

  /*  
 // Get customer by account number
    public Customer getCustomerByAccount(String accNo) {
        Customer c = null;
        try (Connection con = DatabaseConnection.getConnection()) {
            String sql = "SELECT * FROM customers WHERE account_number = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, accNo);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                c = new Customer(
                    rs.getString("account_number"),
                    rs.getString("name"),
                    rs.getString("address"),
                    rs.getString("phone"),
                    rs.getInt("units_consumed")
                );
            }
        } catch(SQLException e){ e.printStackTrace(); }
        return c;
    }
    */

    // Update units consumed after purchase
    public void updateUnits(String accNo, int newUnits) {
        try (Connection con = DatabaseConnection.getConnection()) {
            String sql = "UPDATE customers SET units_consumed = ? WHERE account_number = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, newUnits);
            ps.setString(2, accNo);
            ps.executeUpdate();
        } catch(SQLException e){ e.printStackTrace(); }
    }

   /* // Search customers by name or account
    public List<Customer> searchCustomers(String query) {
        List<Customer> list = new ArrayList<>();
        try (Connection con = DatabaseConnection.getConnection()) {
            String sql = "SELECT * FROM customers WHERE name LIKE ? OR account_number LIKE ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, "%" + query + "%");
            ps.setString(2, "%" + query + "%");
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                list.add(new Customer(
                    rs.getString("account_number"),
                    rs.getString("name"),
                    rs.getString("address"),
                    rs.getString("phone"),
                    rs.getInt("units_consumed")
                ));
            }
        } catch(SQLException e){ e.printStackTrace(); }
        return list;
    }
*/
    
    public Customer getCustomerByName(String name){
        Customer c = null;
        try(Connection con = DatabaseConnection.getConnection()){
            String sql = "SELECT * FROM customers WHERE name LIKE ? LIMIT 1";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, "%" + name + "%");
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                c = new Customer();
                c.setAccountNumber(rs.getString("account_number"));
                c.setName(rs.getString("name"));
                c.setAddress(rs.getString("address"));
                c.setPhone(rs.getString("phone"));
                c.setUnitsConsumed(rs.getInt("units_consumed"));
            }
        } catch(Exception e){ e.printStackTrace(); }
        return c;
    }

    
   
    
 

    
    public List<Customer> searchCustomersForBilling(String query) {
        List<Customer> list = new ArrayList<>();
        String sql = "SELECT * FROM customers WHERE account_number LIKE ? OR first_name LIKE ? OR last_name LIKE ? ORDER BY id ASC";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, "%" + query + "%");
            ps.setString(2, "%" + query + "%");
            ps.setString(3, "%" + query + "%");

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Customer c = new Customer(
                        rs.getString("account_number"),
                        rs.getString("first_name") + " " + rs.getString("last_name"),
                        rs.getString("address"),
                        rs.getString("phone"),
                        rs.getInt("units_consumed")
                    );
                    list.add(c);
                }
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }




    // Bill: Get customer by account number
    public Customer getCustomerByAccountForBilling(String accountNumber) {
        String sql = "SELECT * FROM customers WHERE account_number= ?";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, accountNumber);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                return new Customer(
                        rs.getString("account_number"),
                        rs.getString("name"),
                        rs.getString("address"),
                        rs.getString("phone"),
                        rs.getInt("units_consumed")
                );
            }
        }catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }


    // Bill: Update customer units consumed
    public boolean updateUnitsConsumed(String accountNumber, int units) throws SQLException {
        String sql = "UPDATE customers SET units_consumed=? WHERE account_number=?";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, units);
            ps.setString(2, accountNumber);
            return ps.executeUpdate() > 0;
        }
    }
    
 // Get customer by account number or name
    public Customer getCustomerByNameOrAccount(String query) {
        Customer customer = null;
        String sql = "SELECT * FROM customers WHERE account_number=? OR name LIKE ?";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, query);
            ps.setString(2, "%" + query + "%");
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                customer = new Customer(
                    rs.getString("account_number"),
                    rs.getString("name"),
                    rs.getString("address"),
                    rs.getString("phone"),
                    rs.getInt("units_consumed")
                );
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return customer;
    }

    // Get customer by ID
    public Customer getCustomerById(int id) {
        Customer customer = null;
        String sql = "SELECT * FROM customers WHERE id=?";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                customer = new Customer(
                    rs.getString("account_number"),
                    rs.getString("name"),
                    rs.getString("address"),
                    rs.getString("phone"),
                    rs.getInt("units_consumed")
                );
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return customer;
    }

	public void updateUnitsConsumed(int customerId, int totalUnits) {
		// TODO Auto-generated method stub
		
	}

	 private Customer mapRow(ResultSet rs) throws SQLException {
	        return new Customer(
	                rs.getString("account_number"),
	                rs.getString("name"),
	                rs.getString("address"),
	                rs.getString("phone"),
	                rs.getInt("units_consumed")
	        );
	    }

}