CREATE DATABASE FINTECH;

CREATE SCHEMA Clean;

CREATE TABLE Clean.gold_login_activities(
user_id NVARCHAR(50),login_date Date);

DROP TABLE Clean.gold_transactions_logs;
CREATE  TABLE Clean.gold_transactions_logs(
user_id NVARCHAR(50),txn_date Date,txn_amount float, channel NVARCHAR(50),txn_type NVARCHAR(50),
txn_id NVARCHAR(50)
);


CREATE TABLE Clean.gold_user_master(
user_id NVARCHAR(50),signup_date Date, gender NVARCHAR(50),age INT, region NVARCHAR(50)
);

---INSERTING THE DATASET--------------------------------

TRUNCATE TABLE Clean.gold_login_activities
BULK INSERT Clean.gold_login_activities 
FROM "F:\DATASET\FINTECH CUSTOMER RETENTION\DATASET\gold_login_activities.csv"

WITH (
FIRSTROW = 2,
FIELDTERMINATOR = ',',
TABLOCK);

TRUNCATE TABLE Clean.gold_user_master
BULK INSERT Clean.gold_user_master
FROM  "F:\DATASET\FINTECH CUSTOMER RETENTION\DATASET\gold_user_master.csv"

WITH (
FIRSTROW = 2,
FIELDTERMINATOR = ',',
TABLOCK );


TRUNCATE TABLE Clean.gold_transactions_logs
BULK INSERT Clean.gold_transactions_logs

FROM "F:\DATASET\FINTECH CUSTOMER RETENTION\DATASET\gold_transactions_logs.csv"
WITH (
FIRSTROW = 2,
FIELDTERMINATOR = ',',
TABLOCK );

