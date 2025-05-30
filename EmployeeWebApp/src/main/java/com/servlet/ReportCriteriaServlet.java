package com.servlet;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class ReportCriteriaServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String reportType = request.getParameter("reportType");
        String url = "ReportServlet?action=" + reportType;

        // Append parameters based on selected report type
        switch (reportType) {
            case "NameFilter":
                String startsWith = request.getParameter("startsWith");
                if (startsWith == null || startsWith.trim().isEmpty()) {
                    request.setAttribute("error", "Please enter a starting letter.");
                    request.getRequestDispatcher("reports.jsp").forward(request, response);
                    return;
                }
                url += "&startsWith=" + startsWith.trim();
                break;

            case "ServiceFilter":
                String yearsStr = request.getParameter("years");
                if (yearsStr == null || yearsStr.trim().isEmpty()) {
                    request.setAttribute("error", "Please enter number of years.");
                    request.getRequestDispatcher("reports.jsp").forward(request, response);
                    return;
                }
                url += "&years=" + yearsStr.trim();
                break;

            case "SalaryFilter":
                String salaryStr = request.getParameter("salary");
                if (salaryStr == null || salaryStr.trim().isEmpty()) {
                    request.setAttribute("error", "Please enter salary threshold.");
                    request.getRequestDispatcher("reports.jsp").forward(request, response);
                    return;
                }
                url += "&salary=" + salaryStr.trim();
                break;

            default:
                request.setAttribute("error", "Invalid report type selected.");
                request.getRequestDispatcher("reports.jsp").forward(request, response);
                return;
        }

        // Redirect to ReportServlet with parameters
        response.sendRedirect(url);
    }
}

