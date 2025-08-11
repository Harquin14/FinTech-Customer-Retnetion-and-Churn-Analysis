-- Q7: Lost Revenue from Churned High-Value Customers
-- BUSINESS VALUE: Quantifies revenue leakage due to churn from valuable customers.

WITH base AS (
    SELECT 
        user_id, 
        SUM(txn_amount) AS revenue
    FROM Clean.gold_transactions_logs
    GROUP BY user_id
),  
high_value AS (
    SELECT user_id
    FROM base
    WHERE revenue >= 5000
),
monthly_active AS (
    SELECT 
        FORMAT(txn_date, 'yyyy-MM') AS month_year,
        user_id,
        SUM(txn_amount) AS month_revenue
    FROM Clean.gold_transactions_logs
    GROUP BY FORMAT(txn_date, 'yyyy-MM'), user_id
),
prev_curr AS (
    SELECT 
        prev.month_year AS prev_month,
        curr.month_year AS curr_month,
        prev.user_id,
        prev.month_revenue
    FROM monthly_active prev
    LEFT JOIN monthly_active curr
        ON prev.user_id = curr.user_id
        AND DATEADD(MONTH, 1, CAST(prev.month_year + '-01' AS DATE)) 
            = CAST(curr.month_year + '-01' AS DATE)
)
SELECT 
    prev_month,
    SUM(month_revenue) AS lost_revenue
FROM prev_curr
JOIN high_value hv 
    ON prev_curr.user_id = hv.user_id
WHERE curr_month IS NULL
GROUP BY prev_month
ORDER BY prev_month DESC;
