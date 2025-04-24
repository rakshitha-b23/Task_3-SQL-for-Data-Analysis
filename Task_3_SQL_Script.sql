# Creating a new schema to load the dataset tables
CREATE SCHEMA ElevateLabs;

#creating a table.1 to load the Employee.dataset

CREATE TABLE ElevateLabs.Employee (
    EmployeeID VARCHAR(20) PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Gender VARCHAR(20),
    Age INT,
    BusinessTravel VARCHAR(50),
    Department VARCHAR(100),
    DistanceFromHome INT,
    State VARCHAR(10),
    Ethnicity VARCHAR(50),
    Education INT,
    EducationField VARCHAR(100),
    JobRole VARCHAR(100),
    MaritalStatus VARCHAR(20),
    Salary INT,
    StockOptionLevel INT,
    OverTime VARCHAR(5),
    HireDate DATE,
    Attrition VARCHAR(5),
    YearsAtCompany INT,
    YearsInMostRecentRole INT,
    YearsSinceLastPromotion INT,
    YearsWithCurrManager INT
);


#creating a table.2 to load Employee's Performance dataset
CREATE TABLE ElevateLabs.PerformanceRating (
    PerformanceID VARCHAR(10) PRIMARY KEY,
    EmployeeID VARCHAR(20),
    ReviewDate DATE,
    EnvironmentSatisfaction INT,
    JobSatisfaction INT,
    RelationshipSatisfaction INT,
    TrainingOpportunitiesWithinYear INT,
    TrainingOpportunitiesTaken INT,
    WorkLifeBalance INT,
    SelfRating INT,
    ManagerRating INT,
    FOREIGN KEY (EmployeeID) REFERENCES Employee(EmployeeID)
);

#creating a table.3 to load the employees salary 

CREATE TABLE ElevateLabs.ds_salary (
    Age INT,
	Attrition VARCHAR (20),	
    BusinessTravel VARCHAR (20),
    DailyRate INT,
    Department VARCHAR(100),
    DistanceFromHome INT,
    Education INT,
    EducationField VARCHAR(100),
    EmployeeCount INT,
    EmployeeNumber INT,
    EnvironmentSatisfaction INT,
    Gender VARCHAR(10),
    HourlyRate INT,
    JobInvolvement INT,
    JobLevel INT,
    JobRole VARCHAR(100),
    JobSatisfaction INT,
    MaritalStatus VARCHAR(20),
    MonthlyIncome INT,
    MonthlyRate INT,
    NumCompaniesWorked INT,
    Over18 CHAR(1),
    OverTime VARCHAR(5),
    PercentSalaryHike INT,
    PerformanceRating INT,
    RelationshipSatisfaction INT,
    StandardHours INT,
    StockOptionLevel INT,
    TotalWorkingYears INT,
    TrainingTimesLastYear INT,
    WorkLifeBalance INT,
    YearsAtCompany INT,
    YearsInCurrentRole INT,
    YearsSinceLastPromotion INT,
    YearsWithCurrManager INT
);

##Loding the datas to the respected tables
LOAD DATA INFILE "C:\\ProgramData\\MySQL\\MySQL Server 9.2\\Uploads\\Employee.csv"
INTO TABLE ElevateLabs.Employee
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(EmployeeID, FirstName, LastName, Gender, Age, BusinessTravel, Department, DistanceFromHome, State, Ethnicity, Education, EducationField, JobRole, MaritalStatus, Salary, StockOptionLevel, OverTime, @HireDate, Attrition, YearsAtCompany, YearsInMostRecentRole, YearsSinceLastPromotion, YearsWithCurrManager)
SET HireDate = STR_TO_DATE(@HireDate, '%d-%m-%Y');

LOAD DATA INFILE "C:\\ProgramData\\MySQL\\MySQL Server 9.2\\Uploads\\PerformanceRating.csv"
INTO TABLE ElevateLabs.PerformanceRating
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(PerformanceID, EmployeeID, @ReviewDate, EnvironmentSatisfaction, JobSatisfaction, RelationshipSatisfaction, TrainingOpportunitiesWithinYear, TrainingOpportunitiesTaken, WorkLifeBalance, SelfRating, ManagerRating)
SET ReviewDate = STR_TO_DATE(@ReviewDate, '%d-%m-%Y');

LOAD DATA INFILE "C:\\ProgramData\\MySQL\\MySQL Server 9.2\\Uploads\\WA_Fn-UseC_-HR-Employee-Attrition.csv"
INTO TABLE ElevateLabs.DS_Salary
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

# performing the tasks using SELECT, WHERE, ORDER BY, GROUP BY
select EmployeeID, FirstName, LastName, Gender, Age, State,JobRole, Salary
from elevatelabs.employee
where Salary > 50000
order by Salary desc;
 

# performing the tasks using GROUP BY and Aggregates like AVG and SUM

select Department, avg(Salary) as AvgSalary
from elevatelabs.employee
group by Department;

select Department, count(*) as TotalEmployees,
		sum(case when Attrition = 'Yes' then 1 else 0 end) as Atritioncount
from elevatelabs.employee
group by Department;

#JOINS (INNER, LEFT , RIGHT)
#INNER JOIN
select * 
from elevatelabs.employee as e
inner join elevatelabs.performancerating as p 
on e.EmployeeID = p.EmployeeID
limit 10;

#LEFT JOIN
 select e.EmployeeID, e.FirstName, e.LastName, e.Department, e.Education, 
 p.EmployeeID, p.PerformanceID, p.JobSatisfaction, p.EnvironmentSatisfaction
from elevatelabs.employee as e
left join elevatelabs.performancerating as p 
on e.EmployeeID = p.EmployeeID
limit 10;

#RIGHT JOIN
select e.EmployeeID, e.FirstName, e.LastName, e.Department, e.Education, 
 p.EmployeeID, p.PerformanceID, p.JobSatisfaction, p.EnvironmentSatisfaction, p.RelationshipSatisfaction
from elevatelabs.employee as e
right join elevatelabs.performancerating as p 
on e.EmployeeID = p.EmployeeID
limit 10;

# SUBQUERIES
select FirstName, LastName, Salary
from elevatelabs.employee
where Salary > (
	select avg(Salary)
	from elevatelabs.employee);
    
#Create Views for Analysis
CREATE VIEW EmployeePerformanceView AS
SELECT 
    e.EmployeeID, FirstName, LastName, Department, Salary, JobSatisfaction, WorkLifeBalance, ManagerRating
FROM elevatelabs.employee AS e
JOIN elevatelabs.performancerating as p 
ON e.EmployeeID = p.EmployeeID;
SELECT * FROM EmployeePerformanceView WHERE JobSatisfaction >= 4
limit 10;

# Optimize Queries with Indexes
CREATE INDEX idx_employee_id ON elevatelabs.employee(EmployeeID);
CREATE INDEX idx_perf_employee_id ON elevatelabs.performancerating(EmployeeID);
SHOW INDEX FROM elevatelabs.employee;
SHOW INDEX FROM elevatelabs.performancerating;
