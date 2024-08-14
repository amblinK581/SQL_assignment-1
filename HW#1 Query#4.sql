/* HW#1 Query #4:

Step #1~#4: Compute for each customer and product combination, the average sales quantities for the four seasons.

Step #5: Join the results of the four seasons.

Step #6: Calculate the whole year average and produce the final result.

*/

-- Step #1: Compute average sales quantities, total sales quantities and the number of purchases(count) for Spring 
with q1 as
(
    select cust, prod, avg(quant) spring_avg, sum(quant) spring_total, count(date) sp_ct
	    from sales
	where "month" between 3 and 5
	group by cust, prod
	order by cust
),

-- Step #2: Compute average sales quantities, total sales quantities and the number of purchases(count) for Summer
q2 as
(
    select cust, prod, avg(quant) summer_avg, sum(quant) summer_total, count(date) su_ct
	    from sales
	where "month" between 6 and 8
	group by cust, prod
	order by cust
),

-- Step #3: Compute average sales quantities, total sales quantities and the number of purchases(count) for Fall
q3 as
(
    select cust, prod, avg(quant) fall_avg, sum(quant) fall_total, count(date) fa_ct
	    from sales
	where "month" between 9 and 11
	group by cust, prod
	order by cust
),

-- Step #4: Compute average sales quantities, total sales quantities and the number of purchases(count) for Winter
q4 as
(
    select cust, prod, avg(quant) winter_avg, sum(quant) winter_total, count(date) wi_ct
	    from sales
	where "month" = 12 or "month" < 3
	group by cust, prod
	order by cust
),
-- Step #5: Join the results of the four seasons
q5 as
(
    select q1.cust, q1.prod, q1.spring_avg, q2.summer_avg, q3.fall_avg, q4.winter_avg, q1.spring_total+q2.summer_total+q3.fall_total+q4.winter_total Total, q1.sp_ct+q2.su_ct+q3.fa_ct+q4.wi_ct "count"    
	    from q1, q2, q3, q4
    where q1.cust = q2.cust and q2.cust= q3.cust and q3.cust= q4.cust and q1.prod = q2.prod and q2.prod = q3.prod and q3.prod = q4.prod
),

-- Step #6: Calculate the whole year average
q6 as
(
    select q5.cust, q5.prod, q5.spring_avg, q5.summer_avg, q5.fall_avg, q5.winter_avg, q5.total/q5.count average, q5.total, q5.count
        from q5
)

select * from q6
order by cust, prod