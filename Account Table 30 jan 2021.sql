use WFASql
--Create a TblCustomer table
create table TblCustomer
(
CustomerID varchar(20) not null primary key,
CustomerName varchar(20),
DOB Date,
City varchar(20)
)


--insert into the TblCustomer table

insert into TblCustomer values ('123456', 'David Letterman', '04-Apr-1949', 'Hartford');
insert into TblCustomer values ('123457', 'Barry Sanders', '12-Dec-1967','Detroit');
insert into TblCustomer values ('123458', 'Jean-Luc Picard', '9-Sep-1940', 'San Francisco');
insert into TblCustomer values ('123459', 'Jerry Seinfeld', '23-Nov-1965','New York City');
insert into TblCustomer values ('123460', 'Fox Mulder', '05-Nov-1962', 'Langley');
insert into TblCustomer values ('123461', 'Bruce Springsteen', '29-Dec-1960','Camden');
insert into TblCustomer values ('123462', 'Barry Sanders', '05-Aug-1974','Martha''s Vineyard');
insert into TblCustomer values ('123463', 'Benjamin Sisko', '23-Nov-1955','San Francisco');
insert into TblCustomer values ('123464', 'Barry Sanders', '19-Mar-1966','Langley');
insert into TblCustomer values ('123465', 'Martha Vineyard', '19-Mar-1963','Martha''s Vineyard');

select * from TblCustomer

--Create TblAccountType

create table TblAccountType
(
TypeCode int not null primary key,
TypeDesc varchar(20)
)


-- insert into TblAccountType

insert into tblAccountType values (1, 'Checking');
insert into tblAccountType values (2, 'Saving');
insert into tblAccountType values (3, 'Money Market');
insert into tblAccountType values (4, 'Super Checking');

select * from TblAccountType

--Create table TblAccount

create table TblAccount
(
CustomerID varchar(20) foreign key references TblCustomer(CustomerID),
AccountNumber varchar(20) not null primary key,
AccountTypeCode int foreign key references TblAccountType(TypeCode),
DateOpened date default getDate(),
Balance float
)




--insert into table TblAccount

insert into tblAccount values('123456', '123456-1', 1, '04-Apr-1993', 2200.33);
insert into tblAccount values('123456', '123456-2', 2, '04-Apr-1993', 12200.99);
insert into tblAccount values('123457', '123457-1', 3, '01-JAN-1998', 50000.00);
insert into tblAccount values('123458', '123458-1', 1, '19-FEB-1991', 9203.56);
insert into tblAccount values('123459', '123459-1', 1, '09-SEP-1990', 9999.99);
insert into tblAccount values('123459', '123459-2', 1, '12-MAR-1992', 5300.33);
insert into tblAccount values('123459', '123459-3', 2, '12-MAR-1992', 17900.42);
insert into tblAccount values('123459', '123459-4', 3, '09-SEP-1998', 500000.00);
insert into tblAccount values('123460', '123460-1', 1, '12-OCT-1997', 510.12);
insert into tblAccount values('123460', '123460-2', 2, '12-OCT-1997', 3412.33);
insert into tblAccount values('123461', '123461-1', 1, '09-MAY-1978', 1000.33);
insert into tblAccount values('123461', '123461-2', 2, '09-MAY-1978', 32890.33);
insert into tblAccount values('123461', '123461-3', 3, '13-JUN-1981', 51340.67);
insert into tblAccount values('123462', '123462-1', 1, '23-JUL-1981', 340.67);
insert into tblAccount values('123462', '123462-2', 2, '23-JUL-1981', 5340.67);
insert into tblAccount values('123463', '123463-1', 1, '1-MAY-1998', 513.90);
insert into tblAccount values('123463', '123463-2', 2, '1-MAY-1998', 1538.90);
insert into tblAccount values('123464', '123464-1', 1, '19-AUG-1994', 1533.47);
insert into tblAccount values('123464', '123464-2', 2, '19-AUG-1994', 8456.47);

select * from TblAccount







