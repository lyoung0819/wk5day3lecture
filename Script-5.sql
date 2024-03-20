--- DDL Statements to create tables

-- Customer Table
CREATE TABLE IF NOT EXISTS customer(
	customer_id SERIAL PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	email VARCHAR(50),
	address VARCHAR(50),
	city VARCHAR(50),
	state VARCHAR(2)
);

SELECT * FROM customer;

-- Receipt Table (order is a keyword)
CREATE TABLE IF NOT EXISTS receipt(
	receipt_id SERIAL PRIMARY KEY,
	amount NUMERIC(5,2), -- Max OF 5 total digits, 2 decial points (XXX.XX)
	order_dates TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	customer_id INTEGER, 
	FOREIGN KEY(customer_id) REFERENCES customer(customer_id) ON DELETE SET NULL 
);

SELECT * FROM receipt 

-- DML Statements to Add Data into the tables 
INSERT INTO customer(
	first_name,
	last_name,
	email,
	address,
	city,
	state
) VALUES
('George', 'Washington', 'firstpres@usa.gov', '3200 Mt. Vernon Way', 'Mt. Vernon', 'VA'),
('John', 'Adams', 'jadams@whitehouse.org', '1234 W Presidential Place', 'Quincy', 'MA'),
('Thomas', 'Jefferson', 'iwrotethedeclaration@freeamerica.org', '555 Independence Drive', 'Charleston', 'VA'),
('James', 'Madison', 'fatherofconstitution@prez.io', '8345 E Eastern Ave', 'Richmond', 'VA'),
('James', 'Monroe', 'jmonroe@usa.gov', '3682 N Monroe Parkway', 'Chicago', 'IL');

SELECT * FROM customer c ;

-- ADD some data to the receipt table (copying to have different time stamps but you could put all in one)

INSERT INTO receipt(
	amount,
	customer_id 
) VALUES (99.99, 1);

INSERT INTO receipt(
	amount,
	customer_id 
) VALUES (55.43, 3);

INSERT INTO receipt(
	amount,
	customer_id 
) VALUES (325.98, 1);

INSERT INTO receipt(
	amount,
	customer_id 
) VALUES (45.45, 2);

INSERT INTO receipt(
	amount,
	customer_id 
) VALUES (123.45, null);

INSERT INTO receipt(
	amount,
	customer_id 
) VALUES (543.21, null);

SELECT * FROM receipt r;

-- Get the information about customer ID 1 
-- without joining customer and receipt tables, we would have to do two separate queries
SELECT * FROM customer c WHERE customer_id = 1;
SELECT * FROM receipt r WHERE customer_id = 1;

-- Using JOINS, we can combine the tables together on a common field (usually the FK and PK)
-- Snytax: 
-- SELECT col_1, col_2, etc. (can be from either table)
-- FROM table_name_1 (considered the left table)
-- JOIN table_name_2 (considered the right table) 
-- ON table_name_1.col_name = table_name_2.col_name (where col_name is FK to other col_name PK)

-- INNER JOIN
SELECT * FROM customer
JOIN receipt 
ON customer.customer_id = receipt.customer_id; 

SELECT first_name, last_name, c.customer_id AS cust_cust_id, r.customer_id AS rec_cust_id, receipt_id, order_dates, amount
FROM customer c 
JOIN receipt r 
ON c.customer_id = r.customer_id;


-- Each join
-- JOIN or INNER JOIN - returns records that have matching values in both tables
SELECT * 
FROM customer c 
JOIN receipt r
ON c.customer_id = r.customer_id;

-- FULL JOIN - Return all records from both tables, will match if available, otherwise display NULL 
SELECT * 
FROM customer c 
FULL JOIN receipt r
ON c.customer_id = r.customer_id; 

-- LEFT JOIN - Return all records from the left, and only matching data from the right table 
SELECT * 
FROM customer c 
LEFT JOIN receipt r
ON c.customer_id = r.customer_id; 
