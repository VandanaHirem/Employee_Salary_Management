package com.servlet;
import com.dao.EmployeeDAO;
import com.model.Employee;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.time.LocalDate;
public class AddEmployeeServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("name");
            LocalDate doj = LocalDate.parse(request.getParameter("doj")); // format: yyyy-MM-dd
            String gender = request.getParameter("gender");
            double salary = Double.parseDouble(request.getParameter("salary"));
            
            Employee emp = new Employee();
            emp.setId(id);
            emp.setName(name);
            emp.setDoj(doj);
            emp.setGender(gender);
            emp.setSalary(salary);
            
            EmployeeDAO.insertEmployee(emp);
            
            // Set success message and forward (instead of redirect)
            request.setAttribute("successMessage", "Employee added successfully!");
            request.getRequestDispatcher("empadd.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Error: " + e.getMessage());
            request.getRequestDispatcher("empadd.jsp").forward(request, response);
        }
    }
}