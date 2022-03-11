-- Creating each of the six tables (header only, as the rest will be imported)
-- (I used the ERD image I created as reference to what to import as the instrutions doesn't exactly tell us what csv to import first)
create table department_manager (
	dept_no VARCHAR(30) not null,
	emp_no INT
);

create table departments (
	dept_no VARCHAR(30) not null,
	dept_name VARCHAR(30) not null,
	primary key (dept_no)
);

create table employees (
	emp_no INT,
	emp_title_id VARCHAR(30) not null,
	birth_date VARCHAR(30) not null,
	first_name VARCHAR(30) not null,
	last_name VARCHAR(30) not null,
	sex VARCHAR(30) not null,
	hire_date VARCHAR(30) not null,
	primary key (emp_no)
);

create table department_employees (
	emp_no INT,
	dept_no VARCHAR(30) not null,
	foreign key (dept_no) references departments(dept_no),
	foreign key (emp_no) references employees(emp_no)
);

create table titles (
	title_id VARCHAR(30) not null,
	title VARCHAR(30) not null,
	primary key (title_id)
);

create table salaries (
	emp_no INT not null,
	salary INT not null,
	foreign key (emp_no) references employees(emp_no)
);

-- Displaying tables to demonstrate it imported correctly
-- (Showcases of each of the tables will be in the "Images" folder)
select *
from department_employees;

select *
from department_manager;

select *
from departments;

select *
from employees;

select *
from salaries;

select *
from titles;

-- Step 1: "List the following details of each employee: employee number, last name, first name, sex, and salary."
select employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
from employees
join salaries
on employees.emp_no = salaries.emp_no;

-- Step 2: "List first name, last name, and hire date for employees who were hired in 1986"
select employees.first_name, employees.last_name, employees.hire_date
from employees
where employees.hire_date between '1/1/1986' and '12/31/1986'
order by employees.hire_date; --  (This isn't necessary, but it is useful)

-- Step 3: "List the manager of each department with the following information: department number, department name, the manager's employee number, 
-- last name, first name."
select departments.dept_no, departments.dept_name, department_manager.emp_no, employees.last_name, employees.first_name
from departments
join department_manager
on departments.dept_no = department_manager.dept_no

join employees
on department_manager.emp_no = employees.emp_no;

-- Step 4: "List the department of each employee with the following information: employee number, last name, first name, and department name."
select department_employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
from department_employees
join employees
on department_employees.emp_no = employees.emp_no

join departments
on department_employees.dept_no = departments.dept_no;

-- Step 5: "List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
select employees.first_name, employees.last_name, employees.sex
from employees
where first_name = 'Hercules'
and last_name like 'B%';

-- Step 6: "List all employees in the Sales department, including their employee number, last name, first name, and department name."
select departments.dept_name, employees.last_name, employees.first_name
from department_employees
join employees
on department_employees.emp_no = employees.emp_no

join departments
on department_employees.dept_no = departments.dept_no
where departments.dept_name = 'Sales';

-- Step 7: "List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name."
select department_employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
from department_employees
join employees
on department_employees.emp_no = employees.emp_no

join departments
on department_employees.dept_no = departments.dept_no
where departments.dept_name = 'Sales' 
or departments.dept_name = 'Development';

-- Step 8: "In descending order, list the frequency count of employee last names, i.e., how many employees share each last name."
select employees.last_name,
count(employees.last_name)
from employees
group by last_name

order by
count(last_name) desc;