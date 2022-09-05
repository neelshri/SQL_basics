-- view the sales data along with the person's name who made that sale

select * from sales;
select * from people;

select s.SaleDate, s.Amount, p.Salesperson, s.SPID
from sales s
join people p on s.SPID= p.SPID;

-- product name that we are selling in this shipment

select * from products;
select * from sales;

select s.Amount , pr.PID, pr.Product
from sales s join products pr on s.PID= pr.PID
order by 3;

-- join multiple tables
select * from geo;
select * from products;
select * from people;
select * from sales;

select p.Location, p.Team, p.Salesperson, pr.Product, s.Amount
from sales s 
join products pr on s.pid = pr.pid
join people p on s.spid = p.spid; 

-- i saw that the result for the above query had an employee with no team assigned
-- hence, I check and confirmed the same using the below query

select Salesperson, team from people where Salesperson='Rafaelita Blaksland';

-- what is the total amt coming in from a team and category 

select * from products;
select * from people;

select pr.Category,p.team , sum(s.Amount),sum(s.Boxes)  from sales s
join people p on s.SPID= p.SPID
join products pr on s.PID = s.PID
where p.team <> ''
group by p.team, pr.Category
;

-- todal amounts by prduct show just the top 10 products

select * from products;
select * from sales;

select  pr.product, sum(s.amount) Total_AMT from sales s
join products pr on pr.pid = s.pid 
group by pr.product
order by sum(s.amount) asc
limit 10 ;

