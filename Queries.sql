--Lab 2
SELECT * FROM TAB;
SELECT * FROM Customer;
SELECT * FROM Category;
SELECT * FROM ComputerParts;
SELECT * FROM Stock;
SELECT * FROM Cart;
SELECT * FROM Payment;

SELECT User_Name FROM Customer;

UPDATE Customer SET Last_Name='Sarkar' WHERE Customer_id=6;

DELETE FROM Customer WHERE User_Name='Mahim';

SELECT * FROM Customer;

SELECT User_Name FROM Customer;
SELECT Last_Name FROM Customer;

--Lab 3

SELECT DISTINCT(Per_Unit_Price) FROM ComputerParts;

SELECT ALL(Per_Unit_Price) FROM ComputerParts;

SELECT Part_Name,Per_Unit_Price FROM ComputerParts WHERE Category_id = 15;

SELECT Part_Name,Per_Unit_Price FROM ComputerParts WHERE Per_Unit_Price >= 4000 AND Per_Unit_Price <= 11000;

SELECT Part_Name,Per_Unit_Price FROM ComputerParts WHERE Per_Unit_Price IN(15000,3000,4500) ORDER BY Per_Unit_Price;

--Lab 4
SELECT Part_Name FROM ComputerParts WHERE Part_Name LIKE 'Intel%';
SELECT Part_Name FROM ComputerParts WHERE Part_Name LIKE '%GB%';

SELECT Category_id,COUNT(Part_id) FROM ComputerParts GROUP BY Category_id;

SELECT Category_id,AVG(Per_Unit_Price) AS AVG_PRICE FROM ComputerParts GROUP BY Category_id ORDER BY AVG(Per_Unit_Price);


--Lab 5
--SUB QUERY
SELECT Part_id, Category_id, Part_Name FROM ComputerParts WHERE Category_id IN (SELECT Category_id FROM Category WHERE Category_Name='RAM' OR Category_Name='GPU');

SELECT x.Part_id, x.Category_id, x.Part_Name FROM ComputerParts x WHERE Category_id IN (SELECT y.Category_id FROM Category y WHERE Category_Name='HardDisk' OR Category_Name='Mouse');

SELECT Category_id, Per_Unit_Price FROM ComputerParts WHERE Category_id IN (SELECT Category_id FROM Category WHERE Category_Name='RAM' OR Category_Name='GPU');

SELECT Category_id, Per_Unit_Price FROM ComputerParts WHERE Category_id IN (SELECT Category_id FROM Category WHERE Category_Name='GPU' OR Category_Name='Mouse');
--UNION ALL
SELECT Category_id, Per_Unit_Price FROM ComputerParts WHERE Category_id IN (SELECT Category_id FROM Category WHERE Category_Name='RAM' OR Category_Name='GPU') 
UNION ALL
SELECT Category_id, Per_Unit_Price FROM ComputerParts WHERE Category_id IN (SELECT Category_id FROM Category WHERE Category_Name='GPU' OR Category_Name='Mouse');
--UNION
SELECT Category_id, Per_Unit_Price FROM ComputerParts WHERE Category_id IN (SELECT Category_id FROM Category WHERE Category_Name='RAM' OR Category_Name='GPU') 
UNION
SELECT Category_id, Per_Unit_Price FROM ComputerParts WHERE Category_id IN (SELECT Category_id FROM Category WHERE Category_Name='GPU' OR Category_Name='Mouse');
--INTERSECT
SELECT Category_id, Per_Unit_Price FROM ComputerParts WHERE Category_id IN (SELECT Category_id FROM Category WHERE Category_Name='RAM' OR Category_Name='GPU') 
INTERSECT
SELECT Category_id, Per_Unit_Price FROM ComputerParts WHERE Category_id IN (SELECT Category_id FROM Category WHERE Category_Name='GPU' OR Category_Name='Mouse');
--MINUS
SELECT Category_id, Per_Unit_Price FROM ComputerParts WHERE Category_id IN (SELECT Category_id FROM Category WHERE Category_Name='RAM' OR Category_Name='GPU') 
MINUS
SELECT Category_id, Per_Unit_Price FROM ComputerParts WHERE Category_id IN (SELECT Category_id FROM Category WHERE Category_Name='GPU' OR Category_Name='Mouse');

--Lab 6
SELECT p.Part_Name, c.Category_Name 
FROM ComputerParts p JOIN Category c
ON p.Category_id = c.Category_id;

SELECT p.Part_id, p.Part_Name, c.Category_Name 
FROM ComputerParts p JOIN Category c
USING(Category_id);

SELECT Part_Name, c.Category_Name 
FROM ComputerParts NATURAL JOIN Category c;

