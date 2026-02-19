-- These queries identify the top churn reason for each of the top 10 cities 
-- with the highest number of churned customers

-- This CTE identifies the top 10 cities based on the total number of churned customers
WITH top10_cities AS 
	(
    SELECT
		city,
		COUNT(c.customer_id) AS total_churned
    FROM cities AS c
    JOIN churn_status AS cs
    ON  c.customer_id = cs.customer_id
    WHERE customer_status = 'Churned'
    GROUP BY city
    ORDER BY total_churned DESC
    LIMIT 10
	)
,

-- This CTE calculates the number of churned customers for each reason in each city
reason_count AS
	(
    SELECT 
		city,
		churn_reason,
		COUNT(*) AS total_churned
    FROM cities AS c
    JOIN churn_status AS cs
    ON c.customer_id = cs.customer_id
    WHERE customer_status = 'Churned'
    GROUP BY city, churn_reason
    ORDER BY total_churned DESC
	)

-- The main query joins the CTEs and retunrs the top churn reason in each 
-- of the top 10 cities by selecting the reason with the highest churn count
SELECT 
    t10.city, 
    t10.total_churned, 
    ANY_VALUE(rc.churn_reason) AS top_reason, 
    MAX(rc.total_churned) AS toal_churned_for_top_reason,
    ROUND(MAX(rc.total_churned) * 100 / t10.total_churned, 1) AS churn_rate
FROM top10_cities AS t10
JOIN reason_count AS  rc 
ON t10.city = rc.city
GROUP BY t10.city
ORDER BY total_churned DESC;