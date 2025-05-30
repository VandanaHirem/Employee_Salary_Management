<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.model.Employee, com.dao.EmployeeDAO, java.text.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Employee</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary: #6366f1;
            --primary-dark: #4f46e5;
            --secondary: #f59e0b;
            --secondary-dark: #d97706;
            --success: #10b981;
            --error: #ef4444;
            --warning: #f59e0b;
            --dark: #1f2937;
            --gray-50: #f9fafb;
            --gray-100: #f3f4f6;
            --gray-200: #e5e7eb;
            --gray-300: #d1d5db;
            --gray-600: #4b5563;
            --gray-800: #1f2937;
            --gray-900: #111827;
            --shadow-sm: 0 1px 2px 0 rgb(0 0 0 / 0.05);
            --shadow: 0 1px 3px 0 rgb(0 0 0 / 0.1), 0 1px 2px -1px rgb(0 0 0 / 0.1);
            --shadow-lg: 0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1);
            --shadow-xl: 0 20px 25px -5px rgb(0 0 0 / 0.1), 0 8px 10px -6px rgb(0 0 0 / 0.1);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 2rem 1rem;
            color: var(--gray-800);
            line-height: 1.6;
        }

        .main-container {
            max-width: 800px;
            margin: 0 auto;
        }

        .header-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            padding: 2.5rem 2rem;
            border-radius: 24px;
            text-align: center;
            margin-bottom: 2rem;
            box-shadow: var(--shadow-xl);
            position: relative;
            overflow: hidden;
        }

        .header-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            height: 4px;
            background: linear-gradient(90deg, var(--primary), var(--secondary));
        }

        .header-card h1 {
            font-size: 2.5rem;
            font-weight: 700;
            background: linear-gradient(135deg, var(--primary), var(--secondary));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            margin-bottom: 0.5rem;
        }

        .header-card .subtitle {
            color: var(--gray-600);
            font-size: 1.1rem;
            margin-bottom: 1.5rem;
        }

        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            background: var(--primary);
            color: white;
            text-decoration: none;
            padding: 0.75rem 1.5rem;
            border-radius: 12px;
            font-weight: 500;
            transition: all 0.3s ease;
            box-shadow: var(--shadow);
        }

        .back-link:hover {
            background: var(--primary-dark);
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        .content-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 20px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: var(--shadow-xl);
            transition: all 0.3s ease;
        }

        .content-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 25px 50px -12px rgb(0 0 0 / 0.25);
        }

        .section-title {
            font-size: 1.5rem;
            font-weight: 600;
            color: var(--gray-800);
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .section-title i {
            color: var(--primary);
            font-size: 1.25rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            display: block;
            font-weight: 500;
            color: var(--gray-700);
            margin-bottom: 0.5rem;
            font-size: 0.95rem;
        }

        .required::after {
            content: " *";
            color: var(--error);
            font-weight: 600;
        }

        .form-input, .form-select {
            width: 100%;
            padding: 0.875rem 1rem;
            border: 2px solid var(--gray-200);
            border-radius: 12px;
            font-size: 1rem;
            transition: all 0.3s ease;
            background: white;
            color: var(--gray-800);
        }

        .form-input:focus, .form-select:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(99, 102, 241, 0.1);
            transform: translateY(-1px);
        }

        .form-input:disabled {
            background: var(--gray-50);
            color: var(--gray-500);
            cursor: not-allowed;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            padding: 0.875rem 1.5rem;
            border: none;
            border-radius: 12px;
            font-size: 1rem;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            min-width: 140px;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            color: white;
            box-shadow: var(--shadow);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        .btn-secondary {
            background: linear-gradient(135deg, var(--secondary), var(--secondary-dark));
            color: white;
            box-shadow: var(--shadow);
        }

        .btn-secondary:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }

        .btn-outline {
            background: transparent;
            color: var(--gray-600);
            border: 2px solid var(--gray-300);
        }

        .btn-outline:hover {
            background: var(--gray-50);
            border-color: var(--gray-400);
            transform: translateY(-1px);
        }

        .btn-group {
            display: flex;
            gap: 1rem;
            margin-top: 2rem;
        }

        .btn-full {
            width: 100%;
        }

        .alert {
            padding: 1rem 1.25rem;
            border-radius: 12px;
            margin: 1.5rem 0;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            font-weight: 500;
            box-shadow: var(--shadow);
        }

        .alert-success {
            background: rgba(16, 185, 129, 0.1);
            color: #065f46;
            border: 1px solid rgba(16, 185, 129, 0.2);
        }

        .alert-error {
            background: rgba(239, 68, 68, 0.1);
            color: #991b1b;
            border: 1px solid rgba(239, 68, 68, 0.2);
        }

        .alert-info {
            background: rgba(59, 130, 246, 0.1);
            color: #1e40af;
            border: 1px solid rgba(59, 130, 246, 0.2);
        }

        .info-card {
            background: linear-gradient(135deg, rgba(99, 102, 241, 0.05), rgba(245, 158, 11, 0.05));
            border: 1px solid rgba(99, 102, 241, 0.1);
            border-radius: 16px;
            padding: 1.5rem;
            margin-top: 2rem;
        }

        .info-card h4 {
            color: var(--primary);
            font-size: 1.1rem;
            font-weight: 600;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .info-list {
            list-style: none;
            padding: 0;
        }

        .info-list li {
            display: flex;
            align-items: flex-start;
            gap: 0.75rem;
            margin-bottom: 0.75rem;
            color: var(--gray-600);
            font-size: 0.95rem;
        }

        .info-list li::before {
            content: "→";
            color: var(--primary);
            font-weight: 600;
            flex-shrink: 0;
        }

        .employee-found {
            background: linear-gradient(135deg, rgba(16, 185, 129, 0.1), rgba(16, 185, 129, 0.05));
            border: 1px solid rgba(16, 185, 129, 0.2);
            border-radius: 12px;
            padding: 1.25rem;
            margin: 1.5rem 0;
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .employee-found i {
            color: var(--success);
            font-size: 1.5rem;
        }

        .employee-info {
            flex: 1;
        }

        .employee-name {
            font-weight: 600;
            color: var(--gray-800);
            font-size: 1.1rem;
        }

        .employee-id {
            color: var(--gray-600);
            font-size: 0.9rem;
        }

        @media (max-width: 768px) {
            body {
                padding: 1rem 0.5rem;
            }

            .header-card {
                padding: 2rem 1.5rem;
            }

            .header-card h1 {
                font-size: 2rem;
            }

            .content-card {
                padding: 1.5rem;
            }

            .btn-group {
                flex-direction: column;
            }

            .btn {
                width: 100%;
            }
        }

        /* Smooth animations */
        .fade-in {
            animation: fadeIn 0.6s ease-out;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>
</head>
<body>
    <div class="main-container">
        <div class="header-card fade-in">
            <h1><i class="fas fa-user-edit"></i> Update Employee</h1>
            <p class="subtitle">Search and modify employee information</p>
            <a href="index.jsp" class="back-link">
                <i class="fas fa-arrow-left"></i>
                Back to Home
            </a>
        </div>
        
        <!-- Search Employee Section -->
        <div class="content-card fade-in">
            <h2 class="section-title">
                <i class="fas fa-search"></i>
                Search Employee
            </h2>
            
            <form method="get">
                <div class="form-group">
                    <label for="id" class="form-label required">Employee ID</label>
                    <input type="number" id="id" name="id" required min="1" 
                           class="form-input"
                           placeholder="Enter employee ID to search"
                           value="<%= request.getParameter("id") != null ? request.getParameter("id") : "" %>">
                </div>

                <button type="submit" class="btn btn-secondary btn-full">
                    <i class="fas fa-search"></i>
                    Search Employee
                </button>
            </form>
        </div>

        <%
        String idParam = request.getParameter("id");
        Employee emp = null;
        boolean found = false;
        String error = "";
        
        if (idParam != null && !idParam.trim().isEmpty()) {
            try {
                int empId = Integer.parseInt(idParam);
                emp = EmployeeDAO.getEmployeeById(empId);
                found = emp != null;
                if (!found) error = "Employee with ID " + empId + " not found!";
            } catch (Exception e) {
                error = "Error: " + e.getMessage();
            }
        }
        %>
        
        <% if (!error.isEmpty()) { %>
        <div class="alert alert-error fade-in">
            <i class="fas fa-exclamation-circle"></i>
            <%= error %>
        </div>
        <% } %>
        
        <%-- Display success message if exists --%>
        <%
        String successMessage = (String) request.getAttribute("message");
        String successParam = request.getParameter("success");
        if (successMessage != null && (successMessage.toLowerCase().contains("success") || successMessage.toLowerCase().contains("updated"))) {
        %>
        <div class="alert alert-success fade-in">
            <i class="fas fa-check-circle"></i>
            Employee Updated Successfully!
        </div>
        <%
        } else if ("true".equals(successParam)) {
        %>
        <div class="alert alert-success fade-in">
            <i class="fas fa-check-circle"></i>
            Employee Updated Successfully!
        </div>
        <%
        }
        %>
        
        <% if (found && emp != null) { %>
        <div class="employee-found fade-in">
            <i class="fas fa-user-check"></i>
            <div class="employee-info">
                <div class="employee-name">Found: <%= emp.getName() %></div>
                <div class="employee-id">Employee ID: <%= emp.getId() %></div>
            </div>
        </div>
        
        <!-- Update Employee Form -->
        <div class="content-card fade-in">
            <h2 class="section-title">
                <i class="fas fa-edit"></i>
                Update Employee Details
            </h2>
            
            <form action="UpdateEmployee" method="post">
                <input type="hidden" name="id" value="<%= emp.getId() %>">
                
                <div class="form-group">
                    <label for="emp_id" class="form-label">Employee ID</label>
                    <input type="text" id="emp_id" class="form-input" value="<%= emp.getId() %>" disabled>
                </div>
                
                <div class="form-group">
                    <label for="name" class="form-label required">Full Name</label>
                    <input type="text" id="name" name="name" required class="form-input" 
                           value="<%= emp.getName() %>" placeholder="Enter employee full name">
                </div>
                
                <div class="form-group">
                    <label for="doj" class="form-label required">Date of Joining</label>
                    <input type="date" id="doj" name="doj" required class="form-input" 
                           value="<%= emp.getDoj() %>">
                </div>
                
                <div class="form-group">
                    <label for="gender" class="form-label required">Gender</label>
                    <select id="gender" name="gender" required class="form-select">
                        <option value="">Select Gender</option>
                        <option value="Male" <%= "Male".equals(emp.getGender()) ? "selected" : "" %>>Male</option>
                        <option value="Female" <%= "Female".equals(emp.getGender()) ? "selected" : "" %>>Female</option>
                        <option value="Other" <%= "Other".equals(emp.getGender()) ? "selected" : "" %>>Other</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label for="salary" class="form-label required">Monthly Salary</label>
                    <input type="number" id="salary" name="salary" required step="0.01" min="0" 
                           class="form-input" value="<%= emp.getSalary() %>" placeholder="0.00">
                </div>
                
                <div class="btn-group">
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save"></i>
                        Update Employee
                    </button>
                    <button type="reset" class="btn btn-outline">
                        <i class="fas fa-undo"></i>
                        Reset Form
                    </button>
                </div>
            </form>
        </div>
        <% } %>
        
        <div class="info-card fade-in">
            <h4>
                <i class="fas fa-info-circle"></i>
                Guidelines
            </h4>
            <ul class="info-list">
                <li>Search for employee by ID first</li>
                <li>All fields marked with * are required</li>
                <li>Changes will be saved permanently</li>
                <li>Employee ID cannot be changed</li>
            </ul>
        </div>
    </div>
</body>
</html>