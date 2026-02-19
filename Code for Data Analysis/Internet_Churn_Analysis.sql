-- This query returns the number of customers who churned and stayed based on the type of internet service used 

SELECT
	s.internet_service,
	s.internet_type,
	SUM(CASE WHEN c.customer_status = 'Churned' THEN 1 ELSE 0 END) AS total_churned,
	SUM(CASE WHEN c.customer_status = 'Stayed' THEN 1 ELSE 0 END) AS total_stayed
FROM services AS s
JOIN churn_status AS c
ON s.customer_id = c.customer_id
GROUP BY s.internet_service, s.internet_type
HAVING internet_service LIKE 'Yes';
