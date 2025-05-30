<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.*, javax.servlet.*, javax.servlet.http.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Employee Directory - Employee Management System</title>
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
            padding: 2rem 1rem;
        }

        .container {
            max-width: 1400px;
            margin: 0 auto;
        }

        .header {
            text-align: center;
            margin-bottom: 2rem;
            color: white;
        }

        .header h1 {
            font-size: 3rem;
            font-weight: 800;
            margin-bottom: 0.5rem;
            text-shadow: 0 4px 8px rgba(0,0,0,0.3);
        }

        .header p {
            font-size: 1.2rem;
            opacity: 0.9;
            margin-bottom: 2rem;
        }

        .back-link {
            display: inline-block;
            color: white;
            text-decoration: none;
            font-weight: 600;
            margin-bottom: 1rem;
            padding: 0.5rem 1rem;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 25px;
            transition: all 0.3s ease;
        }

        .back-link:hover {
            background: rgba(255, 255, 255, 0.3);
            transform: translateY(-2px);
        }

        .search-section {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 2rem;
            margin-bottom: 2rem;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        .search-form {
            display: flex;
            gap: 1rem;
            align-items: end;
            flex-wrap: wrap;
        }

        .form-group {
            flex: 1;
            min-width: 200px;
        }

        .form-group label {
            display: block;
            color: #2d3748;
            font-weight: 600;
            margin-bottom: 0.5rem;
            font-size: 0.95rem;
        }

        .form-group input, .form-group select {
            width: 100%;
            padding: 0.8rem;
            border: 2px solid #e2e8f0;
            border-radius: 12px;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .form-group input:focus, .form-group select:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }

        .btn {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            border: none;
            padding: 0.8rem 2rem;
            border-radius: 12px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            height: fit-content;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
        }

        .btn-clear {
            background: #718096;
            margin-left: 0.5rem;
        }

        .btn-clear:hover {
            background: #4a5568;
        }

        .stats-section {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            padding: 1.5rem;
            text-align: center;
            backdrop-filter: blur(10px);
        }

        .stat-number {
            font-size: 2rem;
            font-weight: 800;
            color: #667eea;
            margin-bottom: 0.5rem;
        }

        .stat-label {
            color: #718096;
            font-weight: 600;
        }

        .employees-section {
            background: rgba(255, 255, 255, 0.95);
            border-radius: 20px;
            padding: 2rem;
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        .table-container {
            overflow-x: auto;
            border-radius: 15px;
            border: 1px solid #e2e8f0;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
        }

        th, td {
            padding: 1rem;
            text-align: left;
            border-bottom: 1px solid #e2e8f0;
        }

        th {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            font-size: 0.9rem;
        }

        tr:hover {
            background: #f7fafc;
        }

        .employee-card {
            background: white;
            border-radius: 15px;
            padding: 1.5rem;
            margin-bottom: 1rem;
            border: 1px solid #e2e8f0;
            transition: all 0.3s ease;
        }

        .employee-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
        }

        .employee-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
        }

        .employee-name {
            font-size: 1.3rem;
            font-weight: 700;
            color: #2d3748;
        }

        .employee-id {
            background: #667eea;
            color: white;
            padding: 0.3rem 0.8rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
        }

        .employee-details {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
        }

        .detail-item {
            display: flex;
            flex-direction: column;
        }

        .detail-label {
            font-size: 0.8rem;
            color: #718096;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 0.2rem;
        }

        .detail-value {
            color: #2d3748;
            font-weight: 500;
        }

        .no-employees {
            text-align: center;
            padding: 3rem;
            color: #718096;
        }

        .no-employees h3 {
            font-size: 1.5rem;
            margin-bottom: 0.5rem;
        }

        .error-message {
            background: #fed7d7;
            color: #c53030;
            padding: 1rem;
            border-radius: 8px;
            margin-bottom: 1rem;
            border: 1px solid #feb2b2;
        }

        .view-toggle {
            display: flex;
            gap: 0.5rem;
            margin-bottom: 1rem;
        }

        .toggle-btn {
            padding: 0.5rem 1rem;
            border: 2px solid #667eea;
            background: white;
            color: #667eea;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .toggle-btn.active {
            background: #667eea;
            color: white;
        }

        @media (max-width: 768px) {
            .search-form {
                flex-direction: column;
            }
            
            .form-group {
                min-width: 100%;
            }
            
            .header h1 {
                font-size: 2rem;
            }
            
            table {
                font-size: 0.9rem;
            }
            
            th, td {
                padding: 0.7rem;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <a href="index.jsp" class="back-link">← Back to Dashboard</a>
        
        <div class="header">
            <h1>👥 Employee Directory</h1>
            <p>Comprehensive employee database management</p>
        </div>

        <!-- Search Section -->
        <div class="search-section">
            <form method="GET" action="" class="search-form">
                <div class="form-group">
                    <label for="searchName">Employee Name:</label>
                    <input type="text" id="searchName" name="searchName" 
                           value="<%= request.getParameter("searchName") != null ? request.getParameter("searchName") : "" %>"
                           placeholder="Search by name...">
                </div>
                
                <div class="form-group">
                    <label for="searchDept">Department:</label>
                    <select id="searchDept" name="searchDept">
                        <option value="">All Departments</option>
                        <option value="IT" <%= "IT".equals(request.getParameter("searchDept")) ? "selected" : "" %>>Information Technology</option>
                        <option value="HR" <%= "HR".equals(request.getParameter("searchDept")) ? "selected" : "" %>>Human Resources</option>
                        <option value="Finance" <%= "Finance".equals(request.getParameter("searchDept")) ? "selected" : "" %>>Finance</option>
                        <option value="Marketing" <%= "Marketing".equals(request.getParameter("searchDept")) ? "selected" : "" %>>Marketing</option>
                        <option value="Operations" <%= "Operations".equals(request.getParameter("searchDept")) ? "selected" : "" %>>Operations</option>
                    </select>
                </div>
                
                <div>
                    <button type="submit" class="btn">🔍 Search</button>
                    <a href="empdisplay.jsp" class="btn btn-clear">Clear</a>
                </div>
            </form>
        </div>

        <%
            // Database connection parameters
            String dbURL = "jdbc:mysql://localhost:3306/employee_db";
            String dbUsername = "root";
            String dbPassword = "password"; // Change this to your MySQL password

            // Search parameters
            String searchName = request.getParameter("searchName");
            String searchDept = request.getParameter("searchDept");
            
            // Variables for employee data
            List<Map<String, Object>> employees = new ArrayList<>();
            int totalEmployees = 0;
            int totalDepartments = 0;
            String errorMessage = "";
            Map<String, Integer> departmentCounts = new HashMap<>();
            
            Connection conn = null;
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(dbURL, dbUsername, dbPassword);
                
                // Build SQL query based on search criteria
                StringBuilder sqlQuery = new StringBuilder("SELECT * FROM employees WHERE 1=1");
                List<String> parameters = new ArrayList<>();
                
                if (searchName != null && !searchName.trim().isEmpty()) {
                    sqlQuery.append(" AND emp_name LIKE ?");
                    parameters.add("%" + searchName.trim() + "%");
                }
                
                if (searchDept != null && !searchDept.trim().isEmpty()) {
                    sqlQuery.append(" AND emp_department = ?");
                    parameters.add(searchDept.trim());
                }
                
                sqlQuery.append(" ORDER BY emp_name");
                
                // Execute query and store results in List to avoid ResultSet closing issues
                pstmt = conn.prepareStatement(sqlQuery.toString());
                for (int i = 0; i < parameters.size(); i++) {
                    pstmt.setString(i + 1, parameters.get(i));
                }
                
                rs = pstmt.executeQuery();
                
                while (rs.next()) {
                    Map<String, Object> employee = new HashMap<>();
                    employee.put("emp_id", rs.getString("emp_id"));
                    employee.put("emp_name", rs.getString("emp_name"));
                    employee.put("emp_email", rs.getString("emp_email"));
                    employee.put("emp_phone", rs.getString("emp_phone"));
                    employee.put("emp_department", rs.getString("emp_department"));
                    employee.put("emp_position", rs.getString("emp_position"));
                    employee.put("emp_salary", rs.getDouble("emp_salary"));
                    employee.put("hire_date", rs.getDate("hire_date"));
                    employees.add(employee);
                    
                    // Count departments
                    String dept = rs.getString("emp_department");
                    departmentCounts.put(dept, departmentCounts.getOrDefault(dept, 0) + 1);
                }
                
                totalEmployees = employees.size();
                totalDepartments = departmentCounts.size();
                
            } catch (Exception e) {
                errorMessage = "Database connection error: " + e.getMessage();
                e.printStackTrace();
            } finally {
                // Close resources properly
                try {
                    if (rs != null) rs.close();
                    if (pstmt != null) pstmt.close();
                    if (conn != null) conn.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        %>

        <!-- Statistics Section -->
        <div class="stats-section">
            <div class="stat-card">
                <div class="stat-number"><%= totalEmployees %></div>
                <div class="stat-label">Total Employees</div>
            </div>
            <div class="stat-card">
                <div class="stat-number"><%= totalDepartments %></div>
                <div class="stat-label">Departments</div>
            </div>
            <div class="stat-card">
                <div class="stat-number">
                    <%= employees.isEmpty() ? "0" : String.format("%.0f", employees.stream().mapToDouble(e -> (Double)e.get("emp_salary")).average().orElse(0)) %>
                </div>
                <div class="stat-label">Avg Salary</div>
            </div>
        </div>

        <!-- Error Message -->
        <% if (!errorMessage.isEmpty()) { %>
            <div class="error-message">
                <%= errorMessage %>
            </div>
        <% } %>

        <!-- Employees Section -->
        <div class="employees-section">
            <div class="view-toggle">
                <button class="toggle-btn active" onclick="toggleView('table')">📋 Table View</button>
                <button class="toggle-btn" onclick="toggleView('card')">🎴 Card View</button>
            </div>

            <!-- Table View -->
            <div id="tableView">
                <% if (employees.isEmpty()) { %>
                    <div class="no-employees">
                        <h3>No employees found</h3>
                        <p>Try adjusting your search criteria or add new employees to the system.</p>
                    </div>
                <% } else { %>
                    <div class="table-container">
                        <table>
                            <thead>
                                <tr>
                                    <th>Employee ID</th>
                                    <th>Name</th>
                                    <th>Email</th>
                                    <th>Phone</th>
                                    <th>Department</th>
                                    <th>Position</th>
                                    <th>Salary</th>
                                    <th>Hire Date</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (Map<String, Object> employee : employees) { %>
                                    <tr>
                                        <td><%= employee.get("emp_id") %></td>
                                        <td><%= employee.get("emp_name") %></td>
                                        <td><%= employee.get("emp_email") %></td>
                                        <td><%= employee.get("emp_phone") %></td>
                                        <td><%= employee.get("emp_department") %></td>
                                        <td><%= employee.get("emp_position") %></td>
                                        <td>$<%= String.format("%,.2f", (Double)employee.get("emp_salary")) %></td>
                                        <td><%= employee.get("hire_date") %></td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    </div>
                <% } %>
            </div>

            <!-- Card View -->
            <div id="cardView" style="display: none;">
                <% if (employees.isEmpty()) { %>
                    <div class="no-employees">
                        <h3>No employees found</h3>
                        <p>Try adjusting your search criteria or add new employees to the system.</p>
                    </div>
                <% } else { %>
                    <% for (Map<String, Object> employee : employees) { %>
                        <div class="employee-card">
                            <div class="employee-header">
                                <div class="employee-name"><%= employee.get("emp_name") %></div>
                                <div class="employee-id"><%= employee.get("emp_id") %></div>
                            </div>
                            <div class="employee-details">
                                <div class="detail-item">
                                    <div class="detail-label">Email</div>
                                    <div class="detail-value"><%= employee.get("emp_email") %></div>
                                </div>
                                <div class="detail-item">
                                    <div class="detail-label">Phone</div>
                                    <div class="detail-value"><%= employee.get("emp_phone") %></div>
                                </div>
                                <div class="detail-item">
                                    <div class="detail-label">Department</div>
                                    <div class="detail-value"><%= employee.get("emp_department") %></div>
                                </div>
                                <div class="detail-item">
                                    <div class="detail-label">Position</div>
                                    <div class="detail-value"><%= employee.get("emp_position") %></div>
                                </div>
                                <div class="detail-item">
                                    <div class="detail-label">Salary</div>
                                    <div class="detail-value">$<%= String.format("%,.2f", (Double)employee.get("emp_salary")) %></div>
                                </div>
                                <div class="detail-item">
                                    <div class="detail-label">Hire Date</div>
                                    <div class="detail-value"><%= employee.get("hire_date") %></div>
                                </div>
                            </div>
                        </div>
                    <% } %>
                <% } %>
            </div>
        </div>
    </div>

    <script>
        function toggleView(viewType) {
            const tableView = document.getElementById('tableView');
            const cardView = document.getElementById('cardView');
            const buttons = document.querySelectorAll('.toggle-btn');
            
            // Remove active class from all buttons
            buttons.forEach(btn => btn.classList.remove('active'));
            
            if (viewType === 'table') {
                tableView.style.display = 'block';
                cardView.style.display = 'none';
                buttons[0].classList.add('active');
            } else {
                tableView.style.display = 'none';
                cardView.style.display = 'block';
                buttons[1].classList.add('active');
            }
        }
    </script>
</body>
</html>