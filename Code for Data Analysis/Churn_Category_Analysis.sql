-- This query returns the total number of churned customers and churn rate for each churn category
-- ordered from highest to lowest by total churned customers

SELECT  
	churn_category,
	COUNT(customer_id) AS total_churnend,
	ROUND(COUNT(customer_id) /  
		(Select  -- This subquery returns the total number of chunred customers, which is used to calculate the churn rate
		COUNT(customer_id)
		FROM churn_status
		WHERE customer_status = 'churned') * 100, 2) AS 'churn_rate(%)'
FROM churn_status
WHERE customer_status = 'churned'
GROUP BY churn_category
ORDER BY total_churnend DESC;