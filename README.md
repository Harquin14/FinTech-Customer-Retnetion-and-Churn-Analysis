# FinTech-Customer-Retnetion-and-Churn-Analysis (Python, SQL, Tableau)



## Overview
This project analyses customer engagement, retention, and churn for a fintech platform offering services like:
- Money transfers
- Airtime/Data top-up
- Bill payments
- Loan access

The analysis helps **Product Managers, Marketing, and Customer Support teams** make data-driven decisions to:
- Reduce churn
- Improve customer engagement
- Increase revenue

---

##  Tools Used
- **Python** – Data cleaning & EDA
- **Tableau** – Dashboard visualization
- **Excel** – Data exploration
- **SQL Server** – Business Analysis

---

## 📂 Dataset
**Tables Used:**
1. **`Clean.gold_login_activities`**
   - `user_id`, `login_date`
2. **`Clean.gold_transactions_logs`**
   - `user_id`, `txn_id`, `txn_date`, `txn_amount`, `channel`
3. **`Clean.gold_user_master`**
   - `user_id`, `signup_date`, `age`, `gender`, `region`

---

## 📊 Business Questions
1. **Monthly Active Users (MAU) & Daily Active Users (DAU)** – Track engagement trends.
2. **Monthly Churn Rate** – Identify customers active in previous month but inactive in current month.
3. **Customer Retention Cohorts** – Retention analysis by signup month.
4. **High-Value vs Low-Value Customers** – Segment customers and track retention.
5. **Top Channels Driving Retention** – Compare retention for App, USSD, Agent.
6. **Total Revenue by Region & Channel** – Identify top contributors.
7. **Lost Revenue from Churned High-Value Customers** – Measure revenue loss.
8. **Average Transaction Value (ATV) & Frequency** – Compare by age, region, gender.
9. **Login vs Transaction Conversion Rate** – Identify UX or trust issues.

---

## 📈 Example Insights
- High churn in low-value users is seasonal; re-engagement campaigns can focus there.
- Retention rates are highest in **App** users compared to **USSD**.
- Two regions contribute 65% of total revenue.
- Significant lost revenue from churned high-value customers in Q2.

---

## 🚀 How to Use
1. Clone this repository  
2. Run `.sql` files in SQL Server Management Studio  


---

## 📌 Dashboard Link
[Tableau Dashboard](PUT_YOUR_LINK_HERE)
