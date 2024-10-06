--select * from "BankData".transaction;
WITH BankTransaction(tran_dt, trans_desc, cred_amnt, bal_amnt)
AS (
	SELECT trans.transaction_date, 
	trans.transaction_description, 
	trans.credit_amount, 
	trans.balance
	FROM "BankData".transaction trans
	WHERE trans.transaction_type = 'FPI'
)
SELECT trans_desc, sum(cred_amnt) as total_amount_credited 
	FROM BankTransaction 
	group by trans_desc
	order by total_amount_credited desc