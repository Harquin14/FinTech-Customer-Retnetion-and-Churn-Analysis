-- Q3: Customer Retention Cohorts
-- BUSINESS VALUE: Tracks retention rates by signup month across multiple months.

WITH signup_cohort AS (
    SELECT
        user_id,
        FORMAT(signup_date, 'yyyy-MM') AS cohort_month
    FROM Clean.gold_user_master
),
user_activity AS (
    SELECT
        user_id,
        FORMAT(txn_date, 'yyyy-MM') AS activity_month
    FROM Clean.gold_transactions_logs
    GROUP BY user_id, FORMAT(txn_date, 'yyyy-MM')
),
cohort_activity AS (
    SELECT
        sc.cohort_month,
        ua.activity_month,
        DATEDIFF(MONTH, 
            CAST(sc.cohort_month + '-01' AS DATE),
            CAST(ua.activity_month + '-01' AS DATE)
        ) AS month_number,  
        ua.user_id
    FROM signup_cohort sc
    INNER JOIN user_activity ua
        ON sc.user_id = ua.user_id
),
cohort_size AS (
    SELECT 
        cohort_month,
        COUNT(DISTINCT user_id) AS total_users
    FROM signup_cohort
    GROUP BY cohort_month
)
SELECT
    ca.cohort_month,
    ca.month_number,
    COUNT(DISTINCT ca.user_id) AS active_users,
    cs.total_users,
    CAST((COUNT(DISTINCT ca.user_id) * 100.0 / cs.total_users) AS DECIMAL(5,2)) AS retention_rate_percent
FROM cohort_activity ca
INNER JOIN cohort_size cs
    ON ca.cohort_month = cs.cohort_month
WHERE ca.month_number >= 0
GROUP BY ca.cohort_month, ca.month_number, cs.total_users
ORDER BY ca.cohort_month, ca.month_number;
