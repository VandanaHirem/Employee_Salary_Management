package com.dao;

import java.sql.*;
import java.util.*;
import com.model.Employee;
import java.sql.Date;

public class EmployeeDAO {

    // ✅ Corrected: Use actual MySQL root password or a safer user if available
    private static final String URL = "jdbc:mysql://localhost:3306/employeedb";
    private static final String USERNAME = "root";
    private static final String PASSWORD = ""; // <-- Replace with actual password

    private static Connection getConnection() throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(URL, USERNAME, PASSWORD);
    }

    // Insert new employee
    public static void insertEmployee(Employee e) throws Exception {
        Connection con = getConnection();
        String sql = "INSERT INTO Employee (Empno, EmpName, DoJ, Gender, Bsalary) VALUES (?, ?, ?, ?, ?)";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, e.getId());
        ps.setString(2, e.getName());
        ps.setDate(3, Date.valueOf(e.getDoj()));
        ps.setString(4, e.getGender());
        ps.setDouble(5, e.getSalary());
        ps.executeUpdate();
        con.close();
    }

    // Get employee by Empno
    public static Employee getEmployeeById(int id) throws Exception {
        Connection con = getConnection();
        String sql = "SELECT * FROM Employee WHERE Empno=?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();
        Employee e = null;
        if (rs.next()) {
            e = new Employee();
            e.setId(rs.getInt("Empno"));
            e.setName(rs.getString("EmpName"));
            e.setDoj(rs.getDate("DoJ").toLocalDate());
            e.setGender(rs.getString("Gender"));
            e.setSalary(rs.getDouble("Bsalary"));
        }
        con.close();
        return e;
    }

    // Update employee
    public static void updateEmployee(Employee e) throws Exception {
        Connection con = getConnection();
        String sql = "UPDATE Employee SET EmpName=?, DoJ=?, Gender=?, Bsalary=? WHERE Empno=?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, e.getName());
        ps.setDate(2, Date.valueOf(e.getDoj()));
        ps.setString(3, e.getGender());
        ps.setDouble(4, e.getSalary());
        ps.setInt(5, e.getId());
        ps.executeUpdate();
        con.close();
    }

    // Delete employee
    public static void deleteEmployee(int id) throws Exception {
        Connection con = getConnection();
        String sql = "DELETE FROM Employee WHERE Empno=?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, id);
        ps.executeUpdate();
        con.close();
    }

    // Get all employees
    public static List<Employee> getAllEmployees() throws Exception {
        Connection con = getConnection();
        String sql = "SELECT * FROM Employee";
        PreparedStatement ps = con.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        List<Employee> list = new ArrayList<>();
        while (rs.next()) {
            Employee e = new Employee();
            e.setId(rs.getInt("Empno"));
            e.setName(rs.getString("EmpName"));
            e.setDoj(rs.getDate("DoJ").toLocalDate());
            e.setGender(rs.getString("Gender"));
            e.setSalary(rs.getDouble("Bsalary"));
            list.add(e);
        }
        con.close();
        return list;
    }

    // Search employees by Empno or EmpName
    public static List<Employee> searchEmployees(String keyword) throws Exception {
        Connection con = getConnection();
        String sql = "SELECT * FROM Employee WHERE Empno LIKE ? OR EmpName LIKE ?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, "%" + keyword + "%");
        ps.setString(2, "%" + keyword + "%");
        ResultSet rs = ps.executeQuery();
        List<Employee> list = new ArrayList<>();
        while (rs.next()) {
            Employee e = new Employee();
            e.setId(rs.getInt("Empno"));
            e.setName(rs.getString("EmpName"));
            e.setDoj(rs.getDate("DoJ").toLocalDate());
            e.setGender(rs.getString("Gender"));
            e.setSalary(rs.getDouble("Bsalary"));
            list.add(e);
        }
        con.close();
        return list;
    }

    // Get employees by name prefix
    public static List<Employee> getEmployeesByNamePrefix(String prefix) throws Exception {
        Connection con = getConnection();
        String sql = "SELECT * FROM Employee WHERE EmpName LIKE ?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setString(1, prefix + "%");
        ResultSet rs = ps.executeQuery();
        List<Employee> list = new ArrayList<>();
        while (rs.next()) {
            Employee e = new Employee();
            e.setId(rs.getInt("Empno"));
            e.setName(rs.getString("EmpName"));
            e.setDoj(rs.getDate("DoJ").toLocalDate());
            e.setGender(rs.getString("Gender"));
            e.setSalary(rs.getDouble("Bsalary"));
            list.add(e);
        }
        con.close();
        return list;
    }

    // Get employees with N or more years of service
    public static List<Employee> getEmployeesByServiceYears(int years) throws Exception {
        Connection con = getConnection();
        String sql = "SELECT * FROM Employee WHERE TIMESTAMPDIFF(YEAR, DoJ, CURDATE()) >= ?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, years);
        ResultSet rs = ps.executeQuery();
        List<Employee> list = new ArrayList<>();
        while (rs.next()) {
            Employee e = new Employee();
            e.setId(rs.getInt("Empno"));
            e.setName(rs.getString("EmpName"));
            e.setDoj(rs.getDate("DoJ").toLocalDate());
            e.setGender(rs.getString("Gender"));
            e.setSalary(rs.getDouble("Bsalary"));
            list.add(e);
        }
        con.close();
        return list;
    }

    // Get employees earning above a certain salary
    public static List<Employee> getEmployeesBySalary(double salary) throws Exception {
        Connection con = getConnection();
        String sql = "SELECT * FROM Employee WHERE Bsalary > ?";
        PreparedStatement ps = con.prepareStatement(sql);
        ps.setDouble(1, salary);
        ResultSet rs = ps.executeQuery();
        List<Employee> list = new ArrayList<>();
        while (rs.next()) {
            Employee e = new Employee();
            e.setId(rs.getInt("Empno"));
            e.setName(rs.getString("EmpName"));
            e.setDoj(rs.getDate("DoJ").toLocalDate());
            e.setGender(rs.getString("Gender"));
            e.setSalary(rs.getDouble("Bsalary"));
            list.add(e);
        }
        con.close();
        return list;
    }
}
