create table departments(
	dept_no varchar(20) primary key, 
	dept_name varchar(50) not null
);

select * from dept_emp;

create table Titles(
	title_id varchar(20) primary key,
	title varchar(50)
);

create table Employees(
	emp_no serial primary key,
	emp_title_id varchar(20),
	birth_date date not null,
	first_name varchar(50) not null,
	last_name varchar(50) not null,
	sex varchar(50) not null,
	hire_date date not null,
	foreign key (emp_title_id) references titles(title_id) 
);

alter table Employees alter column birth_date type varchar(20);

select * from salaries;

create table dept_emp(
	emp_no int not null,
	dept_no varchar(20) not null,
	foreign key (dept_no) references departments(dept_no),
	foreign key (emp_no) references Employees(emp_no)
);

create table dept_manager(
	dept_no varchar(20) not null,
	emp_no int not null,
	foreign key (dept_no) references departments(dept_no),
	foreign key (emp_no) references employees(emp_no)
);

create table salaries(
	emp_no int not null, 
	salary int not null,
	foreign key (emp_no) references employees(emp_no)
);
--List of employee number, last name, first name, sex, and salary of each employee.
select e.emp_no, e.last_name, e.first_name, e.sex, s.salary from employees e left join salaries s 
on e.emp_no=s.emp_no;

--List the first name, last name, and hire date for the employees who were hired in 1986.
select first_name, last_name, hire_date from employees where hire_date like '%1986%';

--List the manager of each department along with their department number,
--department name, employee number, last name, and first name
select dm.dept_no,  d.dept_name, dm.emp_no, e.last_name, e.first_name from dept_manager dm 
left join employees e on dm.emp_no = e.emp_no
left join departments d on dm.dept_no = d.dept_no;

--List the department number for each employee along with that employee’s employee number, last name, first name, 
--and department name.
select de.dept_no, e.emp_no, e.last_name, e.first_name, d.dept_name from employees e left join dept_emp de
on e.emp_no=de.emp_no left join departments d on de.dept_no = d.dept_no;

select de.dept_no, de.emp_no, e.last_name, e.first_name, d.dept_name from employees e, dept_emp de,departments d
where e.emp_no=de.emp_no and de.dept_no = d.dept_no;

---List first name, last name, and sex of each employee whose first name is 
--Hercules and whose last name begins with the letter B.
select first_name, last_name, sex from employees where first_name = 'Hercules' and last_name like 'B%';

---List each employee in the Sales department, including their employee number, last name, and first name.
select d.dept_name, e.emp_no,e.last_name, e.first_name 
from employees e, dept_emp de, departments d  where e.emp_no=de.emp_no and de.dept_no=d.dept_no
and d.dept_name = 'Sales';

---List each employee in the Sales and Development departments, including their employee number, 
---last name, first name, and department name.
select d.dept_name, e.emp_no, e.last_name, e.first_name
from employees e, dept_emp de, departments d where e.emp_no=de.emp_no and d.dept_no=de.dept_no 
and d.dept_name in ('Sales','Development');

select d.dept_name, e.emp_no, e.last_name, e.first_name
from departments d left join dept_emp de on d.dept_no=de.dept_no left join employees e on
de.emp_no = e.emp_no where d.dept_name in ('Sales','Development');

---List the frequency counts, in descending order, 
---of all the employee last names (that is, how many employees share each last name).

select last_name, count(last_name) frequency_counts from employees
group by last_name order by last_name desc;


