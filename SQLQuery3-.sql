create database db_triggers
use db_triggers

create table tbl_Student 
(
Id int primary key identity, 
Name varchar(50), 
Gender varchar(50), 
Class int, 
fees int
);
select * from tbl_Student;
insert into tbl_Student values('Osama','Male',10,4000);
insert into tbl_Student values('Anum','Female',9,3500);
insert into tbl_Student values('Talha','Male',8,3000);
insert into tbl_Student values('Maheen','Female',10,4000);
insert into tbl_Student values('Abdul','Male',9,3500);
insert into tbl_Student values('Mushtaq','Male',5,3000);
insert into tbl_Student values('Anas','Male',7,3000);
insert into tbl_Student values('Muneer','Male',8,4000);
insert into tbl_Student values('Momina','Female',9,3000);
insert into tbl_Student values('Aslam','Male',7,4000);
insert into tbl_Student values('Mumtaz','Female',6,3000);
insert into tbl_Student values('ali','male',9,7000);
insert into tbl_Student values('huzaifa','male',5,9000);
insert into tbl_Student values('kamil','male',6,9000);
insert into tbl_Student values('jamil','male',8,9000);

insert into tbl_Student values('KOMAL','female',7,10000);
insert into tbl_Student values('arslan','male',7,10000);

insert into tbl_Student values('mahnoor','female',5,20000);
insert into tbl_Student values('faizan','male',9,20000);

select*from tbl_Student;
delete from tbl_Student where id = 2
select * from tbl_Student
SELECT * 
FROM tbl_Student 
WHERE fees<20000 and fees>100;
Select* From tbl_Student
where name like '%Ali%';
select*from tbl_Student where id=5;
update tbl_Student set Name = 'haris' where id = 3;
delete from tbl_Student where id=2;
select*from tbl_Student where id=2;
select sum(fees) from tbl_Student;
select AVG(fees) from tbl_Student;
select Max(fees) from tbl_Student;
create table tbl_Student_Audit
(
Audit_Id int primary key identity, 
Audit_Info varchar(max)
);

select * from tbl_Student_Audit;
select * from tbl_Student;

-- CREATING AFTER INSERT TRIGGER
create trigger tr_Student_forinsert
on tbl_Student
after insert
as
begin
	select * from inserted
end

drop trigger tr_Student_forinsert_1
create trigger tr_Student_forinsert_1
on tbl_Student
after insert
as
begin
	print'the row is inserted';
end



-- CREATING AFTER DELETE TRIGGER
create trigger tr_Student_forDelete
on tbl_Student
after delete
as
begin
	select * from deleted
end
drop trigger tr_Student_forUpdate
-- CREATING AFTER UPDATE TRIGGER
create trigger tr_Student_forUpdate
on tbl_Student
after update
as
begin
	select * from inserted
	select * from deleted
end

update tbl_student set Name = 'Ali', Gender = 'Male'
where id = 14;

delete from tbl_Student where id = 9;
delete from tbl_Student where id = 10;
delete from tbl_Student where id = 13;

-- VIEWING THE SQL QUERY OF TRIGGER
sp_helptext tr_Student_audit_forinsert;

-- CREATING THE AFTER INSERT TRIGGER AND SEND TO DATA TO AUDIT TABLE 
-- AFTER INSERT EVENT OCCURS

CREATE trigger tr_Student_audit_forinsert
on tbl_Student
after insert
as
begin
	Declare @id int
	Select @id = id from inserted
	insert into tbl_Student_Audit
values('Student with id ' + Cast(@id as varchar(50)) + ' is added at ' + Cast(GETDATE() as varchar(50)));
end
select * from tbl_Student
 select * from tbl_Student_Audit
-- CREATING THE AFTER DELETE TRIGGER AND SEND TO DATA TO AUDIT TABLE 
-- AFTER DELETE EVENT OCCURS

