package com.servlet;

import java.io.IOException;
import java.util.List;
import javax.servlet.*;
import javax.servlet.http.*;
import com.dao.EmployeeDAO;
import com.model.Employee;

public class DisplayEmployeeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Employee> employeeList = EmployeeDAO.getAllEmployees();

            // ✅ Add this loop to print employee data in the console for debugging
            for (Employee e : employeeList) {
                System.out.println("Employee: " + e.getId() + ", " + e.getName());
            }

            // Forward the list to the JSP
            request.setAttribute("employeeList", employeeList);
            RequestDispatcher dispatcher = request.getRequestDispatcher("empdisplay.jsp");
            dispatcher.forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("message", "Error: " + e.getMessage());
            RequestDispatcher dispatcher = request.getRequestDispatcher("empdisplay.jsp");
            dispatcher.forward(request, response);
        }
    }
}
