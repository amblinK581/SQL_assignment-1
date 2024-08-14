/* HW#1 Query #1:

Step #1: Compute for each cust, min(quant), max(quant), ave(quant) & save the result of the query.

Step #2: Using the output of step #1 and 'sales' table, capture the details for (cust, min(quant)) & save the result of the query.

Step #3: Using the output of step #2 and 'sales' table, capture the details for (cust, max(quant)) and produce the final output.

*/

-- Step #1: Compute for each cust, min(quant), max(quant), ave(quant)
with q1 as
(
    select cust, min(quant) min_q, max(quant) max_q, avg(quant) avg_q
        from sales
    group by cust
),
-- Step #2: capture the details ('prod', 'date', 'state') for (cust, min(quant))
q2 as
(
    select q1.cust, q1.min_q, s.prod min_prod, s.date min_date, s.state min_st, q1.max_q, q1.avg_q
	    from q1, sales s
	where q1.cust = s.cust and q1.min_q = s.quant
),
-- Step #3: capture the details ('prod', 'date', 'state') for (cust, max(quant))
q3 as
(
    select q2.cust, q2.min_q, q2.min_prod, q2.min_date, q2.min_st, q2.max_q, s.prod max_prod, s.date max_date, s.state max_st, q2.avg_q
        from q2, sales s
	where q2.cust = s.cust and q2.max_q = s.quant
)
select * from q3 order by cust

