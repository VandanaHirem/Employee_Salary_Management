package com.servlet;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import com.dao.EmployeeDAO;
import com.model.Employee;
import java.time.LocalDate;

public class UpdateEmployeeServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            LocalDate doj = LocalDate.parse(request.getParameter("doj"));
            String gender = request.getParameter("gender");
            double salary = Double.parseDouble(request.getParameter("salary"));
            
            Employee e = new Employee();
            e.setId(id);
            e.setName(name);
            e.setDoj(doj);
            e.setGender(gender);
            e.setSalary(salary);
            
            EmployeeDAO.updateEmployee(e);
            
            // Redirect with success parameter and employee ID
            response.sendRedirect("empupdate.jsp?success=true&id=" + id);
        } catch (Exception e) {
            // Redirect with error parameter
            response.sendRedirect("empupdate.jsp?error=" + e.getMessage());
        }
    }
}