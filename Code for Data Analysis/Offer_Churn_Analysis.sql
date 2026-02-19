-- These queries show the relation between the number of churned and reteained customers
-- and the type of offer they used

-- This CTE calcultes the total number of chunred and retained customers for each offer
-- type provided by the company 
WITH churned_retained AS
	(
	SELECT 
		s.offer, 
		COUNT(CASE WHEN customer_status = 'Churned' THEN 1 END) AS churned,
		COUNT(CASE WHEN customer_status = 'Stayed' THEN 1 END) AS retained
	FROM services AS s
	JOIN churn_status AS c 
	ON s.customer_id = c.customer_id
	GROUP BY s.offer
    )

-- The main query uses the CTE and returns the number of total, churned, reteained customers for each offer type and 
-- the churn and retention rate for each offer 
SELECT 
	offer,
    churned + retained AS total_used,
    churned,
    retained,
	ROUND( (churned * 1.0) / (churned + retained) * 100, 2) AS churn_rate,
	ROUND( (retained * 1.0) / (churned + retained) * 100, 2) AS retain_rate
FROM churned_retained;



