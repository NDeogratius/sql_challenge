-- Create database
CREATE DATABASE sql_challenge;
GO
-- Create Schema
CREATE SCHEMA person;
-- Create tables without foreign keys first
GO
CREATE TABLE person.departments (
    dept_no varchar(5) NOT NULL,
    dept_name varchar(50),
    CONSTRAINT PK_departments PRIMARY KEY (dept_no)
);

CREATE TABLE person.titles (
    title_id varchar(5) NOT NULL,
    title varchar(30),
    CONSTRAINT PK_titles PRIMARY KEY (title_id)
);

CREATE TABLE person.salaries (
    emp_no integer PRIMARY KEY,
    salary numeric
);

-- Create tables with foreign keys after referenced tables exist
CREATE TABLE person.employees (
    emp_no serial PRIMARY KEY,
    emp_title_id varchar(5),
    birth_date date,
    first_name varchar(30),
    last_name varchar(30),
    sex varchar(2),
    hire_date date,
    CONSTRAINT FK_employees_titles FOREIGN KEY (emp_title_id) REFERENCES person.titles (title_id),
    CONSTRAINT FK_employees_salaries FOREIGN KEY (emp_no) REFERENCES person.salaries (emp_no)
);

CREATE TABLE person.dept_emp (
    emp_no integer NOT NULL,
    dept_no varchar(5) NOT NULL,
    CONSTRAINT PK_dept_emp PRIMARY KEY (emp_no, dept_no),
    CONSTRAINT FK_dept_emp_employees FOREIGN KEY (emp_no) REFERENCES person.employees (emp_no),
    CONSTRAINT FK_dept_emp_departments FOREIGN KEY (dept_no) REFERENCES person.departments (dept_no)
);

CREATE TABLE person.dept_manager (
    dept_no varchar(5) NOT NULL,
    emp_no integer NOT NULL,
    CONSTRAINT PK_dept_manager PRIMARY KEY (dept_no, emp_no),
    CONSTRAINT FK_dept_manager_employees FOREIGN KEY (emp_no) REFERENCES person.employees (emp_no),
    CONSTRAINT FK_dept_manager_departments FOREIGN KEY (dept_no) REFERENCES person.departments (dept_no)
);

COPY person.departments (dept_no, dept_name) FROM 'PATH_TO_FILE/departments.csv' WITH (FORMAT CSV, HEADER true);
COPY person.titles(title_id, title) FROM 'PATH_TO_FILE\titles.csv' WITH (FORMAT CSV, HEADER true);
COPY person.salaries(emp_no, salary) FROM 'PATH_TO_FILE\salaries.csv' WITH (FORMAT CSV, HEADER true);
COPY person.employees(emp_no, emp_title_id, birth_date, first_name, last_name, sex, hire_date) FROM 'PATH_TO_FILE\employees.csv' WITH (FORMAT CSV, HEADER true);
COPY person.dept_emp(emp_no, dept_no) FROM 'PATH_TO_FILE\dept_emp.csv' WITH (FORMAT CSV, HEADER true);
COPY person.dept_manager(dept_no, emp_no) FROM 'PATH_TO_FILE\dept_manager.csv' WITH (FORMAT CSV, HEADER true);