create trigger tr_Student_audit_forDelete
on tbl_Student
after delete
as
begin
	Declare @id int
	Select @id = id from deleted
	insert into tbl_Student_Audit
values('Existing Student with id ' + Cast(@id as varchar(50)) + ' is deleted at ' + Cast(GETDATE() as varchar(50)));
end

--instead of tiggers--
create table Tbl_Customer 
(
Id int primary key, 
Name varchar(50), 
Gender varchar(20), 
City varchar(30), 
ContactNo varchar(50)
);

select * from Tbl_Customer;

insert into Tbl_Customer values(1,'Ali','Male','Hyderabad','03335465678');
insert into Tbl_Customer values(2,'Anum','Female','Karachi','03225465678');
insert into Tbl_Customer values(3,'Osama','Male','Sukkur','03135468778');
insert into Tbl_Customer values(4,'Amna','Female','Hyderabad','03005465678');
insert into Tbl_Customer values(5,'Affan','Male','Karachi','03135465678');
insert into Tbl_Customer values(6,'Anas','Male','Hyderabad','03135468774');
insert into Tbl_Customer values(7,'Usman','Male','Karachi','03335468774');
insert into Tbl_Customer values(8,'ahmad','Male','Karachi','03039468774');
insert into Tbl_Customer values(9,'ali','Male','Karachi','03039468788');
insert into Tbl_Customer values(10,'afra','Male','Lahore','03039468701');

-- CREATING AUDIT TABLE FOR CUSTOMER
create table Customer_Audit_table 
(
Audit_Id int primary key identity,
Audit_Information varchar(max)
);

select * from Customer_Audit_table;
select * from Tbl_Customer

-- CREATING INSTEAD OF INSERT TRIGGER WHICH PREVENTS THE INSERTION
create trigger tr_Customer_InsteadOf_Insert
on Tbl_student 
instead of insert
as
begin
    print 'You are not allowed to insert data in this table !!'
end


drop trigger tr_Customer_InsteadOf_Insert;
disable trigger tr_Customer_InsteadOf_Insert on Tbl_student
disable trigger tr_Customer_InsteadOf_Insert_Audit on Tbl_Customer

-- CREATING INSTEAD OF INSERT TRIGGER WHICH INSERTS THE DATA IN AUDIT TABLE

create trigger tr_Customer_InsteadOf_Insert_Audit
on Tbl_Customer
instead of insert
as
begin
	insert into Customer_Audit_table values('SomeOne tries to insert data in customer table at: ' + cast(getdate() as varchar(50)));
end

-- CREATING INSTEAD OF UPDATE TRIGGER WHICH PREVENTS THE UPDATION
create trigger tr_Customer_InsteadOf_Update
on Tbl_Customer
instead of update
as
begin
	print 'You are not allowed to update data in this table !!'
end

drop trigger tr_Customer_InsteadOf_Update;

-- CREATING INSTEAD OF UPDATE TRIGGER WHICH INSERTS THE A ROW IN AUDIT TABLE WHEN SOMEONE TRIES TO UPDATE DATA

create trigger tr_Customer_InsteadOf_Update_Audit
on Tbl_Customer
instead of update
as
begin
	insert into Customer_Audit_table values('SomeOne tries to update data in customer table at: ' + cast(getdate() as varchar(50)));
end

update Tbl_Customer set Name = 'Asif' where id = 6;

-- CREATING INSTEAD OF DELETE TRIGGER WHICH PREVENTS THE DELETION
create trigger tr_Customer_InsteadOf_Delete
on Tbl_Customer
instead of delete
as
begin
	print 'You are not allowed to delete anything in this table !!'
end

drop trigger tr_Customer_InsteadOf_Delete;

-- CREATING INSTEAD OF DELETE TRIGGER WHICH INSERTS A ROW IN AUDIT TABLE WHEN SOMEONE TRIES TO DELETE DATA FROM CUSTOMER TABLE 

