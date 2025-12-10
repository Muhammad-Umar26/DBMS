--Q1
CREATE TABLE bank_accounts (
    account_no INT PRIMARY KEY,
    holder_name VARCHAR(50),
    balance INT
);

INSERT INTO bank_accounts VALUES
(1, 'Account A', 30000),
(2, 'Account B', 25000),
(3, 'Account C', 40000);

START TRANSACTION;

--1 
UPDATE bank_accounts SET balance = balance - 5000 WHERE account_no = 1;

--2 
UPDATE bank_accounts SET balance = balance + 5000 WHERE account_no = 2;

--3 
UPDATE bank_accounts SET balance = balance + 9999 WHERE account_no = 3;

--4
ROLLBACK;

--5 
SELECT * FROM bank_accounts;

--Q2
CREATE TABLE inventory (
    item_id INT PRIMARY KEY,
    item_name VARCHAR(50),
    quantity INT
);

INSERT INTO inventory VALUES
(1, 'Item1', 100),
(2, 'Item2', 150),
(3, 'Item3', 200),
(4, 'Item4', 300);

START TRANSACTION;

--1
UPDATE inventory SET quantity = quantity - 10 WHERE item_id = 1;

--2 
SAVEPOINT sp1;

--3 
UPDATE inventory SET quantity = quantity - 20 WHERE item_id = 2;

--4
SAVEPOINT sp2;

--5 
UPDATE inventory SET quantity = quantity - 5 WHERE item_id = 3;

--6 
ROLLBACK TO sp1;

--7 
COMMIT;

--Q3
CREATE TABLE fees (
    student_id INT PRIMARY KEY,
    name VARCHAR(50),
    amount_paid INT,
    total_fee INT
);

INSERT INTO fees VALUES
(1, 'Student1', 20000, 50000),
(2, 'Student2', 15000, 50000),
(3, 'Student3', 30000, 50000);

START TRANSACTION;

--1 
UPDATE fees SET amount_paid = amount_paid + 5000 WHERE student_id = 1;

--2
SAVEPOINT halfway;

--3 
UPDATE fees SET amount_paid = amount_paid + 5000 WHERE student_id = 2;

--4 
ROLLBACK TO halfway;

--5 
COMMIT;

--Q4
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    stock INT
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    product_id INT,
    quantity INT
);

INSERT INTO products VALUES
(1, 'Laptop', 50),
(2, 'Mouse', 100),
(3, 'Keyboard', 80);

INSERT INTO orders VALUES
(1, 1, 2),
(2, 2, 5);

START TRANSACTION;

--1 
UPDATE products SET stock = stock - 5 WHERE product_id = 1;

--2 
INSERT INTO orders VALUES (3, 1, 5);

--3 
DELETE FROM products WHERE product_id = 2;

--4 
ROLLBACK;

--5 
START TRANSACTION;
UPDATE products SET stock = stock - 5 WHERE product_id = 1;
INSERT INTO orders VALUES (3, 1, 5);

--6 
COMMIT;

--Q5
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    salary INT
);

INSERT INTO employees VALUES
(1, 'Emp1', 30000),
(2, 'Emp2', 32000),
(3, 'Emp3', 35000),
(4, 'Emp4', 28000),
(5, 'Emp5', 40000);

START TRANSACTION;

--1
UPDATE employees SET salary = salary + 2000 WHERE emp_id = 1;

--2
SAVEPOINT A;

--3
UPDATE employees SET salary = salary + 3000 WHERE emp_id = 2;

--4
SAVEPOINT B;

--5 
UPDATE employees SET salary = salary + 4000 WHERE emp_id = 3;

--6 
ROLLBACK TO A;

--7 
COMMIT;
