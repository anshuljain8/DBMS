 
#EMPLOYEE
 create table Employee
     (Fname varchar(20),
     Lname varchar(20),
     Minit varchar(2),
     Ssn int Primary key,
     Bdate Date,
     Address varchar(30),
     Sex char(1),
     Salary int,
     Super_ssn int,
     Dno int);


insert into Employee values ('John','Smith','B',123456789,'1965-01-09','731 Foundren,Houston,TX','M',30000,333445555,5);
insert into Employee values ('Franklin','Wong','T',333445555,'1955-12-08','638 Voss,Houston,TX','M',40000,888665555,5);
insert into Employee values ('Alicia','Zelaya','J',999887777,'1968-01-19','3321 Castle,Spring,TX','F',25000,987654321,4);
insert into Employee values ('Jennifer','Wallace','S',987654321,'1941-06-20','291 Berry,Bellaire,TX','F',43000,888665555,4);
insert into Employee values ('Ramesh','Narayan','K',666884444,'1962-09-15','975 Fire Oak,Humble,TX','M',38000,333445555,5);
insert into Employee values ('Joyce','English','A',453453453,'1972-07-31','5631 Rice,Houston,TX','F',25000,333445555,5);
insert into Employee values ('Ahmad','Jabbar','V',987987987,'1969-03-29','980 Dallas,Houston,TX','M',25000,987654321,4);
insert into Employee values ('James','Borg','E',888665555,'1937-11-10','450 Stone,Houston,TX','M',55000,NULL,1);

alter table Employee add Foreign key(Super_ssn) references Employee(Ssn);

#DEPARTMENT

create table Department (Dname varchar(20),
     Dnumber int primary key,
     Mgr_ssn int,
     Mgr_start_date date);

insert into Department values ('Research',5,333445555,'1988-05-22');
insert into Department values ('Adminstration',4,987654321,'1995-01-01');
insert into Department values ('Headquarters',1,888665555,'1981-06-19');

alter table Employee Add Foreign key (Dno) references Department(Dnumber);
alter table Department add Foreign key(Mgr_ssn) references Employee(Ssn);


#DEPT_LOCATIONS
create table Dept_Locations (Dnumber int,Dlocation varchar(30),Constraint D_LOCATION primary key(Dnumber,Dlocation));

insert into Dept_Locations values (1,'Houston');
insert into Dept_Locations values (4,'Staford');
insert into Dept_Locations values (5,'Belaire');
insert into Dept_Locations values (5,'Sugarland');
insert into Dept_Locations values (5,'Houston');

alter table Dept_Locations add Foreign key(Dnumber) references Department(Dnumber);


#WORKS_ON

 create table Works_on (Essn int ,
 Pno int,
 Hours varchar(9),
 Constraint Work Primary key(Essn,Pno));

insert into Works_on values (123456789,1,32.5);
insert into Works_on values (123456789,2,7.5);
insert into Works_on values (666884444,3,40.0);
insert into Works_on values (453453453,1,20.0);
insert into Works_on values (453453453,2,20.0);
insert into Works_on values (333445555,2,10.0);
insert into Works_on values (333445555,3,10.0);
insert into Works_on values (333445555,10,10.0);
insert into Works_on values (333445555,20,10.0);
insert into Works_on values (999887777,30,30.0);
insert into Works_on values (999887777,10,10.0);
insert into Works_on values (987987987,10,35.0);
insert into Works_on values (987987987,30,5.0);
insert into Works_on values (987654321,30,20.0);
insert into Works_on values (987654321,20,15.0);
insert into Works_on values (888665555,20,NULL);

alter table Works_on add Foreign key(Essn) references Employee(Ssn);


#PROJECT

create table Project (Pname varchar(30),
Pnumber int Primary key,
Plocation varchar(30),
Dnum int,
Foreign key(Dnum) references Department(Dnumber));


insert into Project values
    ('ProductX',1,'Bellaire',5);


insert into Project values
    ('ProductY',2,'Sugarland',5);
    

insert into Project values
    ('ProductZ',3,'Houston',5);


insert into Project values
    ('Computerization',10,'Staford',4);


insert into Project values
    ('Reorganization',20,'Houston',1);


