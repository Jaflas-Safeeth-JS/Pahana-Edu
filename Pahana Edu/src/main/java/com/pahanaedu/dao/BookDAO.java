package com.pahanaedu.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import com.pahanaedu.model.Book;
import com.pahanaedu.util.DatabaseConnection;

public class BookDAO {

    // Add a new book
    public boolean addBook(Book book) {
        String sql = "INSERT INTO books (isbn, title, author, publisher, price, stock) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, book.getIsbn());
            ps.setString(2, book.getTitle());
            ps.setString(3, book.getAuthor());
            ps.setString(4, book.getPublisher());
            ps.setDouble(5, book.getPrice());
            ps.setInt(6, book.getStock());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get all books
    public List<Book> getAllBooks() {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT * FROM books ORDER BY id DESC";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Book book = new Book(
                        rs.getInt("id"),
                        rs.getString("isbn"),
                        rs.getString("title"),
                        rs.getString("author"),
                        rs.getString("publisher"),
                        rs.getDouble("price"),
                        rs.getInt("stock")
                );
                books.add(book);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }

    // Get book by ID
    public Book getBookById(int id) {
        String sql = "SELECT * FROM books WHERE id = ?";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Book(
                            rs.getInt("id"),
                            rs.getString("isbn"),
                            rs.getString("title"),
                            rs.getString("author"),
                            rs.getString("publisher"),
                            rs.getDouble("price"),
                            rs.getInt("stock")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Update existing book
    public boolean updateBook(Book book) {
        String sql = "UPDATE books SET isbn=?, title=?, author=?, publisher=?, price=?, stock=? WHERE id=?";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, book.getIsbn());
            ps.setString(2, book.getTitle());
            ps.setString(3, book.getAuthor());
            ps.setString(4, book.getPublisher());
            ps.setDouble(5, book.getPrice());
            ps.setInt(6, book.getStock());
            ps.setInt(7, book.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Delete a book by ID
    public boolean deleteBook(int id) {
        String sql = "DELETE FROM books WHERE id=?";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Search books by title or ISBN
    public List<Book> searchCustomersForBilling(String keyword) {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT * FROM books WHERE title LIKE ? OR isbn LIKE ? ORDER BY id DESC";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            ps.setString(2, "%" + keyword + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Book book = new Book(
                            rs.getInt("id"),
                            rs.getString("isbn"),
                            rs.getString("title"),
                            rs.getString("author"),
                            rs.getString("publisher"),
                            rs.getDouble("price"),
                            rs.getInt("stock")
                    );
                    books.add(book);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return books;
    }
    
   /*
    public boolean isDuplicateISBN(String isbn) {
        String sql = "SELECT 1 FROM books WHERE isbn = ? LIMIT 1";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, isbn);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next(); // true if ISBN exists
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    
 */
   

    
 // Search books by ISBN or Title
    public List<Book> searchBooks(String query) {
        List<Book> list = new ArrayList<>();
        String sql = "SELECT * FROM books WHERE isbn LIKE ? OR title LIKE ?";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, "%" + query + "%");
            ps.setString(2, "%" + query + "%");
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                list.add(new Book(
                    rs.getInt("id"),
                    rs.getString("isbn"),
                    rs.getString("title"),
                    rs.getString("author"),
                    rs.getString("publisher"),
                    rs.getDouble("price"),
                    rs.getInt("stock")
                ));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return list;
    }

    

    
    

    
    // Bill: Search books by ISBN or title
    public List<Book> searchBooksForBilling(String query) {
        List<Book> list = new ArrayList<>();
        String sql = "SELECT * FROM books WHERE isbn LIKE ? OR title LIKE ? ORDER BY id ASC";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, "%" + query + "%");
            ps.setString(2, "%" + query + "%");

            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                list.add(new Book(
                        rs.getInt("id"),
                        rs.getString("isbn"),
                        rs.getString("title"),
                        rs.getString("author"),
                        rs.getString("publisher"),
                        rs.getDouble("price"),
                        rs.getInt("stock")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Bill: Get book by ID
    public Book getBookByIdForBill(int id) {
        String sql = "SELECT * FROM books WHERE id=?";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                return new Book(
                        rs.getInt("id"),
                        rs.getString("isbn"),
                        rs.getString("title"),
                        rs.getString("author"),
                        rs.getString("publisher"),
                        rs.getDouble("price"),
                        rs.getInt("stock")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Bill: Update stock after purchase
    public boolean updateStock(int id, int newStock) {
        String sql = "UPDATE books SET stock=? WHERE id=?";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, newStock);
            ps.setInt(2, id);
            return ps.executeUpdate() > 0;
        } catch(SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
 // Search books by title or ISBN
    public List<Book> searchBooksForBill(String query) {
        List<Book> books = new ArrayList<>();
        String sql = "SELECT * FROM books WHERE isbn=? OR title LIKE ?";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, query);
            ps.setString(2, "%" + query + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                books.add(new Book(
                    rs.getInt("id"),
                    rs.getString("isbn"),
                    rs.getString("title"),
                    rs.getString("author"),
                    rs.getString("publisher"),
                    rs.getDouble("price"),
                    rs.getInt("stock")
                ));
            }
        } catch (SQLException e) { e.printStackTrace(); }
        return books;
    }

    // Reduce stock after purchase
    public boolean reduceStock(int bookId, int quantity) {
        String sql = "UPDATE books SET stock = stock - ? WHERE id = ?";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, quantity);
            ps.setInt(2, bookId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

 // Optional: for addBook duplicate check
    public boolean isDuplicateISBN(String isbn) {
        String sql = "SELECT 1 FROM books WHERE isbn = ? LIMIT 1";
        try (Connection con = DatabaseConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, isbn);
            try (ResultSet rs = ps.executeQuery()) { return rs.next(); }
        } catch (SQLException e) { e.printStackTrace(); return false; }
    }

    private Book mapRow(ResultSet rs) throws SQLException {
        return new Book(
                rs.getInt("id"),
                rs.getString("isbn"),
                rs.getString("title"),
                rs.getString("author"),
                rs.getString("publisher"),
                rs.getDouble("price"),
                rs.getInt("stock")
        );
    }

    
}

