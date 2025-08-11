-- Q1: Monthly Active Users (MAU) & Daily Active Users (DAU)
-- BUSINESS VALUE: Tracks engagement trends and identifies active customer base.

-- Daily Active Users
SELECT
    login_date AS login_day,
    COUNT(DISTINCT user_id) AS daily_active_users
FROM Clean.gold_login_activities
GROUP BY login_date
ORDER BY login_day DESC;

-- Monthly Active Users
SELECT
    DATEFROMPARTS(YEAR(login_date), MONTH(login_date), 1) AS month_start,
    COUNT(DISTINCT user_id) AS monthly_active_users
FROM Clean.gold_login_activities
GROUP BY DATEFROMPARTS(YEAR(login_date), MONTH(login_date), 1)
ORDER BY month_start DESC;
