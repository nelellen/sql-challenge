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