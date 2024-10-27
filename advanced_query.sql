-- Calculate total amount paid per customer as CTE
WITH cte AS (SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    p.amount,
    p.payment_date
FROM
    customer AS c
LEFT JOIN
    payment AS p
ON
    c.customer_id = p.customer_id)

--Use window function to calculate running total per customer
SELECT
    customer_id,
    first_name,
    last_name,
    amount,
    TO_CHAR(payment_date, 'YYYY-MM-DD HH24:MI:SS') AS payment_date,
    SUM(amount) OVER (PARTITION BY customer_id ORDER BY payment_date) AS running_total
FROM
    cte;