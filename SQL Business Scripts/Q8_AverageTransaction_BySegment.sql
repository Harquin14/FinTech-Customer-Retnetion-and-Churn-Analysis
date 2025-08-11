-- Q8: Average Transaction Value (ATV) & Frequency per Customer Segment
-- BUSINESS VALUE: Reveals spending patterns by demographic segments.

SELECT 
    um.age,
    um.region,
    um.gender,
    CAST(SUM(t.txn_amount) * 1.0 / COUNT(t.txn_id) AS DECIMAL(10,2)) AS avg_transaction_value,
    CAST(COUNT(t.txn_id) * 1.0 / COUNT(DISTINCT t.user_id) AS DECIMAL(10,2)) AS avg_transactions_per_user
FROM Clean.gold_transactions_logs t
JOIN Clean.gold_user_master um
    ON t.user_id = um.user_id
GROUP BY um.age, um.region, um.gender
ORDER BY avg_transaction_value DESC;
