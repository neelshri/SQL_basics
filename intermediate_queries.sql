-- Print details of shipments (sales) where amounts are > 2,000 and boxes are <100?
select * from sales;
select * from sales where amount>2000 and boxes<100;

-- How many shipments (sales) each of the sales persons had in the month of January 2022?
select * from sales;
select * from people;

select s.spid, p.Salesperson ,sum(s.Amount) January_Sales from sales s
join people p
on s.SPID= p.SPID
where month(SaleDate)=01 and year(saledate)=2022
group by s.spid
order by 1;

-- Which product sells more boxes? Milk Bars or Eclairs? Answer: Eclairs

select * from sales ;
select * from products;

select s.pid, pr.product, sum(s.boxes) total_boxes_sold from sales s
join products pr on s.PID = pr.pid
where pr.product in ('Milk Bars' , 'Eclairs') 
group by pr.pid;

-- Which product sold more boxes in the first 7 days of February 2022? Milk Bars or Eclairs? Answer: Eclairs
select * from sales ;
select * from products;
select pid ,Saledate from sales order by saledate;

select s.pid, pr.product, sum(s.boxes) total_boxes_sold from sales s
join products pr on s.PID = pr.pid
where pr.product in ('Milk Bars' , 'Eclairs') 
and s.saledate between '2022-02-01' and '2022-02-07'
group by pr.pid;


-- Which shipments had under 100 customers & under 100 boxes? Did any of them occur on Wednesday?
select  * from sales
where customers <100 and boxes < 100 and weekday(saledate)= 2
order by saledate desc;


