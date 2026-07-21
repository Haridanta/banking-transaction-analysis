-- =============================================
-- BANKING TRANSACTION ANALYSIS
-- Author: Winsoon Edbert Tanaman
-- Dataset: 50,000+ banking transactions
-- Tool: MySQL Workbench
-- =============================================


-- =============================================
-- SECTION 1: BASIC ANALYSIS
-- =============================================

-- 1. Total number of transactions
SELECT COUNT(*) AS total_transactions 
FROM bank_transactions;

-- 2. Total transaction amount by type (Debit vs Credit)
SELECT TransactionType, SUM(TransactionAmount) AS total_amount
FROM bank_transactions
GROUP BY TransactionType;

-- 3. Average transaction amount by channel (ATM vs Online)
SELECT Channel, AVG(TransactionAmount) AS avg_transaction_amount
FROM bank_transactions
GROUP BY Channel;

-- 4. Top 5 locations by total transaction amount
SELECT Location, SUM(TransactionAmount) AS total_amount
FROM bank_transactions
GROUP BY Location
ORDER BY total_amount DESC
LIMIT 5;


-- =============================================
-- SECTION 2: CUSTOMER ANALYSIS
-- =============================================

-- 5. Transaction count by customer occupation
SELECT CustomerOccupation, COUNT(*) AS transaction_count
FROM bank_transactions
GROUP BY CustomerOccupation;

-- 6. Average account balance by customer occupation
SELECT CustomerOccupation, AVG(AccountBalance) AS avg_balance
FROM bank_transactions
GROUP BY CustomerOccupation;

-- 7. Customers aged above average age
SELECT AccountID, CustomerAge
FROM bank_transactions
WHERE CustomerAge > (SELECT AVG(CustomerAge) FROM bank_transactions);


-- =============================================
-- SECTION 3: FRAUD DETECTION
-- =============================================

-- 8. Flag transactions as Suspicious or Normal based on login attempts
SELECT TransactionID, LoginAttempts,
CASE 
    WHEN LoginAttempts > 1 THEN 'Suspicious'
    ELSE 'Normal'
END AS Activity
FROM bank_transactions;

-- 9. Accounts where total transaction amount exceeds 10,000
-- High value accounts that may require additional monitoring
SELECT AccountID, SUM(TransactionAmount) AS total_amount
FROM bank_transactions
GROUP BY AccountID
HAVING SUM(TransactionAmount) > 10000;

-- 10. Transactions above average transaction amount
-- Potential high-risk transactions for review
SELECT TransactionID, TransactionAmount
FROM bank_transactions
WHERE TransactionAmount > (SELECT AVG(TransactionAmount) FROM bank_transactions);


-- =============================================
-- SECTION 4: DATE ANALYSIS
-- =============================================

-- 11. Transaction count per month
SELECT MONTH(STR_TO_DATE(TransactionDate, '%m/%d/%Y %H:%i')) AS month,
COUNT(*) AS transaction_count
FROM bank_transactions
GROUP BY month
ORDER BY month;

-- 12. Most recent transaction date
SELECT MAX(STR_TO_DATE(TransactionDate, '%m/%d/%Y %H:%i')) AS most_recent_transaction
FROM bank_transactions;

-- 13. All transactions from 2023
SELECT *
FROM bank_transactions
WHERE YEAR(STR_TO_DATE(TransactionDate, '%m/%d/%Y %H:%i')) = 2023;