create trigger tr_Customer_InsteadOf_Delete_Audit
on Tbl_Customer
instead of delete
as
begin
	insert into Customer_Audit_table values('SomeOne tries to delete data from customer table at: ' + cast(getdate() as varchar(50)));
end

delete from Tbl_Customer where id = 6;

-- VIEWING THE TRIGGER
sp_helptext tr_Customer_InsteadOf_Delete_Audit;


--- SQL Query For Using Instead Of Delete Trigger With Views---

-- In this example when we tried to delete the data from the view then 
-- that data also deletes from the 2 parent tables.

create table Employee_Personal_Details
(
EmpID int, 
FirstName varchar(50), 
LastName varchar(50),
[Address] varchar(100)
);

insert into Employee_Personal_Details values(1,'Ali','Khan','Latifabad No:8');
insert into Employee_Personal_Details values(2,'Anas','Farhan','Latifabad No:6');
insert into Employee_Personal_Details values(3,'Zain','Fareed','Latifabad No:7');
insert into Employee_Personal_Details values(4,'Noman','Khan','Latifabad No:2');

create table Employee_Salary_Details 
(
EmpID int, 
Designation varchar(50),
Salary int
);

select * from Employee_Salary_Details;

insert into Employee_Salary_Details values(1,'Accountant',35000);
insert into Employee_Salary_Details values(2,'Manager',45000);
insert into Employee_Salary_Details values(3,'Admin',50000);
insert into Employee_Salary_Details values(4,'Incharge',25000);

select * from Employee_Personal_Details;
select * from Employee_Salary_Details;

create view vW_Employees
as
select A.EmpID, A.FirstName, A.LastName, B.Designation, B.Salary
from Employee_Personal_Details as A
inner join Employee_Salary_Details as B
on A.EmpID = B.EmpID;

select * from vW_Employees;

delete from vW_Employees where EmpID = 4;

create trigger tr_Employee_Salary_Delete
on vW_Employees
instead of delete
as
begin
	delete from Employee_Personal_Details where EmpID in
	(select EmpID from deleted)
	delete from Employee_Salary_Details where EmpID in
	(select EmpID from deleted)

end



---- DDL COMMAND ----

-- CREATING DDL TRIGGER FOR CREATE TABLE
create trigger tr_ddl_tables
on database
for CREATE_TABLE
as
begin
	print 'You created a new table !!';
end

-- CREATING DDL TRIGGER FOR ALTER THE TABLE
create trigger tr_ddl_tables_alter
on database
for ALTER_TABLE
as
begin
	print 'You have just altered a table !!';
end

-- CREATING DDL TRIGGER FOR DROP THE TABLE
create trigger tr_ddl_tables_drop
on database
for DROP_TABLE
as
begin
	print 'You have just dropped a table !!';
end

create trigger tr_ddl_tables_drop1
on database
for DROP_TABLE
as
begin
	print 'You have just dropped a table 1 !!';
end

create table my_tbl (id int);

select * from my_tbl;

alter table my_tbl add name varchar(50);

drop table my_tbl;



-- CREATING DDL TRIGGER FOR CREATING THE STORED PROCEDURE
create trigger tr_ddl_storedProcedure_create
on database
for CREATE_PROCEDURE
as
begin
	print 'You have just created a stored procedure !!';
end

-- CREATING DDL TRIGGER FOR ALTERING THE STORED PROCEDURE
create trigger tr_ddl_storedProcedure_alter
on database
for ALTER_PROCEDURE
as
begin
	print 'You have just Altered a stored procedure !!';
end


-- CREATING DDL TRIGGER FOR DROPPING THE STORED PROCEDURE
create trigger tr_ddl_storedProcedure_drop
on database
for DROP_PROCEDURE
as
begin
	print 'You have just dropped a stored procedure !!';
end



alter procedure sp_New
as
begin
	print 'This is my new stored procedure 1 !!';
end


drop procedure sp_New;