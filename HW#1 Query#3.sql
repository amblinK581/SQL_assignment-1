/* HW#1 Query #3:

Step #1: Calculate the sum of each product for each customer & save the result of the query.

Step #2: Using the output of step #1, find the most favorite and the least favorite product for each customer.

Step #3: Using the output of step #2 and 'q1' table, capture the details ('prod') for the most favorite product.

Step #4: Using the output of step #3 and 'q1' table, capture the details ('prod') for the least favorite product and produce the final output.

*/
-- Step #1: Calculate the sum of each product for each customer
with q1 as
(
    select cust, prod, sum(quant) total_quant
	    from sales
	group by cust, prod
	order by cust, total_quant
),
-- Step #2: Find the most favorite and the least favorite product for each customer
q2 as
(
    select q1.cust, min(q1.total_quant) min_q, max(q1.total_quant) max_q
	     from q1
	group by q1.cust
	order by q1.cust
),
-- Step #3: Capture the details(product name) of the most favorite product
q3 as
(
	select q2.cust, q1.prod most_fav_prod, q2.max_q, q2.min_q
	    from q2, q1
	where q2.cust = q1.cust and q2.max_q = q1.total_quant
	
),
-- Step #4: Capture the details(product name) of the least favorite product
q4 as
(
	select q3.cust, q3.most_fav_prod, q3.max_q, q1.prod least_fav_prod, q3.min_q
	    from q3, q1
	where q3.cust = q1.cust and q3.min_q = q1.total_quant
)
select q4.cust, q4.most_fav_prod, q4.least_fav_prod from q4