insert into Project values
    ('Newbenifits',30,'Staford',4);

alter table Works_on add Foreign key(Pno) references Project(Pnumber) ;
alter table Project add Foreign key(Dnum) references Department(Dnumber) ;







 
#DEPENDENT
create table Dependent (Essn int,
Dependent_name varchar(20),
Sex varchar(6),
Bdate date,
Relationship varchar(20),
Constraint Dependent Primary key(Essn,Dependent_name),
Foreign key(Essn) references Employee(Ssn));

insert into Dependent values
    (333445555,'Alice','F','1986-04-05','Daughter');

insert into Dependent values
    (333445555,"theodore",'M','1983-10-25','Son');
insert into Dependent values
    (333445555,'Joy','F','1958-05-03','Spouse');
insert into Dependent values
    (987654321,'Abner','M','1942-02-08','Spouse');
insert into Dependent values
    (123456789,'Michael','M','1988-01-04','Son');
insert into Dependent values
    (123456789,'Alice','F','1988-12-30','Daughter');


insert into Dependent values
    (123456789,'Elizabeth','F','1967-05-05','Spouse');



#1
#Retrieve the name, birthdate and address of every 
#employee who works for the ‘administration’ department.


    SELECT Concat(Fname,' ',Lname),Bdate,Address
    FROM Employee,Department
    WHERE Dno=Dnumber and Dname='Adminstration';


    SELECT concat(Fname,' ',Lname ),Bdate,Address
    FROM Employee 
    INNER JOIN Department ON Dno=Dnumber
    WHERE Dname="Adminstration";


#2

# Find the sum of the salaries of all employees of the ‘Research’
#department, as well as the maximum salary, the minimum salary, 
#and the average salary in this department.


    SELECT SUM(Salary),
    MIN(Salary),
    MAX(Salary),
    AVG(Salary), 
    FROM Employee 
    INNER JOIN Department ON Dno=Dnumber 
    WHERE Dname="Research";


#3

# Retrieve the number 
#of employees in the ‘administration’ department

    SELECT count(*) 
    FROM Employee
    INNER JOIN Department ON Dno=Dnumber
    WHERE Dname="Adminstration";


#4
# For each project, retrieve the project number, the project name, 
#and the number of employees who work on that project.

    select Pnumber as ProjectNumber,
    Pname as ProjectName,
    count(Pno) as numberOfEmployees 
    from Project 
    inner join Works_on on Pnumber=Pno 
    group by Pno;


#5
# For each project, retrieve the project number, the project name, 
#project location and the number of employees from department 5 who 
#work on the project.
    select Pnumber as ProjectNumber,
    Pname as ProjectName,
    Plocation as ProjectLocation,
    count(Pno) as numberOfEmployees 
    from Project 
    inner join Works_on on Pnumber=Pno
    AND Dnum=5
    GROUP BY Pno;


#6
#For every project located in ‘Houston’, list the project number, 
#the controlling department number, and the department manager’s last 
#name, address.

    SELECT p.Pnumber AS projectNumber,
    p.Dnum AS ControllingDepartment,
    e.Lname AS ManagerlastName,
    e.Address AS ManagerAddress
    FROM Project p
    INNER JOIN Department d ON Dnum=Dnumber AND Plocation="Houston"
    INNER JOIN Employee e ON d.Mgr_ssn=e.Ssn;


#Q7
#Retrieve a list of employees and the projects they are working on, 
#ordered by department and, within each department, ordered alphabetically 
#by the first name then by last name.

    select e.Dno,e.Fname,e.Lname,w.Pno FROM Works_on w
    INNER JOIN Employee e ON w.Essn=e.Ssn
    ORDER BY e.Dno,e.Fname,e.Lname,w.Pno;


#Q8
#8)  Retrieve the names of all employees who do not have supervisors.

    SELECT Concat(Fname,' ',Lname) 
    FROM Employee
    WHERE Super_ssn IS NULL;

#Q9
#Retrieve the names of all employees whose 
#supervisor’s supervisor has ‘987654321’ for Ssn.

    SELECT CONCAT(Fname,' ',Lname)
    FROM Employee
    Where Super_ssn IN 
    (SELECT Ssn
    FROM Employee
    Where Super_ssn=987654321); 


