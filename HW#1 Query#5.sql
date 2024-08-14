/* HW#1 Query #5:

Step #1: Compute QTR for sales table

Step #2~#5: Compute MAX sales quantities of each product for the 4 quarters

Step #6~#9: Capture the "date" of each product's MAX sales quantities for the 4 quarters

Step #10: Combine the results of the 4 quarters and produce the final result.

*/

-- Step #1: Compute QTR for sales table
with s as
(
select *, extract (quarter from date) QTR from sales
),


-- Step #2: Compute Q1_MAX for each product
q1 as
(
    select prod product, max(quant) Q1_MAX, QTR
        from s
	where qtr = 1
	group by prod, QTR
),

-- Step #3: Compute Q2_MAX for each product
q2 as
(
    select prod product, max(quant) Q2_MAX, QTR
        from s
	where qtr = 2
	group by prod, QTR
),

-- Step #4: Compute Q3_MAX for each product
q3 as
(
    select prod product, max(quant) Q3_MAX, QTR
        from s
	where qtr = 3
	group by prod, QTR
),

-- Step #5: Compute Q4_MAX for each product
q4 as
(
    select prod product, max(quant) Q4_MAX, QTR
        from s
	where qtr = 4
	group by prod, QTR	
),

-- Step #6: Capture the "date" for Q1_Max
q5 as
(
    select q1.product, q1.Q1_MAX, s.date
        from q1, s
    where q1.product = s.prod and q1.QTR = s.QTR and q1.Q1_MAX = s.quant
),

-- Step #7: Capture the "date" for Q2_Max
q6 as
(
    select q2.product, q2.Q2_MAX, s.date
        from q2, s
    where q2.product = s.prod and q2.QTR = s.QTR and q2.Q2_MAX = s.quant
),

-- Step #8: Capture the "date" for Q3_Max
q7 as
(
    select q3.product, q3.Q3_MAX, s.date
        from q3, s
    where q3.product = s.prod and q3.QTR = s.QTR and q3.Q3_MAX = s.quant
),

-- Step #9: Capture the "date" for Q4_Max
q8 as
(
    select q4.product, q4.Q4_MAX, s.date
        from q4, s
    where q4.product = s.prod and q4.QTR = s.QTR and q4.Q4_MAX = s.quant
),

-- Step #10: Combine the results of the 4 quarters
q9 as
(
    select q5.product, q5.Q1_MAX, q5.date, q6.Q2_MAX, q6.date, q7.Q3_MAX, q7.date, q8.Q4_MAX, q8.date
	    from q5, q6, q7, q8
	where q5.product = q6.product and q6.product = q7.product and q7.product = q8.product
)

select * from q9 order by 1

