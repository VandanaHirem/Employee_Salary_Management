<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.Date, java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Employee Salary Management System</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 2rem 1rem;
        }

        .container {
            width: 100%;
            max-width: 1200px;
            margin: 0 auto;
        }

        .header {
            text-align: center;
            margin-bottom: 3rem;
            color: white;
        }

        .header h1 {
            font-size: 3.5rem;
            font-weight: 800;
            margin-bottom: 1rem;
            text-shadow: 0 4px 8px rgba(0,0,0,0.3);
            letter-spacing: -0.02em;
        }

        .header p {
            font-size: 1.3rem;
            opacity: 0.9;
            font-weight: 400;
            margin-bottom: 1.5rem;
        }

        .date-info {
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 50px;
            padding: 0.8rem 2rem;
            display: inline-block;
            font-size: 1.1rem;
            font-weight: 500;
        }

        .dashboard-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 2rem;
            margin-top: 2rem;
        }

        .feature-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 2.5rem 2rem;
            text-align: center;
            text-decoration: none;
            color: #2d3748;
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            border: 1px solid rgba(255, 255, 255, 0.3);
            backdrop-filter: blur(10px);
            position: relative;
            overflow: hidden;
        }

        .feature-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.4), transparent);
            transition: left 0.5s;
        }

        .feature-card:hover::before {
            left: 100%;
        }

        .feature-card:hover {
            transform: translateY(-10px) scale(1.02);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.2);
            background: rgba(255, 255, 255, 1);
        }

        .card-icon {
            width: 80px;
            height: 80px;
            margin: 0 auto 1.5rem;
            background: linear-gradient(135deg, #667eea, #764ba2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            color: white;
            transition: transform 0.3s ease;
        }

        .feature-card:hover .card-icon {
            transform: rotate(360deg) scale(1.1);
        }

        .card-title {
            font-size: 1.4rem;
            font-weight: 700;
            margin-bottom: 0.8rem;
            color: #2d3748;
        }

        .card-description {
            font-size: 1rem;
            color: #718096;
            line-height: 1.6;
            margin-bottom: 1.5rem;
        }

        .card-action {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            border: none;
            padding: 0.8rem 2rem;
            border-radius: 25px;
            font-weight: 600;
            font-size: 0.95rem;
            cursor: pointer;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        .card-action:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(102, 126, 234, 0.4);
        }

        .loading-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.7);
            z-index: 1000;
            justify-content: center;
            align-items: center;
            backdrop-filter: blur(5px);
        }

        .loading-content {
            background: white;
            padding: 3rem 4rem;
            border-radius: 20px;
            text-align: center;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .loading-spinner {
            width: 50px;
            height: 50px;
            border: 4px solid #f3f4f6;
            border-top: 4px solid #667eea;
            border-radius: 50%;
            animation: spin 1s linear infinite;
            margin: 0 auto 1.5rem;
        }

        .loading-text {
            font-size: 1.1rem;
            color: #4a5568;
            font-weight: 500;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }

        @media (max-width: 768px) {
            .header h1 {
                font-size: 2.5rem;
            }
            
            .header p {
                font-size: 1.1rem;
            }
            
            .dashboard-grid {
                grid-template-columns: 1fr;
                gap: 1.5rem;
            }
            
            .feature-card {
                padding: 2rem 1.5rem;
            }
            
            .date-info {
                font-size: 1rem;
                padding: 0.6rem 1.5rem;
            }
        }

        @media (max-width: 480px) {
            body {
                padding: 1rem 0.5rem;
            }
            
            .header h1 {
                font-size: 2rem;
            }
            
            .card-icon {
                width: 60px;
                height: 60px;
                font-size: 1.5rem;
            }
        }
    </style>
</head>
<body>

<%
    // Current date formatting
    Date now = new Date();
    SimpleDateFormat sdf = new SimpleDateFormat("EEEE, MMMM dd, yyyy");
    String currentDate = sdf.format(now);
%>

<div class="container">
    <div class="header">
        <h1>Employee Management</h1>
        <p>Streamline your workforce management with our comprehensive solution</p>
        <div class="date-info">📅 <%= currentDate %></div>
    </div>

    <div class="dashboard-grid">
        <a href="empadd.jsp" class="feature-card">
            <div class="card-icon">👤</div>
            <div class="card-title">Add Employee</div>
            <div class="card-description">Register new employees and set up their profiles with complete details</div>
            <div class="card-action">Get Started</div>
        </a>

        <a href="empupdate.jsp" class="feature-card">
            <div class="card-icon">✏️</div>
            <div class="card-title">Update Employee</div>
            <div class="card-description">Modify existing employee records and keep information current</div>
            <div class="card-action">Update Now</div>
        </a>

        <a href="empdelete.jsp" class="feature-card">
            <div class="card-icon">🗑️</div>
            <div class="card-title">Delete Employee</div>
            <div class="card-description">Remove employee records when they are no longer needed</div>
            <div class="card-action">Manage</div>
        </a>

        <a href="empdisplay.jsp" class="feature-card">
            <div class="card-icon">📋</div>
            <div class="card-title">View Employees</div>
            <div class="card-description">Browse and search through all employee records and details</div>
            <div class="card-action">View All</div>
        </a>

        <a href="reports.jsp" class="feature-card">
            <div class="card-icon">📊</div>
            <div class="card-title">Reports</div>
            <div class="card-description">Generate comprehensive reports and analytics for better insights</div>
            <div class="card-action">Generate</div>
        </a>
    </div>
</div>

<!-- Loading overlay -->
<div class="loading-overlay" id="loadingOverlay">
    <div class="loading-content">
        <div class="loading-spinner"></div>
        <div class="loading-text">Loading, please wait...</div>
    </div>
</div>

<script>
    // Show loading overlay on nav-card click
    document.querySelectorAll('.feature-card').forEach(card => {
        card.addEventListener('click', () => {
            document.getElementById('loadingOverlay').style.display = 'flex';
        });
    });
</script>

</body>
</html>