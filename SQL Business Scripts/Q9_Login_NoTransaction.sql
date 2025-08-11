-- Q9: Login vs Transaction Conversion Rate
-- BUSINESS VALUE: Highlights potential UX or trust issues.

SELECT 
    COUNT(DISTINCT lc.user_id) AS users_logged_in_no_txn
FROM Clean.gold_login_activities lc
LEFT JOIN Clean.gold_transactions_logs ts 
    ON lc.user_id = ts.user_id
WHERE ts.user_id IS NULL;
