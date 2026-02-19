-- This query returns the number of customer who churned and stayed based on the type of phone service used 

SELECT
	s.phone_service,
	s.multiple_lines,
	SUM(CASE WHEN c.customer_status = 'Churned' THEN 1 ELSE 0 END) AS total_churned,
	SUM(CASE WHEN c.customer_status = 'Stayed' THEN 1 ELSE 0 END) AS total_stayed
FROM services AS s
JOIN churn_status AS c
ON s.customer_id = c.customer_id
GROUP BY s.phone_service, s.multiple_lines
HAVING phone_service LIKE 'Yes';

