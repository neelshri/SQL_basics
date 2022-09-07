-- 1. What are the names of salespersons who had at least one shipment (sale) in the first 7 days of January 2022?

select * from people;
select * from sales;

select s.SPID,p.Salesperson from sales s
join people p on s.spid = p.spid
where s.saledate between '2022-01-01' and '2022-01-07' 
group by SPID
order by SPID;

-- 2. Which salespersons did not make any shipments in the first 7 days of January 2022?

select spid ,salesperson from people
where spid not in
(
select distinct spid from sales where saledate between '2022-01-01' and '2022-01-07' 
) ;


-- 3. How many times we shipped more than 1,000 boxes in each month?
 
select saledate ,sum(boxes) from sales group by saledate order by saledate;
 
select year (saledate) yearr, month(saledate) as MonthName ,count(*) 
from sales where boxes <1000
group by yearr,monthname;
 
select year(saledate) ‘Year’, month(saledate) ‘Month’, count(*) 'Times we shipped 1k boxes'
from sales
where boxes>1000
group by year(saledate), month(saledate)
order by year(saledate), month(saledate);

-- 4. Did we ship at least one box of ‘After Nines’ to ‘New Zealand’ on all the months?
select * from sales;
select * from products where product ='After Nines';
select * from geo;


select year(s.saledate),month(s.saledate), s.GeoID, pr.product , sum(s.boxes), 
	if(sum(s.boxes) >1,'yes','no') as status from sales s
				join geo g on s.geoid = g.geoid
				join products pr on s.pid =pr.pid
			where g.geo = 'New Zealand' and pr.product = 'After Nines'
		group by year(s.saledate),month(s.saledate)
order by 1;

-- _______________BELOW IS THE ALTERNATE METHOD WHICH CAN BE USED____________
-- set @product_name = 'After Nines';
-- set @country_name = 'New Zealand';

-- select year(saledate) 'Year', month(saledate) 'Month',
-- if(sum(boxes)>1, 'Yes','No') 'Status'
-- from sales s
-- join products pr on pr.PID = s.PID
-- join geo g on g.GeoID=s.GeoID
-- where pr.Product = @product_name and g.Geo = @country_name
-- group by year(saledate), month(saledate)
-- order by year(saledate), month(saledate);


-- 5. India or Australia? Who buys more chocolate boxes on a monthly basis?

select * from sales;
select * from geo;
select * from products;

-- first method . I created a seperate view because it helped me to get a direct answer of who ordered more month wise.
create view indVSaus 
as
select year(s.saledate),month(s.saledate), 
		sum(case when g.geo ='India'=1  then s.boxes else 0 end) as 'Indboxes', 
        sum(case when g.geo ='Australia'=1  then s.boxes else 0 end)as  'Ausboxes'
        from sales s
	join geo g on g.geoid =s.geoid
	where g.geo in ('India','Australia')
	group by year(s.saledate),month(s.saledate)
	;
select *, if((Indboxes>Ausboxes),'Ind','Aus') as who_ordered_more from indvsaus;

-- second method 
select year(saledate) ‘Year’, month(saledate) ‘Month’,
sum(CASE WHEN g.geo='India' = 1 THEN boxes ELSE 0 END) 'India Boxes',
sum(CASE WHEN g.geo='Australia' = 1 THEN boxes ELSE 0 END) 'Australia Boxes'
from sales s
join geo g on g.GeoID=s.GeoID
group by year(saledate), month(saledate)
order by year(saledate), month(saledate);

