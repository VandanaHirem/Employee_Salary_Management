
# 👨‍💼 Employee_Salary_Management

A web-based Java application to manage employee records and salaries using JSP, Servlets, JDBC, and MySQL following the MVC architecture.

## 🚀 Features
-> Add new employees
-> Update existing employee details
-> Delete employees
-> Display all employee records
-> Generate reports:
-> Employees with salary greater than a value
-> Employees by gender
-> Employees with more than N years of service

 ## 📁 Project Structure
## 📁 Project Structure
```plaintext
EmployeeWebApp/
├── WebContent/
│   ├── index.jsp
│   ├── employeeadd.jsp
│   ├── employeeupdate.jsp
│   ├── employeedelete.jsp
│   ├── employeedisplay.jsp
│   ├── reports.jsp
│   ├── report_form.jsp
│   └── report_result.jsp
├── src/
│   ├── com/
│   ├── dao/
│   │   └── EmployeeDAO.java
│   ├── model/
│   │   └── Employee.java
│   └── servlet/
│       ├── AddEmployeeServlet.java
│       ├── UpdateEmployeeServlet.java
│       ├── DeleteEmployeeServlet.java
│       ├── DisplayEmployeesServlet.java
│       ├── ReportServlet.java
│       └── ReportCriteriaServlet.java
└── WEB-INF/
    └── web.xml
```
## 🗄 Database Setup
### 1. Create Database
```sql
CREATE DATABASE IF NOT EXISTS employeedb;
USE employeedb;
```

### 2. Create Table
```sql
CREATE TABLE Employee (
    Empno INT PRIMARY KEY,
    EmpName VARCHAR(100),
    DoJ DATE,
    Gender VARCHAR(10),
    Bsalary DECIMAL(10,2)
);
```
### 3. Insert Sample Data
```sql
INSERT INTO Employee (Empno, EmpName, DoJ, Gender, Bsalary) VALUES
(101, 'John Doe', '2018-05-10', 'Male', 50000.00),
(102, 'Jane Smith', '2020-03-22', 'Female', 60000.00),
(103, 'Alan Walker', '2015-01-15', 'Male', 70000.00),
(104, 'Sophie Turner', '2017-08-01', 'Female', 45000.00),
(105, 'David Warner', '2019-10-11', 'Male', 52000.00);
```

## ⚙ Installation & Setup

Step 1: Clone/Download the Project

Download all the project files and organize them according to the project structure above.

Step 2: Database Configuration
Start your MySQL server

Run the database setup scripts provided above

Update database credentials in EmployeeDAO.java:

connection = DriverManager.getConnection(
    "jdbc:mysql://localhost:3306/employeedb", 
    "your_username", 
    "your_password");

Step 3: Add MySQL JDBC Driver
-> Download MySQL Connector/J from the official MySQL website
-> Add the JAR file to your project's WEB-INF/lib directory
-> If using an IDE, add it to your build path

Step 4: Deploy to Tomcat
-> Create a new Dynamic Web Project in your IDE
-> Copy all source files to the appropriate folders
-> Deploy the project to Tomcat server
->Start the Tomcat server

Step 5: Access the Application
Open your web browser and navigate to:
http://localhost:8080/Employee_Salary_Management/

## 🖼️ Output Screenshots

### 🏠 Home Page
![Home Page](screenshots/home.jpg)

### ➕ Add Product
![Add Product](screenshots/add.jpg)

### 📝 Update Product
![Update Product](screenshots/update.jpg)

### ❌ Delete Product
![Delete Product](screenshots/delete.jpg)

### 📋 Display Products
![Display Products](screenshots/display.jpg)

### 📊 Generate Reports
![Generate Reports](screenshots/report1.jpg)
![Generate Reports](screenshots/report2.jpg)
![Generate Reports](screenshots/report3.jpg)
![Generate Reports](screenshots/report4.jpg)



🛠️ Technologies Used :
-> Java (JDK)
-> Servlets
-> JDBC
-> MySQL
-> HTML/CSS
-> Apache Tomcat