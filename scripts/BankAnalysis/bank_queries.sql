CREATE TABLE "BankData".transaction (
    transaction_date DATE NOT NULL,
    transaction_type VARCHAR(50),
    sort_code VARCHAR(8),
    account_number VARCHAR(10),
    transaction_description VARCHAR(255),
    debit_amount DECIMAL(10, 2),
    credit_amount DECIMAL(10, 2),
    balance DECIMAL(10, 2) NOT NULL,
	bank_name VARCHAR(10)
);

SET datestyle = 'DMY';

COPY "BankData".transaction (transaction_date,transaction_type,sort_code,account_number,transaction_description,debit_amount,credit_amount,balance,bank_name)
FROM 'C:\Projects\postgre\current_account_bank_1.csv'
WITH (FORMAT csv, HEADER);

SELECT *
	FROM "BankData".transaction
	where transaction_description = 'food';

select cast(spent as decimal(10,2)) as spent,transaction_description,bank_name,data_month
	from (select sum(debit_amount) as spent, transaction_description,bank_name,	
    CASE
        WHEN transaction_date BETWEEN '2024-01-01' AND '2024-01-31' THEN 'Jan'
        WHEN transaction_date BETWEEN '2024-02-01' AND '2024-02-28' THEN 'Feb'
        WHEN transaction_date BETWEEN '2024-03-01' AND '2024-03-31' THEN 'Mar'
        WHEN transaction_date BETWEEN '2024-04-01' AND '2024-04-30' THEN 'Apr'
        WHEN transaction_date BETWEEN '2024-05-01' AND '2024-05-31' THEN 'May'
        WHEN transaction_date BETWEEN '2024-06-01' AND '2024-06-30' THEN 'Jun'
        ELSE NULL -- Handle other cases if needed
    END AS data_month
	from "BankData".transaction
	group by transaction_description,bank_name,data_month) temp
	where temp.spent is not null and transaction_description like '%UBER%'
order by spent desc

DELETE FROM "BankData".transaction where bank_name = 'bank_2'