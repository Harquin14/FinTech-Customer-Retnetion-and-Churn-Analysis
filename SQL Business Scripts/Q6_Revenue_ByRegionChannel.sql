-- Q6: Total Revenue by Region and Channel
-- BUSINESS VALUE: Helps prioritize marketing spend and operational improvements in top-performing regions/channels.

SELECT 
    us.region,
    t.channel,
    ROUND(SUM(t.txn_amount), 2) AS total_revenue,
    COUNT(DISTINCT t.txn_id) AS total_transactions
FROM Clean.gold_transactions_logs t
LEFT JOIN Clean.gold_user_master us 
    ON t.user_id = us.user_id
GROUP BY us.region, t.channel
ORDER BY total_revenue DESC, total_transactions DESC;
