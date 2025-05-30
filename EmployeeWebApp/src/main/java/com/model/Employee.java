package com.model;

import java.time.LocalDate;

public class Employee {
    private int id;               // maps to Empno
    private String name;          // maps to EmpName
    private LocalDate doj;        // maps to DoJ (Date of Joining)
    private String gender;        // maps to Gender
    private double salary;        // maps to Bsalary

    // Getter and Setter for id
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    // Getter and Setter for name
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }

    // Getter and Setter for doj
    public LocalDate getDoj() {
        return doj;
    }
    public void setDoj(LocalDate doj) {
        this.doj = doj;
    }

    // Getter and Setter for gender
    public String getGender() {
        return gender;
    }
    public void setGender(String gender) {
        this.gender = gender;
    }

    // Getter and Setter for salary
    public double getSalary() {
        return salary;
    }
    public void setSalary(double salary) {
        this.salary = salary;
    }
}
