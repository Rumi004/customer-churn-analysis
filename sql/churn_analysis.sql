-- Customer Churn Analysis: SQL queries
-- Database: churndb | Table: customer_churn
-- Open this file in MySQL Workbench or run it with the MySQL command-line client.

USE churndb;

-- 1. Total customers
SELECT COUNT(*) AS total_customers
FROM customer_churn;

-- 2. Total churned customers
SELECT COUNT(*) AS churn_customers
FROM customer_churn
WHERE Churn = 'Yes';

-- 3. Churn rate (%)
SELECT ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / NULLIF(COUNT(*), 0), 2) AS churn_rate_pct
FROM customer_churn;

-- 4. Average monthly charges
SELECT ROUND(AVG(Monthly_Charges), 2) AS avg_monthly_charges
FROM customer_churn;

-- 5. Average tenure (months)
SELECT ROUND(AVG(Tenure_Months), 2) AS avg_tenure_months
FROM customer_churn;

-- 6. Customer and churn counts by contract type
SELECT Contract_Type,
       COUNT(*) AS total_customers,
       SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) AS churn_customers,
       ROUND(100.0 * SUM(CASE WHEN Churn = 'Yes' THEN 1 ELSE 0 END) / NULLIF(COUNT(*), 0), 2) AS churn_rate_pct
FROM customer_churn
GROUP BY Contract_Type
ORDER BY churn_rate_pct DESC;

-- 7. Customer counts by internet service
SELECT Internet_Service, COUNT(*) AS customers
FROM customer_churn
GROUP BY Internet_Service
ORDER BY customers DESC;

-- 8. Churned customers by state
SELECT State, COUNT(*) AS churn_customers
FROM customer_churn
WHERE Churn = 'Yes'
GROUP BY State
ORDER BY churn_customers DESC;

-- 9. Customers by payment method
SELECT Payment_Method, COUNT(*) AS customers
FROM customer_churn
GROUP BY Payment_Method
ORDER BY customers DESC;

-- 10. Customers by subscription type
SELECT Subscription_Type, COUNT(*) AS customers
FROM customer_churn
GROUP BY Subscription_Type
ORDER BY customers DESC;

-- 11. Revenue by state
SELECT State, ROUND(SUM(Total_Charges), 2) AS total_revenue
FROM customer_churn
GROUP BY State
ORDER BY total_revenue DESC;

-- 12. Average monthly charges by contract type
SELECT Contract_Type, ROUND(AVG(Monthly_Charges), 2) AS avg_monthly_charges
FROM customer_churn
GROUP BY Contract_Type
ORDER BY avg_monthly_charges DESC;

-- 13. Churned customers by senior-citizen status
SELECT Senior_Citizen, COUNT(*) AS churn_customers
FROM customer_churn
WHERE Churn = 'Yes'
GROUP BY Senior_Citizen
ORDER BY churn_customers DESC;

-- 14. Top 10 customers by estimated customer value
-- Note: Customer_Value is an estimate (Monthly_Charges * Tenure_Months), not necessarily actual lifetime value.
SELECT Customer_Name, Customer_Value
FROM customer_churn
ORDER BY Customer_Value DESC
LIMIT 10;

-- 15. Customers without tech support
SELECT Customer_ID, Customer_Name, Tech_Support, Churn, Monthly_Charges, Tenure_Months
FROM customer_churn
WHERE Tech_Support = 'No';
