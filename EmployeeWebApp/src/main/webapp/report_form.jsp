<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
String action = request.getParameter("action");
String actionTitle = "";
if ("NameFilter".equals(action)) {
    actionTitle = "Filter by Name Starting Letter";
} else if ("ServiceFilter".equals(action)) {
    actionTitle = "Filter by Years of Service";
} else if ("SalaryFilter".equals(action)) {
    actionTitle = "Filter by Minimum Salary";
}
%>
<html>
<head>
<meta charset="UTF-8">
<title>Report Filter Form</title>
<style>
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap');

* { 
    margin: 0; 
    padding: 0; 
    box-sizing: border-box; 
}

body { 
    font-family: 'Inter', -apple-system, BlinkMacSystemFont, sans-serif; 
    background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
    min-height: 100vh;
    padding: 30px 20px;
    font-size: 15px;
    line-height: 1.6;
}

.container { 
    width: 100%; 
    max-width: 520px; 
    margin: 0 auto; 
    display: flex;
    flex-direction: column;
    gap: 25px;
}

.header {
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(10px);
    color: #2d3748;
    padding: 35px 30px;
    border-radius: 20px;
    text-align: center;
    box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
    border: 1px solid rgba(255, 255, 255, 0.2);
}

.header h1 {
    font-size: 24px;
    font-weight: 600;
    margin-bottom: 15px;
    color: #1a202c;
}

.form-section {
    background: rgba(255, 255, 255, 0.95);
    backdrop-filter: blur(10px);
    padding: 40px 35px;
    border-radius: 20px;
    box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
    border: 1px solid rgba(255, 255, 255, 0.2);
}

.form-section h2 {
    color: #1a202c;
    margin-bottom: 25px;
    font-size: 20px;
    font-weight: 600;
}

label { 
    font-weight: 500;
    color: #4a5568;
    display: block; 
    margin-top: 20px;
    margin-bottom: 8px;
    font-size: 14px;
    letter-spacing: 0.3px;
}

input[type="text"], input[type="number"] { 
    width: 100%; 
    padding: 16px 18px; 
    margin-bottom: 20px; 
    border: 2px solid #e2e8f0;
    border-radius: 12px;
    font-size: 15px;
    font-family: 'Inter', sans-serif;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    background: #fafafa;
}

input[type="text"]:focus, input[type="number"]:focus {
    outline: none;
    border-color: #6366f1;
    background: #ffffff;
    box-shadow: 0 0 0 4px rgba(99, 102, 241, 0.1);
    transform: translateY(-1px);
}

.submit-btn { 
    background: linear-gradient(135deg, #6366f1 0%, #8b5cf6 100%);
    color: white; 
    border: none; 
    padding: 18px 35px;
    border-radius: 12px;
    cursor: pointer; 
    font-size: 16px;
    font-weight: 600;
    font-family: 'Inter', sans-serif;
    width: 100%;
    margin-top: 25px;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    letter-spacing: 0.5px;
    text-transform: uppercase;
    box-shadow: 0 4px 15px rgba(99, 102, 241, 0.3);
}

.submit-btn:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 25px rgba(99, 102, 241, 0.4);
    background: linear-gradient(135deg, #5b59f1 0%, #7c3aed 100%);
}

.submit-btn:active {
    transform: translateY(0);
}

.form-group {
    margin-bottom: 25px;
}

.form-group label {
    margin-top: 0;
}

.required::after {
    content: " *";
    color: #ef4444;
    font-weight: 600;
}

.back-link {
    display: inline-block;
    color: #6366f1;
    text-decoration: none;
    background: rgba(255, 255, 255, 0.9);
    padding: 12px 24px;
    border-radius: 12px;
    margin-top: 20px;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
    font-weight: 500;
    text-align: center;
    font-size: 14px;
    border: 2px solid rgba(99, 102, 241, 0.2);
}

.back-link:hover {
    background: rgba(255, 255, 255, 1);
    transform: translateX(-3px);
    color: #5b59f1;
    border-color: rgba(99, 102, 241, 0.3);
}

.info-card {
    background: rgba(255, 255, 255, 0.9);
    backdrop-filter: blur(10px);
    border: 2px solid rgba(16, 185, 129, 0.2);
    border-radius: 16px;
    padding: 30px;
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
}

.info-card h4 {
    color: #059669;
    margin-bottom: 15px;
    font-size: 16px;
    font-weight: 600;
}

.info-card p {
    color: #374151;
    font-size: 14px;
    line-height: 1.7;
}

/* Responsive Design */
@media (max-width: 600px) {
    body {
        padding: 20px 15px;
    }
    
    .container {
        max-width: 100%;
    }
    
    .header {
        padding: 25px 20px;
    }
    
    .form-section {
        padding: 30px 25px;
    }
    
    .info-card {
        padding: 25px 20px;
    }
    
    .header h1 {
        font-size: 20px;
    }
}

/* Custom scrollbar */
::-webkit-scrollbar {
    width: 8px;
}

::-webkit-scrollbar-track {
    background: rgba(255, 255, 255, 0.1);
    border-radius: 10px;
}

::-webkit-scrollbar-thumb {
    background: rgba(99, 102, 241, 0.3);
    border-radius: 10px;
}

::-webkit-scrollbar-thumb:hover {
    background: rgba(99, 102, 241, 0.5);
}
</style>
</head>
<body>
    <div class="header">
        <h1><%= actionTitle %></h1>
        <a href="report.jsp" class="back-link">← Back to Reports</a>
    </div>
    
    <div class="container">
        <div class="form-section">
            <h2>Generate Report</h2>
            
            <form action="ReportServlet" method="get">
                <input type="hidden" name="action" value="<%= action %>"/>
                
                <% if ("NameFilter".equals(action)) { %>
                <div class="form-group">
                    <label for="startsWith" class="required">Enter Starting Letter</label>
                    <input type="text" id="startsWith" name="startsWith" required maxlength="1" placeholder="Enter a single letter (e.g., A)">
                </div>
                <% } else if ("ServiceFilter".equals(action)) { %>
                <div class="form-group">
                    <label for="years" class="required">Enter Minimum Years of Service</label>
                    <input type="number" id="years" name="years" required min="0" placeholder="Enter minimum years (e.g., 5)">
                </div>
                <% } else if ("SalaryFilter".equals(action)) { %>
                <div class="form-group">
                    <label for="salary" class="required">Enter Minimum Salary</label>
                    <input type="number" id="salary" name="salary" required step="0.01" min="0" placeholder="Enter minimum salary (e.g., 50000.00)">
                </div>
                <% } %>
                
                <input type="submit" value="Generate Report" class="submit-btn">
            </form>
        </div>
        
        <div class="info-card">
            <h4>Filter Guidelines</h4>
            <p>
            <% if ("NameFilter".equals(action)) { %>
                • Enter a single letter (A-Z)<br>
                • Case insensitive search<br>
                • Shows employees whose name starts with the letter<br>
                • Example: Enter 'J' to find John, Jane, etc.
            <% } else if ("ServiceFilter".equals(action)) { %>
                • Enter number of years (0 or greater)<br>
                • Shows employees with equal or more service years<br>
                • Based on date of joining<br>
                • Example: Enter '5' for 5+ years of service
            <% } else if ("SalaryFilter".equals(action)) { %>
                • Enter minimum salary amount<br>
                • Shows employees earning equal or more<br>
                • Use decimal format for precision<br>
                • Example: Enter '50000' for ₹50,000 and above
            <% } %>
            </p>
        </div>
    </div>
</body>
</html>