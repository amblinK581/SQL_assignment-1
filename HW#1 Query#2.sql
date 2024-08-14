/* HW#1 Query #2:

Step #1: Compute for each date, sum(quant) & save the result of the query.

Step #2: Using 'q1' table, find the busiest and slowest day of each year & month.

Step #3: Using 'q2' & 'q1' table , capture the details ('day') for the busiest day.

Step #4: Using 'q3' & 'q1' table , capture the details ('day') for the slowest day and produce the final output.

*/
-- Step #1: Calculate the total sales of each date
with q1 as
(
    select "year", "month", "day", date, sum(quant) total_sales 
        from sales
    group by "year", "month", "day", date
    order by date
),

-- Step #2: Find the busiest and slowest day of each year & month
q2 as
(
    select q1.year, q1.month, max(q1.total_sales) busiest_total_q, min(q1.total_sales) slowest_total_q
	    from q1
	group by q1.year, q1.month
	order by q1.year, q1.month
),

-- Step #3: Capture the details('day') for the busiest day
q3 as
(
    select q2.year, q2.month, q1.day busiest_day, q2.busiest_total_q, q2.slowest_total_q
	    from q2, q1
	where q2.year = q1.year and q2.month = q1.month and q2.busiest_total_q = q1.total_sales
),
-- Step #4: Capture the details('day') for the slowest day
q4 as
(
    select q3.year, q3.month, q3.busiest_day, q3.busiest_total_q, q1.day slowest_day, q3.slowest_total_q
	    from q3, q1
	where q3.year = q1.year and q3.month = q1.month and q3.slowest_total_q = q1.total_sales
)

select * from q4

