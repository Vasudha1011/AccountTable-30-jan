use WFASql

--Trigger

select * from Employee

create table Employee(
EmpId int not null primary key identity(1,1),
EmpName varchar(20),
Salary float
)
insert into Employee values('lavanya',3343.5)
insert into Employee values('Amisha',3343.5)
insert into Employee(empname,Salary) values('vasudha',4674.5)
insert into Employee values('srikanth',3343.5)


create table Pastemp(
empid int ,
empname varchar(20),
esal float
)
 
create  trigger trgAfterUpdate 
on Employee  
after update
as 
declare @oldeid int,
 @oldename varchar(20),
 @oldesal float
 begin
 select @oldeid=inserted.empid,@oldename=inserted.EmpName,@oldesal=inserted.Salary from inserted
 insert into Pastemp(empid,empname,esal) values(@oldeid,@oldename,@oldesal)
 print 'After update trigger fired on emptable'
 end


 update Employee set EmpName='Niharika' where EmpId=3

 select * from Employee

  select * from  PastEmp

 --drop trigger trgAfterUpdate


 



