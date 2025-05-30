<%@ page import="java.util.List" %>
<%@ page import="com.model.Employee" %>
<%
String action = request.getParameter("action");
List<Employee> employees = (List<Employee>) session.getAttribute("filteredEmployees");

if (employees == null) {
out.println("<h3>No data found. Please generate a report first.</h3>");
return;
}
%>
<html>
<head>
    <title>Report Results</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap');
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding: 25px;
            color: #1a202c;
        }
        
        .container {
            max-width: 1400px;
            margin: 0 auto;
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 24px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.15);
            padding: 50px;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        
        h2 {
            color: #1a202c;
            text-align: center;
            margin-bottom: 35px;
            font-size: 2.5rem;
            font-weight: 700;
            background: linear-gradient(135deg, #6366f1, #8b5cf6);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            letter-spacing: -0.5px;
        }
        
        .filter-info {
            margin: 25px 0;
            font-size: 16px;
            color: #4a5568;
            background: linear-gradient(135deg, #f7fafc 0%, #edf2f7 100%);
            padding: 20px 25px;
            border-radius: 16px;
            border-left: 5px solid #6366f1;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
            font-weight: 500;
        }
        
        .table-wrapper {
            background: #ffffff;
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
            margin: 35px 0;
            border: 1px solid rgba(0, 0, 0, 0.05);
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            background: #ffffff;
        }
        
        th {
            background: linear-gradient(135deg, #6366f1 0%, #8b5cf6 100%);
            color: white;
            padding: 22px 20px;
            text-align: left;
            font-weight: 600;
            font-size: 15px;
            letter-spacing: 0.5px;
            text-transform: uppercase;
            border: none;
            position: relative;
        }
        
        th::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            right: 0;
            height: 2px;
            background: rgba(255, 255, 255, 0.3);
        }
        
        td {
            padding: 18px 20px;
            border-bottom: 1px solid #e2e8f0;
            color: #2d3748;
            font-size: 15px;
            font-weight: 500;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }
        
        tr:nth-child(even) {
            background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
        }
        
        tr:hover {
            background: linear-gradient(135deg, #e0e7ff 0%, #e7d6ff 100%);
            transform: translateX(5px);
            box-shadow: 0 4px 20px rgba(99, 102, 241, 0.15);
        }
        
        tr:hover td {
            color: #1a202c;
        }
        
        .back-container {
            display: flex;
            justify-content: center;
            align-items: center;
            margin-top: 45px;
            padding-top: 35px;
            border-top: 2px solid rgba(99, 102, 241, 0.1);
        }
        
        .back-link {
            display: inline-flex;
            align-items: center;
            gap: 12px;
            background: linear-gradient(135deg, #6366f1 0%, #8b5cf6 100%);
            color: white;
            padding: 18px 36px;
            text-decoration: none;
            border-radius: 50px;
            font-size: 16px;
            font-weight: 600;
            box-shadow: 0 10px 30px rgba(99, 102, 241, 0.3);
            transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1);
            position: relative;
            overflow: hidden;
            letter-spacing: 0.3px;
            border: 2px solid transparent;
        }
        
        .back-link::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.2), transparent);
            transition: left 0.6s ease;
        }
        
        .back-link:hover::before {
            left: 100%;
        }
        
        .back-link:hover {
            background: linear-gradient(135deg, #5b59f1 0%, #7c3aed 100%);
            transform: translateY(-3px) scale(1.05);
            box-shadow: 0 15px 40px rgba(99, 102, 241, 0.4);
            border-color: rgba(255, 255, 255, 0.3);
        }
        
        .back-link:active {
            transform: translateY(-1px) scale(1.02);
            box-shadow: 0 8px 25px rgba(99, 102, 241, 0.3);
        }
        
        .back-arrow {
            font-size: 18px;
            font-weight: 700;
            transition: transform 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }
        
        .back-link:hover .back-arrow {
            transform: translateX(-4px);
        }
        
        .stats-card {
            background: linear-gradient(135deg, #f0f9ff 0%, #e0f2fe 100%);
            border: 2px solid #0ea5e9;
            border-radius: 16px;
            padding: 20px 25px;
            margin: 25px 0;
            text-align: center;
        }
        
        .stats-card h4 {
            color: #0c4a6e;
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 8px;
        }
        
        .stats-card p {
            color: #075985;
            font-size: 32px;
            font-weight: 800;
            margin: 0;
        }
        
        @media (max-width: 1024px) {
            .container {
                padding: 35px;
            }
            
            table {
                font-size: 14px;
            }
            
            th, td {
                padding: 15px 12px;
            }
        }
        
        @media (max-width: 768px) {
            body {
                padding: 15px;
            }
            
            .container {
                padding: 25px 20px;
            }
            
            h2 {
                font-size: 2rem;
            }
            
            .table-wrapper {
                overflow-x: auto;
            }
            
            table {
                min-width: 600px;
            }
            
            th, td {
                padding: 12px 10px;
                font-size: 13px;
            }
            
            .back-link {
                padding: 16px 28px;
                font-size: 15px;
            }
        }
        
        @media (max-width: 480px) {
            h2 {
                font-size: 1.6rem;
            }
            
            .filter-info {
                padding: 15px 18px;
                font-size: 14px;
            }
            
            th, td {
                padding: 10px 8px;
                font-size: 12px;
            }
        }
        
        /* Custom scrollbar for table */
        .table-wrapper::-webkit-scrollbar {
            height: 8px;
        }
        
        .table-wrapper::-webkit-scrollbar-track {
            background: #f1f5f9;
            border-radius: 10px;
        }
        
        .table-wrapper::-webkit-scrollbar-thumb {
            background: linear-gradient(135deg, #6366f1, #8b5cf6);
            border-radius: 10px;
        }
        
        .table-wrapper::-webkit-scrollbar-thumb:hover {
            background: linear-gradient(135deg, #5b59f1, #7c3aed);
        }
    </style>
</head>
<body>
<div class="container">
    <h2>Report Results</h2>

    <div class="stats-card">
        <h4>Total Records Found</h4>
        <p><%= employees.size() %></p>
    </div>

    <p class="filter-info">Filter Type: <b><%= action %></b></p>

    <div class="table-wrapper">
        <table>
            <tr>
                <th>Emp No</th>
                <th>Name</th>
                <th>Date of Joining</th>
                <th>Gender</th>
                <th>Salary</th>
            </tr>
            <%
            for(Employee e : employees) {
            %>
            <tr>
                <td><%= e.getId() %></td>
                <td><%= e.getName() %></td>
                <td><%= e.getDoj() %></td>
                <td><%= e.getGender() %></td>
                <td><%= e.getSalary() %></td>
            </tr>
            <%
            }
            %>
        </table>
    </div>
    
    <div class="back-container">
        <a href="report_form.jsp?action=<%=action%>" class="back-link">
            <span class="back-arrow">←</span>
            <span>Back to Filter</span>
        </a>
    </div>
</div>
</body>
</html>