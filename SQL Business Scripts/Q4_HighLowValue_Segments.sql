-- Q4: High-Value vs Low-Value Customers
-- BUSINESS VALUE: Segments customers and tracks churn by value group.

WITH user_totals AS (
    SELECT 
        user_id, 
        SUM(txn_amount) AS total_trans
    FROM Clean.gold_transactions_logs
    WHERE DATEDIFF(DAY, txn_date, GETDATE()) <= 90
    GROUP BY user_id
),
user_segments AS (
    SELECT
        user_id,
        total_trans,
        CASE 
            WHEN total_trans >= 3000 THEN 'High-Value'
            ELSE 'Low-Value'
        END AS customer_segment
    FROM user_totals
),
monthly_active AS (
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
    us.customer_segment,
    prev_month,
    COUNT(DISTINCT prev.user_id) AS prev_month_users,
    COUNT(DISTINCT CASE WHEN curr_month IS NULL THEN prev.user_id END) AS churned_users,
    CAST(COUNT(DISTINCT CASE WHEN curr_month IS NULL THEN prev.user_id END) * 100.0 
         / COUNT(DISTINCT prev.user_id) AS DECIMAL(5,2)) AS churn_rate_percent
FROM prev_curr prev
JOIN user_segments us
    ON prev.user_id = us.user_id
GROUP BY us.customer_segment, prev_month
ORDER BY prev_month DESC, us.customer_segment;
