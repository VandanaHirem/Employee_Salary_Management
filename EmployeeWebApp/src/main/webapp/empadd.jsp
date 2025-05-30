<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Employee - HR Management</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');
        
        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --secondary-gradient: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            --success-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            --danger-gradient: linear-gradient(135deg, #fa709a 0%, #fee140 100%);
            --glass-bg: rgba(255, 255, 255, 0.95);
            --glass-border: rgba(255, 255, 255, 0.2);
            --text-primary: #2c3e50;
            --text-secondary: #7f8c8d;
            --shadow-soft: 0 8px 32px rgba(0, 0, 0, 0.1);
            --shadow-hover: 0 12px 40px rgba(0, 0, 0, 0.15);
            --border-radius: 16px;
            --transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 50%, #f093fb 100%);
            min-height: 100vh;
            padding: 20px;
            position: relative;
            overflow-x: hidden;
        }

        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grid" width="10" height="10" patternUnits="userSpaceOnUse"><path d="M 10 0 L 0 0 0 10" fill="none" stroke="white" stroke-width="0.5" opacity="0.1"/></pattern></defs><rect width="100" height="100" fill="url(%23grid)"/></svg>');
            pointer-events: none;
            z-index: -1;
        }

        .page-wrapper {
            max-width: 800px;
            margin: 0 auto;
            position: relative;
            z-index: 1;
        }

        .header-card {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border: 1px solid var(--glass-border);
            border-radius: var(--border-radius);
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: var(--shadow-soft);
            text-align: center;
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
            background: var(--primary-gradient);
        }

        .header-title {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 1rem;
        }

        .header-subtitle {
            color: var(--text-secondary);
            font-size: 1.1rem;
            font-weight: 400;
            margin-bottom: 1.5rem;
        }

        .back-button {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            background: var(--primary-gradient);
            color: white;
            text-decoration: none;
            padding: 12px 24px;
            border-radius: 50px;
            font-weight: 500;
            transition: var(--transition);
            box-shadow: 0 4px 15px rgba(102, 126, 234, 0.3);
        }

        .back-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
        }

        .form-container {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border: 1px solid var(--glass-border);
            border-radius: var(--border-radius);
            padding: 2.5rem;
            box-shadow: var(--shadow-soft);
            margin-bottom: 2rem;
            position: relative;
        }

        .form-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .form-title {
            font-size: 1.8rem;
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 0.5rem;
        }

        .form-description {
            color: var(--text-secondary);
            font-size: 1rem;
        }

        .alert {
            padding: 1rem 1.5rem;
            border-radius: 12px;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
            font-weight: 500;
            animation: slideIn 0.5s ease-out;
        }

        .alert-error {
            background: linear-gradient(135deg, #ff6b6b, #feca57);
            color: white;
            box-shadow: 0 4px 15px rgba(255, 107, 107, 0.3);
        }

        .alert-success {
            background: var(--success-gradient);
            color: white;
            box-shadow: 0 4px 15px rgba(79, 172, 254, 0.3);
        }

        .form-grid {
            display: grid;
            gap: 1.5rem;
        }

        .form-group {
            position: relative;
        }

        .form-label {
            display: block;
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 0.5rem;
            font-size: 0.95rem;
        }

        .required::after {
            content: " *";
            color: #e74c3c;
            font-weight: bold;
        }

        .input-wrapper {
            position: relative;
        }

        .form-input,
        .form-select {
            width: 100%;
            padding: 1rem 1rem 1rem 3rem;
            border: 2px solid rgba(0, 0, 0, 0.1);
            border-radius: 12px;
            font-size: 1rem;
            font-family: inherit;
            background: rgba(255, 255, 255, 0.8);
            transition: var(--transition);
            backdrop-filter: blur(10px);
        }

        .form-input:focus,
        .form-select:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
            background: rgba(255, 255, 255, 0.95);
        }

        .input-icon {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-secondary);
            font-size: 1.1rem;
            z-index: 2;
        }

        .submit-button {
            background: var(--primary-gradient);
            color: white;
            border: none;
            padding: 1.2rem 2rem;
            border-radius: 12px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            box-shadow: 0 6px 20px rgba(102, 126, 234, 0.3);
            width: 100%;
            margin-top: 1rem;
            position: relative;
            overflow: hidden;
        }

        .submit-button::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: var(--transition);
        }

        .submit-button:hover {
            transform: translateY(-2px);
            box-shadow: var(--shadow-hover);
        }

        .submit-button:hover::before {
            left: 100%;
        }

        .info-panel {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border: 1px solid var(--glass-border);
            border-radius: var(--border-radius);
            padding: 1.5rem;
            box-shadow: var(--shadow-soft);
        }

        .info-header {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            margin-bottom: 1rem;
            color: var(--text-primary);
            font-weight: 600;
            font-size: 1.1rem;
        }

        .info-list {
            list-style: none;
            space-y: 0.5rem;
        }

        .info-item {
            display: flex;
            align-items: flex-start;
            gap: 0.75rem;
            color: var(--text-secondary);
            font-size: 0.95rem;
            line-height: 1.5;
            margin-bottom: 0.5rem;
        }

        .info-item-icon {
            color: #667eea;
            margin-top: 0.125rem;
            flex-shrink: 0;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @media (max-width: 768px) {
            .page-wrapper {
                padding: 0 10px;
            }
            
            .header-title {
                font-size: 2rem;
            }
            
            .form-container {
                padding: 1.5rem;
            }
            
            .form-input,
            .form-select {
                padding: 0.875rem 0.875rem 0.875rem 2.5rem;
            }
        }
    </style>
</head>
<body>
    <div class="page-wrapper">
        <!-- Header Section -->
        <div class="header-card">
            <h1 class="header-title">
                <i class="fas fa-user-plus"></i>
                Employee Management
            </h1>
            <p class="header-subtitle">Add new team members to your organization</p>
            <a href="index.jsp" class="back-button">
                <i class="fas fa-arrow-left"></i>
                Back to Dashboard
            </a>
        </div>

        <!-- Main Form -->
        <div class="form-container">
            <div class="form-header">
                <h2 class="form-title">Add New Employee</h2>
                <p class="form-description">Fill in the details below to register a new employee</p>
            </div>

            <%-- Display error message if exists --%>
            <%
            String error = (String) request.getAttribute("errorMessage");
            if (error != null) {
            %>
            <div class="alert alert-error">
                <i class="fas fa-exclamation-triangle"></i>
                <%= error %>
            </div>
            <%
            }
            %>
            
            <%-- Display success message if exists --%>
            <%
            String success = (String) request.getAttribute("successMessage");
            String successParam = request.getParameter("success");
            if (success != null || "true".equals(successParam)) {
            %>
            <div class="alert alert-success">
                <i class="fas fa-check-circle"></i>
                Employee Added Successfully!
            </div>
            <%
            }
            %>

            <form action="AddEmployeeServlet" method="post">
                <div class="form-grid">
                    <div class="form-group">
                        <label for="id" class="form-label required">Employee ID</label>
                        <div class="input-wrapper">
                            <i class="fas fa-id-badge input-icon"></i>
                            <input type="number" id="id" name="id" class="form-input" required 
                                   placeholder="Enter unique employee ID" min="1">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="name" class="form-label required">Full Name</label>
                        <div class="input-wrapper">
                            <i class="fas fa-user input-icon"></i>
                            <input type="text" id="name" name="name" class="form-input" required 
                                   placeholder="Enter employee full name">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="doj" class="form-label required">Date of Joining</label>
                        <div class="input-wrapper">
                            <i class="fas fa-calendar-alt input-icon"></i>
                            <input type="date" id="doj" name="doj" class="form-input" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="gender" class="form-label required">Gender</label>
                        <div class="input-wrapper">
                            <i class="fas fa-venus-mars input-icon"></i>
                            <select id="gender" name="gender" class="form-select" required>
                                <option value="">Select Gender</option>
                                <option value="Male">Male</option>
                                <option value="Female">Female</option>
                                <option value="Other">Other</option>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="salary" class="form-label required">Monthly Salary</label>
                        <div class="input-wrapper">
                            <i class="fas fa-dollar-sign input-icon"></i>
                            <input type="number" id="salary" name="salary" step="0.01" class="form-input" 
                                   required placeholder="0.00" min="0">
                        </div>
                    </div>
                </div>

                <button type="submit" class="submit-button">
                    <i class="fas fa-plus-circle"></i>
                    Add Employee
                </button>
            </form>
        </div>

        <!-- Info Panel -->
        <div class="info-panel">
            <div class="info-header">
                <i class="fas fa-info-circle"></i>
                Important Guidelines
            </div>
            <ul class="info-list">
                <li class="info-item">
                    <i class="fas fa-check info-item-icon"></i>
                    Employee ID must be unique across the organization
                </li>
                <li class="info-item">
                    <i class="fas fa-check info-item-icon"></i>
                    All fields marked with asterisk (*) are mandatory
                </li>
                <li class="info-item">
                    <i class="fas fa-check info-item-icon"></i>
                    Salary should be the monthly gross amount
                </li>
                <li class="info-item">
                    <i class="fas fa-check info-item-icon"></i>
                    Date format will be automatically handled by the system
                </li>
            </ul>
        </div>
    </div>
</body>
</html>