<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.model.Employee, com.dao.EmployeeDAO" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Delete Employee - HR Management</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');
        
        :root {
            --danger-gradient: linear-gradient(135deg, #ff6b6b 0%, #ee5a52 100%);
            --warning-gradient: linear-gradient(135deg, #ffecd2 0%, #fcb69f 100%);
            --success-gradient: linear-gradient(135deg, #a8edea 0%, #fed6e3 100%);
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --glass-bg: rgba(255, 255, 255, 0.95);
            --glass-border: rgba(255, 255, 255, 0.2);
            --text-primary: #2c3e50;
            --text-secondary: #7f8c8d;
            --text-danger: #e74c3c;
            --text-warning: #f39c12;
            --shadow-soft: 0 8px 32px rgba(0, 0, 0, 0.1);
            --shadow-danger: 0 8px 32px rgba(255, 107, 107, 0.3);
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
            background: linear-gradient(135deg, #ff9a9e 0%, #fecfef 50%, #fecfef 100%);
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
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><defs><pattern id="grid" width="8" height="8" patternUnits="userSpaceOnUse"><path d="M 8 0 L 0 0 0 8" fill="none" stroke="white" stroke-width="0.3" opacity="0.1"/></pattern></defs><rect width="100" height="100" fill="url(%23grid)"/></svg>');
            pointer-events: none;
            z-index: -1;
        }

        .page-wrapper {
            max-width: 700px;
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
            background: var(--danger-gradient);
        }

        .header-title {
            font-size: 2.5rem;
            font-weight: 700;
            color: var(--text-danger);
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
            color: var(--text-danger);
            margin-bottom: 0.5rem;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.75rem;
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

        .alert.error {
            background: linear-gradient(135deg, #ff6b6b, #feca57);
            color: white;
            box-shadow: 0 4px 15px rgba(255, 107, 107, 0.3);
        }

        .alert.success {
            background: linear-gradient(135deg, #4facfe, #00f2fe);
            color: white;
            box-shadow: 0 4px 15px rgba(79, 172, 254, 0.3);
        }

        .form-group {
            margin-bottom: 1.5rem;
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
            color: var(--text-danger);
            font-weight: bold;
        }

        .input-wrapper {
            position: relative;
        }

        .form-input {
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

        .form-input:focus {
            outline: none;
            border-color: #ff6b6b;
            box-shadow: 0 0 0 4px rgba(255, 107, 107, 0.1);
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

        .danger-button {
            background: var(--danger-gradient);
            color: white;
            border: none;
            padding: 1.2rem 2rem;
            border-radius: 12px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: var(--transition);
            box-shadow: var(--shadow-danger);
            width: 100%;
            margin-top: 1rem;
            position: relative;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .danger-button::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: var(--transition);
        }

        .danger-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 40px rgba(255, 107, 107, 0.4);
        }

        .danger-button:hover::before {
            left: 100%;
        }

        .warning-panel {
            background: linear-gradient(135deg, #fff3cd, #ffeaa7);
            border: 2px solid #f39c12;
            border-radius: var(--border-radius);
            padding: 2rem;
            box-shadow: var(--shadow-soft);
            position: relative;
            overflow: hidden;
        }

        .warning-panel::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: linear-gradient(45deg, transparent 40%, rgba(243, 156, 18, 0.1) 50%, transparent 60%);
            animation: warningShimmer 3s ease-in-out infinite;
        }

        .warning-header {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            margin-bottom: 1rem;
            color: var(--text-warning);
            font-weight: 700;
            font-size: 1.2rem;
            position: relative;
            z-index: 1;
        }

        .warning-icon {
            font-size: 1.5rem;
            animation: pulse 2s ease-in-out infinite;
        }

        .warning-list {
            list-style: none;
            position: relative;
            z-index: 1;
        }

        .warning-item {
            display: flex;
            align-items: flex-start;
            gap: 0.75rem;
            color: var(--text-primary);
            font-size: 0.95rem;
            line-height: 1.5;
            margin-bottom: 0.5rem;
            font-weight: 500;
        }

        .warning-item-icon {
            color: var(--text-danger);
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

        @keyframes pulse {
            0%, 100% {
                transform: scale(1);
            }
            50% {
                transform: scale(1.1);
            }
        }

        @keyframes warningShimmer {
            0%, 100% {
                transform: translateX(-100%) translateY(-100%) rotate(45deg);
            }
            50% {
                transform: translateX(0%) translateY(0%) rotate(45deg);
            }
        }

        .confirmation-overlay {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.8);
            backdrop-filter: blur(5px);
            display: none;
            align-items: center;
            justify-content: center;
            z-index: 1000;
            animation: fadeIn 0.3s ease-out;
        }

        .confirmation-modal {
            background: var(--glass-bg);
            backdrop-filter: blur(20px);
            border-radius: var(--border-radius);
            padding: 2rem;
            max-width: 400px;
            margin: 0 20px;
            text-align: center;
            box-shadow: var(--shadow-hover);
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
            
            .form-input {
                padding: 0.875rem 0.875rem 0.875rem 2.5rem;
            }
            
            .warning-panel {
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <div class="page-wrapper">
        <!-- Header Section -->
        <div class="header-card">
            <h1 class="header-title">
                <i class="fas fa-user-minus"></i>
                Delete Employee
            </h1>
            <p class="header-subtitle">Remove employee records from the system</p>
            <a href="index.jsp" class="back-button">
                <i class="fas fa-arrow-left"></i>
                Back to Dashboard
            </a>
        </div>

        <!-- Main Form -->
        <div class="form-container">
            <div class="form-header">
                <h2 class="form-title">
                    <i class="fas fa-trash-alt"></i>
                    Delete Employee Record
                </h2>
                <p class="form-description">Enter the employee ID to permanently remove from database</p>
            </div>

            <%-- Display message if exists --%>
            <%
            String msg = (String) request.getAttribute("message");
            if (msg != null) {
            String msgClass = msg.toLowerCase().contains("success") || msg.toLowerCase().contains("deleted") ? "success" : "error";
            %>
            <div class="alert <%= msgClass %>">
                <i class="fas fa-<%= msgClass.equals("success") ? "check-circle" : "exclamation-triangle" %>"></i>
                <%= msg %>
            </div>
            <% } %>

            <form method="post" action="DeleteEmployee">
                <div class="form-group">
                    <label for="empno" class="form-label required">Employee Number</label>
                    <div class="input-wrapper">
                        <i class="fas fa-id-badge input-icon"></i>
                        <input type="number" id="empno" name="empno" class="form-input" required min="1" 
                               placeholder="Enter employee ID to delete">
                    </div>
                </div>

                <button type="submit" class="danger-button" 
                        onclick="return confirm('⚠️ WARNING: This action cannot be undone!\n\nAre you absolutely sure you want to permanently delete this employee record?\n\nClick OK to proceed or Cancel to abort.')">
                    <i class="fas fa-trash-alt"></i>
                    Delete Employee Permanently
                </button>
            </form>
        </div>

        <!-- Warning Panel -->
        <div class="warning-panel">
            <div class="warning-header">
                <i class="fas fa-exclamation-triangle warning-icon"></i>
                Critical Warning
            </div>
            <ul class="warning-list">
                <li class="warning-item">
                    <i class="fas fa-times-circle warning-item-icon"></i>
                    This action cannot be undone once confirmed
                </li>
                <li class="warning-item">
                    <i class="fas fa-times-circle warning-item-icon"></i>
                    Verify the Employee ID is correct before proceeding
                </li>
                <li class="warning-item">
                    <i class="fas fa-times-circle warning-item-icon"></i>
                    All employee data will be permanently removed
                </li>
                <li class="warning-item">
                    <i class="fas fa-times-circle warning-item-icon"></i>
                    Consider archiving instead of deletion for audit purposes
                </li>
            </ul>
        </div>
    </div>
</body>
</html>