--1.	Print customer id and balance of customers who have at least $5000 in any of their accounts. 
			
			select tb.CustomerId, tac.Balance
			from TblCustomer tb join TblAccount tac
			on tb.CustomerID=tac.CustomerID
			where Balance <= 5000.0

--2.	Print names of customers whose names begin with a ‘B’. 
			
			select CustomerName
			from TblCustomer
			where CustomerName like 'B%'

--3.	Print all the cities where the customers of this bank live. 

			Select City, CustomerName 
			from TblCustomer
			

--4.	Use IN [and NOT IN] clauses to list customers who live in [and don’t live in] San Francisco or Hartford. 

			select CustomerName,City
			from TblCustomer 
			where City IN('Hartford','San Francisco')

			select CustomerName,City
			from TblCustomer 
			where City Not IN('Hartford','San Francisco')

			

--5.	Show name and city of customers whose names contain the letter 'r' and who live in Langley. 
			
			select CustomerName ,City
			from TblCustomer 
			where CustomerName like '%r%' AND City='Langley'

--6.	How many account types does the bank provide? 
			
			select count(TypeDesc) as TypesOfAcoount
			from TblAccountType

--7.	 Show a list of accounts and their balance for account numbers that end in '-1' 
			
			select AccountNumber,Balance
			from TblAccount 
			where AccountNumber like '%-1'

			select acc.AccountNumber, acctype.TypeDesc,acc.Balance
			from TblAccountType acctype join TblAccount acc
			on acctype.TypeCode=acc.AccountTypeCode
			where AccountNumber like '%-1'

--8.	Show a list of accounts and their balance for accounts opened on or after July 1, 1990. 
				
			select tbac.AccountNumber, actype.TypeDesc,tbac.Balance,tbac.DateOpened
			from TblAccountType actype join TblAccount tbac
			on actype.TypeCode=tbac.AccountTypeCode
			where tbac.DateOpened >= '1-July-1990'


--9.	If all the customers decided to withdraw their money, how much cash would the bank need? 
			
			select sum(balance) as AmountBankNeed
			from TblAccount


--10.	List account number(s) and balance in accounts held by ‘David Letterman’. 
			
			select AccountNumber,Balance
			from TblAccount acc join TblCustomer cst
			on acc.CustomerID=cst.CustomerID
			where cst.CustomerName='David Letterman'


--11.	List the name of the customer who has the largest balance (in any account). 
			
	select CustomerName from TblCustomer 
	where CustomerID= (select customerid from TblAccount where Balance =(select Max(Balance) from TblAccount))

--12.	List customers who have a ‘Money Market’ account. 
				select cst.CustomerName
				from TblCustomer cst inner join TblAccount acc on  cst.CustomerID=acc.CustomerID 
				join TblAccountType actype on  actype.TypeCode=acc.AccountTypeCode
				where actype.TypeDesc='Money Market'

--13.	Produce a listing that shows the city and the number of people who live in that city. 
				select City, Count(CustomerName) as NoOfPeople
				from TblCustomer
				group by City

--14.	Produce a listing showing customer name, the type of account they hold and the balance in that account.(Make use of Joins)
				select tsc.CustomerName, actype.TypeDesc, acc.Balance
				from TblCustomer tsc inner join TblAccount acc on  tsc.CustomerID=acc.CustomerID 
				join TblAccountType actype on  actype.TypeCode=acc.AccountTypeCode


--15.	Produce a listing that shows the customer name and the number of accounts they hold.(Make use of Joins)

				select tbc.CustomerName,Count(tba.AccountTypeCode) as NoOfAccounts
				from TblCustomer tbc join TblAccount tba
				on tbc.CustomerID=tba.CustomerID
				group by CustomerName
				

--16.	 Produce a listing that shows an account type and the average balance in accounts of that type.(Make use of Joins)
				select tba.TypeDesc, Avg(tb.Balance) as AvgBalance
				from TblAccount tb join TblAccountType tba
				on tb.AccountTypeCode=tba.TypeCode
				group by tba.TypeDesc


