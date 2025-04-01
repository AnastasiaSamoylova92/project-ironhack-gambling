USE ih_gambling;

-- Q1
SELECT Title, FirstName, LastName, DateOfBirth
FROM customer;

-- Q2 Using customer table, write an SQL query that shows the number of customers in each customer group (Bronze, Silver & Gold). 
SELECT CustomerGroup, COUNT(CustId) as nr_customers
FROM customer
GROUP BY CustomerGroup;

-- Q3 The CRM manager has asked me to provide a complete list of all data for those customers in the customer table but I need to add the currencycode of each player so she will be able to send the right offer in the right currency.
SELECT customer.*, account.CurrencyCode
FROM customer
JOIN account ON customer.CustId = account.CustId;

-- Q4 Now I need to provide a product manager with a summary report that shows, by product and by day how much money has been bet on a particular product.
select * from product;

SELECT product.Product, betting.BetDate, SUM(Bet_Amt) as Total_Bet_Amount
FROM betting
JOIN product ON betting.classid = product.classid
GROUP BY Product, BetDate
ORDER BY Product, BetDate;

-- Q5 amend the summary report so that it only summarises transactions that occurred on or after 1st November and he only wants to see Sportsbook transactions.
SELECT product.Product, betting.BetDate, SUM(Bet_Amt) as Total_Bet_Amount
FROM betting
JOIN product ON betting.classid = product.classid
WHERE betting.BetDate > '01/11/2012' 
	AND product.product = "Sportsbook"
GROUP BY Product, BetDate
ORDER BY Product, BetDate;

-- Q6 all of the products but split by the currencycode and customergroup of the customer, rather than by day and product. transactions that occurred after 1st December.
SELECT account.CurrencyCode, customer.CustomerGroup, SUM(betting.Bet_Amt) as Total_Bet_Amount
FROM account
JOIN betting ON account.accountno = betting.accountno
JOIN customer ON account.custid = customer.custid
WHERE betting.BetDate > '01.12.2012'
GROUP BY CurrencyCode, CustomerGroup
ORDER BY CurrencyCode, CustomerGroup;

-- Q7 write an SQL query that shows all players Title, First Name and Last Name and a summary of their bet amount for the complete period of November
SELECT customer.Title, customer.FirstName, customer.LastName, SUM(betting.Bet_Amt) as Total_Bet_Amount
FROM account
JOIN betting ON account.accountno = betting.accountno
JOIN customer ON account.custid = customer.custid
WHERE betting.BetDate BETWEEN '01.11.2012' AND '30.11.2012'
GROUP BY  customer.Title, customer.FirstName, customer.LastName;

-- Q8  write 2 queries, one that shows the number of products per player and another that shows players who play both Sportsbook and Vegas.
SELECT customer.Title, customer.FirstName, customer.LastName, product.product, COUNT(DISTINCT betting.classid) as Nr_products_per_player
FROM account
JOIN betting ON account.accountno = betting.accountno
JOIN customer ON account.custid = customer.custid
JOIN product ON betting.classid = product.classid
GROUP BY  customer.Title, customer.FirstName, customer.LastName, product.product;

SELECT customer.Title, customer.FirstName, customer.LastName, COUNT(DISTINCT betting.classid) as Nr_products_per_player
FROM account
JOIN betting ON account.accountno = betting.accountno
JOIN customer ON account.custid = customer.custid
JOIN product ON betting.classid = product.classid
WHERE product.product IN ('Sportsbook', 'Vegas')
GROUP BY  customer.Title, customer.FirstName, customer.LastName;

-- Q9 write SQL code that shows the players who only play at sportsbook, use the bet_amt > 0 as the key. Show each player and the sum of their bets for both products.
SELECT customer.Title, customer.FirstName, customer.LastName, SUM(DISTINCT betting.Bet_Amt) as Bet_Amount
FROM account
JOIN betting ON account.accountno = betting.accountno
JOIN customer ON account.custid = customer.custid
JOIN product ON betting.classid = product.classid
WHERE product.product = 'Sportsbook' 
GROUP BY  customer.Title, customer.FirstName, customer.LastName;

-- Q10 calculate and determine a player’s favourite product. This can be determined by the most money staked.

