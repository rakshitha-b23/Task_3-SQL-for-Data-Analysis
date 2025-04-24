# Task_3: SQL FOR ANALYSIS

This project focuses on analyzing employee and performance datasets using MySQL. It demonstrates the creation of schemas and tables, data loading, and performing key SQL operations for HR analytics.

## 🏗 Schema & Table Creation
- Created a new schema `ElevateLabs`.
- Defined and created three main tables:
  - `Employee` – Employee demographics and job details.
  - `PerformanceRating` – Job satisfaction and performance scores.
  - `ds_salary` – Salary-related attributes and additional job metrics.

## 📥 Data Loading
- Loaded `.csv` files into respective tables using `LOAD DATA INFILE`.
- Properly formatted date fields using `STR_TO_DATE`.

## 🔍 SQL Operations Performed

### ✅ SELECT, WHERE, ORDER BY
- Filtered employees based on salary.
- Sorted employees in descending order of salary.

### 📊 GROUP BY with Aggregates (AVG, COUNT, SUM)
- Calculated average salary per department.
- Counted total employees and those with attrition per department.

### 🔗 JOINS (INNER, LEFT, RIGHT)
- Joined `Employee` and `PerformanceRating` to compare performance with personal attributes.

### 🧠 SUBQUERIES
- Retrieved employees earning more than the average salary.

### 👁 VIEWS
- Created a view `EmployeePerformanceView` to simplify frequent analysis combining salary, satisfaction, and manager rating.

### ⚡ Indexing
- Added indexes on `EmployeeID` fields to optimize JOIN queries.

## 📌 Purpose
This project showcases practical SQL skills applied to HR analytics, covering data engineering, performance metrics, and business insights.
---

> 📊 **Tech Stack**: MySQL  
> 📂 **Data Source**: Internal HR CSV files  
> ✨ **Focus**: Schema design, SQL joins, aggregates, subqueries, performance optimization

