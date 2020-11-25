SELECT
customer_id as 'Customer ID',
payment_id as 'Payment ID',
payment_date as 'Payment Date',
amount as 'Transaction Amount',
SUM(amount) OVER(PARTITION BY customer_id ) as 'Total Amount Spent by customer',
AVG(amount) OVER(PARTITION BY customer_id ) as 'Average Spent by customer',
amount/(sum(Amount) OVER(PARTITION BY customer_id)) as 'Transaction as % of Total Spent',
amount/(AVG(Amount) OVER(PARTITION BY customer_id )) as 'Transaction as % of Average spent'
FROM payment; 