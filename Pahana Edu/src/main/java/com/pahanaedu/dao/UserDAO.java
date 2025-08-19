package com.pahanaedu.dao;

import java.sql.*;
import com.pahanaedu.model.User;
import com.pahanaedu.util.DatabaseConnection;

public class UserDAO {
	
	// ✅ Check if username or email already exists
    public boolean userExists(String username, String email) {
        String sql = "SELECT COUNT(*) FROM users WHERE username = ? OR email = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, username);
            stmt.setString(2, email);
            
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0; // true if count > 0
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return false;
    }
    
    
 // ✅ Check if account number already has a login
    public boolean accountAlreadyHasUser(String accountNumber) {
        String sql = "SELECT COUNT(*) FROM users WHERE account_number = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, accountNumber);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) return rs.getInt(1) > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }

    // ✅ Create new customer login (linked with account number)
    public boolean createUser(User user, String accountNumber) {
        String sql = "INSERT INTO users (username, password, email, first_name, last_name, phone, address, role, account_number) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, 'customer', ?)";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, user.getUsername());
            stmt.setString(2, user.getPassword()); // make sure you hash before saving
            stmt.setString(3, user.getEmail());
            stmt.setString(4, user.getFirstName());
            stmt.setString(5, user.getLastName());
            stmt.setString(6, user.getPhone());
            stmt.setString(7, user.getAddress());
            stmt.setString(8, accountNumber);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) { e.printStackTrace(); }
        return false;
    }
    
    public User authenticate(String username, String password) {
        String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, username);
            stmt.setString(2, password); // ⚠️ replace with hashed check if you use BCrypt
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                User user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setEmail(rs.getString("email"));
                user.setFirstName(rs.getString("first_name"));
                user.setLastName(rs.getString("last_name"));
                user.setPhone(rs.getString("phone"));
                user.setAddress(rs.getString("address"));
                user.setRole(rs.getString("role"));
                user.setAccountNumber(rs.getString("account_number")); // ✅ load account no
                return user;
            }
        } catch (Exception e) { e.printStackTrace(); }
        return null;
    }

    
}