SELECT p.Part_Name, c.Category_Name 
FROM ComputerParts p LEFT OUTER JOIN Category c
ON p.Category_id = c.Category_id;

SELECT p.Part_Name, c.Category_Name 
FROM ComputerParts p RIGHT OUTER JOIN Category c
ON p.Category_id = c.Category_id;

--lab 7
SET SERVEROUTPUT ON
DECLARE
   min_cost_part ComputerParts.Per_Unit_Price%type;
   min_name ComputerParts.Part_Name%type;
BEGIN
   SELECT MIN(Per_Unit_Price) INTO min_cost_part
   FROM ComputerParts;

   SELECT Part_Name INTO min_name 
   FROM ComputerParts
   WHERE Per_Unit_Price = min_cost_part;

   DBMS_OUTPUT.PUT_LINE('Least Costly Product in The Store is : '|| min_cost_part ||' '||min_name);
   EXCEPTION
      WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/


--Lab 8
--CURSOR
SET SERVEROUTPUT ON
DECLARE
   CURSOR part_cur IS SELECT Part_id, Part_Name FROM ComputerParts;
   part_record part_cur%ROWTYPE;
BEGIN
   OPEN part_cur;
   LOOP
   FETCH part_cur INTO part_record;
   EXIT WHEN part_cur%ROWCOUNT > 6;
   DBMS_OUTPUT.PUT_LINE ('Id : ' || part_record.Part_id || ' ' || part_record.Part_Name);
   END LOOP;
   CLOSE part_cur; 
END;
/

--Procedure 1
SET SERVEROUTPUT ON
CREATE OR REPLACE Procedure Get_Product_Name IS
   p_name ComputerParts.Part_Name%type;
   p_id ComputerParts.Part_id%type;
BEGIN
   p_id := 111;
   SELECT Part_Name INTO p_name 
   FROM ComputerParts
   WHERE Part_id = p_id;
   DBMS_OUTPUT.PUT_LINE('Part name: '||p_name);
END;
/
SHOW ERRORS;

--Calling Procedure
BEGIN
   Get_Product_Name;
END;
/

-- Function 1
SET SERVEROUTPUT ON
CREATE OR REPLACE Function Get_Sold_Count(
   p_name IN ComputerParts.Part_Name%type)
   RETURN NUMBER IS
   p_id ComputerParts.Part_id%type;
   cnt Cart.Quantity%type;
BEGIN
   SELECT Part_id INTO p_id 
   FROM ComputerParts
   WHERE Part_Name = p_name;

   SELECT count(Quantity) INTO cnt
   FROM Cart
   WHERE Part_id = p_id;
   RETURN NVL(cnt,0);
END;
/

--Calling Function

DECLARE 
   p_name ComputerParts.Part_Name%type;
BEGIN
   p_name := 'WD 1 TB SATA';
   DBMS_OUTPUT.PUT_LINE('Total amount of ' || p_name || ' is sold : ' || Get_Sold_Count(p_name));
END;
/

--Lab-9
COMMIT;
SELECT Part_id,Part_Name,Per_Unit_Price FROM ComputerParts;
DELETE FROM ComputerParts WHERE Part_id = 612;
SELECT Part_id,Part_Name,Per_Unit_Price FROM ComputerParts;
ROLLBACK;
SELECT Part_id,Part_Name,Per_Unit_Price FROM ComputerParts;
SAVEPOINT del;
DELETE FROM ComputerParts WHERE Part_id = 612;
SELECT Part_id,Part_Name,Per_Unit_Price FROM ComputerParts;
ROLLBACK TO del;
SELECT Part_id,Part_Name,Per_Unit_Price FROM ComputerParts;

SELECT SYSTIMESTAMP FROM dual;

SELECT Payment_id,Cart_id,Payment_Type,PaymentDate FROM Payment;

SELECT ADD_MONTHS (PaymentDate,+6) AS Six_Months_Extension FROM Payment WHERE Payment_id = 1;

SELECT LAST_DAY(PaymentDate) FROM Payment WHERE Payment_id = 1;

SELECT Payment_Type, EXTRACT(YEAR FROM PaymentDate) AS Pay_Year, EXTRACT(MONTH FROM PaymentDate ) AS Pay_month, EXTRACT(DAY FROM PaymentDate) AS Pay_date FROM Payment WHERE Payment_id = 1;


--VIEW

DROP VIEW CUSTOMER_VIEW;

CREATE VIEW CUSTOMER_VIEW AS
SELECT User_Name,Address,PhoneNo
FROM Customer;

SELECT * FROM CUSTOMER_VIEW;




