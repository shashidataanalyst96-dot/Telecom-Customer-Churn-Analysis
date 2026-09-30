# Total Customers & Churn Rate
select count(*) as total_customers, SUM(case when churn = 'Yes' then 1 else 0 end) as churnd_customers,
round(100.0 * SUM(case when churn ='Yes' then 1 else 0 end) / count(*), 2) as churn_rate_percentage from teleco_churn.data;
# Churn by Contract Type
SELECT 
    contract,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers
FROM teleco_churn.data
GROUP BY contract
ORDER BY churned_customers DESC;
# Monthly Charges vs Churn (Risk Segments)
SELECT 
    CASE 
        WHEN monthlycharges < 30 THEN 'Low'
        WHEN monthlycharges BETWEEN 30 AND 70 THEN 'Medium'
        ELSE 'High'
    END AS charge_segment,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers
FROM teleco_churn.data
GROUP BY 
    CASE 
        WHEN monthlycharges < 30 THEN 'Low'
        WHEN monthlycharges BETWEEN 30 AND 70 THEN 'Medium'
        ELSE 'High'
    END;
# Tenure vs Churn (Customer Loyalty)
SELECT 
    CASE 
        WHEN tenure <= 12 THEN '0-1 Year'
        WHEN tenure BETWEEN 13 AND 24 THEN '1-2 Years'
        WHEN tenure BETWEEN 25 AND 48 THEN '2-4 Years'
        ELSE '4+ Years'
    END AS tenure_group,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers
FROM teleco_churn.data
GROUP BY tenure_group
ORDER BY tenure_group;
# Payment Method Impact on Churn
SELECT 
    paymentmethod,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN churn = 'Yes' THEN 1 ELSE 0 END) AS churned_customers
FROM teleco_churn.data
GROUP BY paymentmethod
ORDER BY churned_customers DESC;
#High Risk Customers (Profile Filter)
SELECT *
FROM teleco_churn.data
WHERE churn = 'Yes'
  AND monthlycharges > 70
  AND tenure < 12;
  


