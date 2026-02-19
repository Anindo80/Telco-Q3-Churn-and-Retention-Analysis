-- This query returns the number of total, stayed, churned, and newly joined customers

SELECT 
    COUNT(customer_id) AS total_customers,
    SUM(CASE WHEN customer_status = 'Stayed' THEN 1 ELSE 0 END) AS total_stayed,
    SUM(CASE WHEN customer_status = 'Churned' THEN 1 ELSE 0 END) AS total_churned,
    SUM(CASE WHEN customer_status = 'Joined' THEN 1 ELSE 0 END) AS total_joined
FROM churn_status;