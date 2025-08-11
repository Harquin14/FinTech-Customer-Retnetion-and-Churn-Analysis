-- Q2: Monthly Churn Rate
-- BUSINESS VALUE: Identifies users who were active in the previous month but had no transactions in the current month.

WITH monthly_active AS (
    SELECT 
        FORMAT(txn_date, 'yyyy-MM') AS month_year,
        user_id
    FROM Clean.gold_transactions_logs
    GROUP BY FORMAT(txn_date, 'yyyy-MM'), user_id
),
prev_curr AS (
    SELECT 
        prev.month_year AS prev_month,
        curr.month_year AS curr_month,
        prev.user_id
    FROM monthly_active prev
    LEFT JOIN monthly_active curr
        ON prev.user_id = curr.user_id
        AND DATEADD(MONTH, 1, CAST(prev.month_year + '-01' AS DATE)) 
            = CAST(curr.month_year + '-01' AS DATE)
)
SELECT 
    prev_month,
    COUNT(DISTINCT user_id) AS prev_month_users,
    COUNT(DISTINCT CASE WHEN curr_month IS NULL THEN user_id END) AS churned_users,
    CAST(COUNT(DISTINCT CASE WHEN curr_month IS NULL THEN user_id END) * 100.0 
         / COUNT(DISTINCT user_id) AS DECIMAL(5,2)) AS churn_rate_percent
FROM prev_curr
GROUP BY prev_month
ORDER BY prev_month DESC;
