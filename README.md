
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

## 🖼 Output Screenshots
### 🏠 Home Page
![Add Product] : (https://github.com/user-attachments/assets/76c3c345-d6be-4f63-9578-9cf8c0695495)

![Delete Product] : (https://github.com/user-attachments/assets/fa25e52d-a355-4c00-b1a7-320681809a17)

![Update Product] : (https://github.com/user-attachments/assets/20158bf9-8812-48d9-ba53-278beb4be423)

![Display Product] : (https://github.com/user-attachments/assets/cc668c10-bef0-44c1-8114-72bd1b03a39f)

![Report] : (https://github.com/user-attachments/assets/fc0d1dd4-55e3-4c55-8f79-cd49282ce0f2)


🛠️ Technologies Used :
-> Java (JDK)
-> Servlets
-> JDBC
-> MySQL
-> HTML/CSS
-> Apache Tomcat