-- Q5: Top Channels Driving Retention
-- BUSINESS VALUE: Identifies which channels (App, USSD, Agent) retain the most customers.

WITH monthly_channel_active AS (
    SELECT 
        FORMAT(txn_date, 'yyyy-MM') AS month_year,
        user_id,
        channel
    FROM Clean.gold_transactions_logs
    GROUP BY FORMAT(txn_date, 'yyyy-MM'), user_id, channel
),
prev_curr AS (
    SELECT 
        prev.month_year AS prev_month,
        prev.channel,
        curr.month_year AS curr_month,
        prev.user_id AS user_id
    FROM monthly_channel_active prev
    LEFT JOIN monthly_channel_active curr
        ON prev.user_id = curr.user_id
        AND DATEADD(MONTH, 1, CAST(prev.month_year + '-01' AS DATE)) 
            = CAST(curr.month_year + '-01' AS DATE)
)
SELECT 
    prev_month,
    channel,
    COUNT(DISTINCT user_id) AS prev_month_users,
    COUNT(DISTINCT CASE WHEN curr_month IS NOT NULL THEN user_id END) AS retained_users,
    CAST(COUNT(DISTINCT CASE WHEN curr_month IS NOT NULL THEN user_id END) * 100.0 
         / COUNT(DISTINCT user_id) AS DECIMAL(5,2)) AS retention_rate_percent
FROM prev_curr
GROUP BY prev_month, channel
ORDER BY prev_month DESC, retention_rate_percent DESC;
