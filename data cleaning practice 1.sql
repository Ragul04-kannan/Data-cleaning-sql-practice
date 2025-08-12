create table cust
like customer;

insert cust
select * from customer;

select * from cust;

select *, row_number() over(
partition by customer_id, 'name', address, city, state, zipcode, country) as row_num
from cust;

with dup_cte as
(
select *, row_number() over(
partition by customer_id, 'name', address, city, state, zipcode, country) as row_num
from cust
)
select * from dup_cte
where row_num > 1;

SET SQL_SAFE_UPDATES = 1;

with dup_cte as
(
select *, row_number() over(
partition by customer_id, 'name', address, city, state, zipcode, country) as row_num
from cust
)
delete from dup_cte
where row_num > 1;

SET SQL_SAFE_UPDATES = 0;
-- Then run your DELETE query


DELETE FROM cust
WHERE customer_id IN (
  SELECT customer_id FROM (
    SELECT customer_id,
           ROW_NUMBER() OVER (
             PARTITION BY customer_id, name, address, city, state, zipcode, country
             ORDER BY customer_id
           ) AS row_num
    FROM cust
  ) AS ranked
  WHERE row_num > 1
);

with dup_cte as
(
select *, row_number() over(
partition by customer_id, 'name', address, city, state, zipcode, country) as row_num
from cust
)
select * from dup_cte
where row_num > 1;

select * from cust;

select * from cust
where country = 'USA';

update cust 
set country = 'US'
where country like 'USA';

select country from cust;


