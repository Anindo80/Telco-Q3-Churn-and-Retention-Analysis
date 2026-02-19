-- These queries calculate and return the total number of churned customers
-- by churn reason within the top 3 churn categories

-- This CTE identifies the top 3 churn categories based on the total number of churned customers,
-- which is used in the main query
WITH top3ChurnCategory AS
	(
    SELECT  
		churn_category,
		COUNT(customer_id) AS total_churned
	FROM churn_status
	WHERE customer_status = 'churned'
	GROUP BY churn_category
	ORDER BY total_churned DESC
	LIMIT 3
    )

-- The main query returns the total number of churned customers for each churn reason 
-- within the top 3 categories by joining the CTE with the churn_status table
SELECT
	t3.churn_category,
	churn_reason,
	COUNT(customer_id) AS total_churned
FROM top3ChurnCategory AS t3
JOIN churn_status AS c
ON t3.churn_category = c.churn_category
GROUP BY churn_category, churn_reason
ORDER BY churn_category, total_churned DESC;