#Q10
    
#Retrieve  the department name, manager name, and 
#manager salary for every department.
   SELECT Dnumber,
    CONCAT(e.Fname,' ',e.Lname),
    e.salary
    FROM Department d 
    INNER JOIN Employee e ON d.Mgr_ssn=e.Ssn;


#Q11

#Retrieve the employee name, supervisor name, 
#and employee salary for each employee who works 
#in the ‘Research’ department.


 
    SELECT Fname AS Employee,
    (SELECT CONCAT(Fname,' ',Lname)
        FROM Employee
        WHERE Ssn=
        (SELECT Super_ssn 
            FROM Employee 
            WHERE Fname=Employee)) AS Supervisor, 
    Salary as employeeSalary
    FROM Employee 
    WHERE Dno IN
            (SELECT Dnumber
             FROM Department 
             WHERE Dname="Research"  );


#Q12

#Retrieve the project name, controlling department name, 
#number of employees, and total hours worked per week on 
#the project for each project.

 
    

    select p.Pname AS ProjectName,
    d.Dname AS ControllingDepartment,
    count(w.Pno) AS numberOfEmployees,
    sum(w.Hours) AS numberOfHours 
    FROM Project p 
    INNER JOIN Works_on w ON Pnumber=Pno 
    INNER JOIN Department d ON p.Dnum=d.Dnumber
    group by Pno;



#Q13
  
#Retrieve the project name, controlling department name, 
#number of employees, and total hours worked per week on 
#the project for each project with more than one employee working on it.

 
    select p.Pname AS ProjectName,
    d.Dname AS ControllingDepartment,
    count(w.Pno) AS numberOfEmployees,
    sum(w.Hours) AS numberOfHours 
    FROM Project p 
    INNER JOIN Works_on w ON Pnumber=Pno 
    INNER JOIN Department d ON p.Dnum=d.Dnumber
    group by Pno
    Having Count(w.Pno)>1;    



#Q14 FOR ANY PROJECT HANDLED BY Dept5
   
#Find the names of employees who work on all the 
#projects controlled by department number 5.

    SELECT CONCAT(Fname,' ',Lname)
    FROM Employee 
    WHERE Ssn IN 
    (Select Essn from Works_on
        INNER Join Project ON Pnumber=Pno and Dnum=5);

#Q14 FOR ALL PROJECTS Handled BY DEPT5

    select Concat(Fname,' ',Lname) AS byDept5
    From Employee
    WHERE Ssn In   
    (Select Essn 
    From Works_on 
    inner join Project on Pnumber=Pno and Dnum=5 
    group by Essn 
    having Count(Essn)=
    (Select Count(*) from Project where Dnum=5));



#Q15


#Retrieve the names of all employees in department 5 who work 
#more than 10 hours per week on the ProductX project.

   
    select CONCAT(e.Fname,' ',e.Lname) AS EMPLOYEENAME 
    From Employee e 
    inner join Works_on w on w.Essn=e.Ssn and w.Hours>10 
    INNER JOIN Project p ON p.Pnumber=w.Pno and p.Dnum=5
    where Pname="ProductX";


#Q16


#List the names of all employees who have a dependent with the same first name as themselves.
   select CONCAT(e.Fname,' ',e.Lname) As Employee 
    From Employee e 
    Inner Join Dependent d 
    ON d.Essn = e.Ssn and e.Fname=d.Dependent_name;


#Q17

#Find the names of all employees who are directly supervised by ‘Franklin Wong’.
     
    SELECT CONCAT(Fname,' ',Lname) AS SuperVisedByFranklinWong 
    FROM Employee
    WHERE Super_ssn= 
    (SELECT Ssn From Employee Where Concat(Fname,' ',Lname)="Franklin Wong"); 
    

#Q18


#For each project, list the project name and the total hours 
#per week (by all employees) spent on that project.
 


     select p.Pname AS ProjectName,
     sum(w.Hours) AS TotalHours 
     From Project p 
     Inner JOIN Works_on w on p.Pnumber=w.Pno 
     group by Pno;

#19)  Retrieve the average salary of all female employees.

    SELECT AVG(salary) 
    FROM Employee 
    WHERE sex='F';
