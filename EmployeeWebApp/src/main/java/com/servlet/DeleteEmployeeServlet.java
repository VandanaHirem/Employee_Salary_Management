package com.servlet;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;
import com.dao.EmployeeDAO;
import com.model.Employee;

public class DeleteEmployeeServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String message = "";
        try {
            int empno = Integer.parseInt(request.getParameter("empno"));

            // Check if employee exists first
            Employee emp = EmployeeDAO.getEmployeeById(empno);
            if (emp == null) {
                message = "Employee with ID " + empno + " is not present. You cannot delete.";
            } else {
                // Employee exists, proceed to delete
                EmployeeDAO.deleteEmployee(empno);
                message = "Employee deleted successfully.";
            }
        } catch (NumberFormatException e) {
            message = "Invalid employee ID format!";
        } catch (Exception e) {
            message = "Error deleting employee: " + e.getMessage();
        }

        // Set message for UI
        request.setAttribute("message", message);

        // Fetch updated employee list for display
        try {
            List<Employee> list = EmployeeDAO.getAllEmployees();
            request.setAttribute("employeeList", list);
        } catch (Exception e) {
            request.setAttribute("message", "Error fetching employee list: " + e.getMessage());
        }

        RequestDispatcher rd = request.getRequestDispatcher("empdelete.jsp");
        rd.forward(request, response);
    }
}
