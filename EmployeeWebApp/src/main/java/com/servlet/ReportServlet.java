package com.servlet;

import com.dao.EmployeeDAO;
import com.model.Employee;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.List;

public class ReportServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        List<Employee> employees = null;

        try {
            switch (action) {
                case "NameFilter":
                    String startsWith = request.getParameter("startsWith");
                    employees = EmployeeDAO.getEmployeesByNamePrefix(startsWith);
                    break;
                case "ServiceFilter":
                    int years = Integer.parseInt(request.getParameter("years"));
                    employees = EmployeeDAO.getEmployeesByServiceYears(years);
                    break;
                case "SalaryFilter":
                    double salary = Double.parseDouble(request.getParameter("salary"));
                    employees = EmployeeDAO.getEmployeesBySalary(salary);
                    break;
                default:
                    // Invalid action, redirect or show error page
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action parameter!");
                    return;
            }

            // Store employees list in session (or request if you forward)
            HttpSession session = request.getSession();
            session.setAttribute("filteredEmployees", employees);

            // Build redirect URL with parameters
            String redirectURL = "report_result.jsp?action=" + URLEncoder.encode(action, "UTF-8");

            // Add parameters depending on action
            if ("NameFilter".equals(action)) {
                redirectURL += "&startsWith=" + URLEncoder.encode(request.getParameter("startsWith"), "UTF-8");
            } else if ("ServiceFilter".equals(action)) {
                redirectURL += "&years=" + URLEncoder.encode(request.getParameter("years"), "UTF-8");
            } else if ("SalaryFilter".equals(action)) {
                redirectURL += "&salary=" + URLEncoder.encode(request.getParameter("salary"), "UTF-8");
            }

            // Redirect to JSP page with parameters in URL
            response.sendRedirect(redirectURL);

        } catch (Exception e) {
            // Handle exception properly here (log, send error, etc)
            response.setContentType("text/html");
            response.getWriter().println("<h3>Error: " + e.getMessage() + "</h3>");
            e.printStackTrace(response.getWriter());
        }
    }
}
