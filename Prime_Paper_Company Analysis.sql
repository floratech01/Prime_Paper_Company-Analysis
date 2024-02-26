select * from accounts;
select * from orders;
select * from region;
select * from sales_reps;
select * from web_events;

-- • List all the accounts and all the orders and revenue generated from these
-- accounts.
select a.id, a.name AS "Account Name", SUM(o.total) AS "Total Order", SUM(o.total_amt_usd) AS "Total Revenue"
from accounts a
join orders o
on a.id = o.account_id
Group By a.id, a.name
order by "Total Revenue" desc;


-- • Select the channel, timestamp and the primary person of contact for the
-- IBM account.
select a.name, a.primary_poc, we.occurred_at, we.channel
from web_events we
join accounts a
on we.account_id = a.id
where a.name = 'IBM';


-- • Extract the Revenue generated from each region.
select r.name, SUM(o.total * o.total_amt_usd) AS "Total Revenue"
from sales_reps sr
join region r
on sr.region_id = r.id
join accounts a
on sr.id = a.sales_rep_id
join orders o
on a.id = o.account_id
group by r.name;


-- --------
-- • Which channel generated the most revenue
select we.channel, sum(total_amt_usd) AS "Total Revenue"
from web_events we
left join accounts a
on we.account_id = a.id
join orders o
on a.id = o.account_id
Group by we.channel
Order by "Total Revenue" Desc
limit 1;

-- • Identify accounts with their web channels. Include accounts that do not
-- have any web channel attached.
select Distinct(a.name), we.channel
from accounts a
left join web_events we
on a.id = we.account_id
order by we.channel Desc;

-- • Provide the Account name, and sales rep (name and id) for the associated
-- account
select a.name, sr.name, sr.id
from accounts a
left join sales_reps sr
on a.sales_rep_id = sr.id;

-- • List all accounts and the sales representatives that manage the accounts.
-- Include accounts who are not currently assigned to any sales
-- representatives.
select a.name, sr.name
from sales_reps sr
right join accounts a
on a.sales_rep_id = sr.id;

-- • Calculate the total revenue generated by all account. Include accounts
-- with no orders (if exist).
select a.name, sum(o.total_amt_usd) AS "Total Revenue"
from orders o
Right join accounts a
on o.account_id = a.id
Group by a.name
Order by "Total Revenue" Desc;

-- • What are the top 10 order generated by client accounts.
select a.name AS "Account Name", SUM(o.total)AS "Total Orders"
from orders o
left join accounts a
on o.account_id = a.id
Group by a.name
order by "Total Orders" Desc
limit 10;

-- • What are the order quantity and revenue generated from all Marketing
-- channels.
select we.channel, SUM(o.total) AS "Total Quantity", SUM(o.total_amt_usd) AS "Total Revenue"
from web_events we
left join accounts a
on we.account_id = a.id
join orders o
on a.id = o.account_id
Group by we.channel
order by "Total Revenue" desc;

-- • List the region and sales_rep along with their associated account.
select distinct(r.name) AS "Region", sr.name AS "Sales_reps", a.name AS "Account"
from accounts a
left join sales_reps sr
on a.sales_rep_id = sr.id
join region r
on sr.region_id = r.id;

-- • List all the primary person of contact for only client account's with
-- primary_poc.
select  a.name AS "Client Account Name", a.primary_poc
from accounts a
order by a.name;

-- • What is the order quantity of product ordered (standard, gloss, and
-- poster), and the website and the primary person of contact that made
-- these orders.
select  a.website, a.primary_poc, SUM(o.total) AS "Total Quantity"
from accounts a
left join orders o
on o.account_id = a.id
Group By a.website, a.primary_poc
Order by "Total Quantity" desc;

-- • What are the top 10 order generated by client accounts.
select a.name AS "Account Name", SUM(o.total)AS "Total Orders"
from orders o
left join accounts a
on o.account_id = a.id
Group by a.name
order by "Total Orders" Desc
limit 10;

-- • What are the order quantity and revenue generated from all Marketing
-- channels.
select we.channel, SUM(o.total) AS "Total Quantity", SUM(o.total_amt_usd) AS "Total Revenue"
from web_events we
left join accounts a
on we.account_id = a.id
join orders o
on a.id = o.account_id
Group by we.channel
order by "Total Revenue" desc;

-- • List the region and sales_rep along with their associated account.
select distinct(r.name) AS "Region", sr.name AS "Sales_reps", a.name AS "Account"
from accounts a
left join sales_reps sr
on a.sales_rep_id = sr.id
join region r
on sr.region_id = r.id;

-- • List all the primary person of contact for only client account's with
-- primary_poc.
select  a.name AS "Client Account Name", a.primary_poc
from accounts a
order by a.name;

-- • What is the order quantity of product ordered (standard, gloss, and
-- poster), and the website and the primary person of contact that made
-- these orders.
select  a.website, a.primary_poc, SUM(o.total) AS "Total Quantity"
from accounts a
left join orders o
on o.account_id = a.id
Group By a.website, a.primary_poc
Order by "Total Quantity" desc;


































