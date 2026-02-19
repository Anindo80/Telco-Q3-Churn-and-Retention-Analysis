-- These queries calculate the number of churned and retained customers based 
-- on customer tenure within the company for each contract type
    
-- This CTE groups customer tenure in months into 12-month interval
WITH tenure AS
    (
    SELECT 
        ct.customer_id,
        ct.contract_type,
        ct.`tenure (months)`,
        CASE 
            WHEN ct.`tenure (months)` <= 12 THEN '0-12 months'
            WHEN ct.`tenure (months)` <= 24 THEN '13-24 months'
            WHEN ct.`tenure (months)` <= 36 THEN '25-36 months'
            WHEN ct.`tenure (months)` <= 48 THEN '37-48 months'
            ELSE '49+ months'
        END AS tenure_group
	FROM contract_tenure ct
    )

-- The main query calculates the number of churned and retained customers for each contract type and 
-- tenure group by joining the CTE with the chunr_status table
SELECT
	t.contract_type,
	t.tenure_group, 
	COUNT(CASE WHEN customer_status = 'churned' THEN 1 END) as churned,
	COUNT(CASE WHEN customer_status = 'stayed' THEN 1 END) as retained
FROM tenure AS t
JOIN churn_status AS cs
ON t.customer_id = cs.customer_id
GROUP BY t.contract_type, t.tenure_group;





