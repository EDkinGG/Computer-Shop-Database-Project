DROP TABLE Payment;
DROP TABLE Cart;
DROP TABLE Stock;
DROP TABLE ComputerParts;
DROP TABLE Category;
DROP TABLE Customer;


CREATE TABLE Customer
(
  Customer_id NUMBER(4)         NOT NULL,
  User_Name VARCHAR2(1024),
  First_Name VARCHAR2(1024),
  Last_Name VARCHAR2(1024),
  Password VARCHAR2(1024),
  Address VARCHAR2(1024),
  PhoneNo VARCHAR2(11)
  --PRIMARY KEY(Customer_id)
); 
--Adding CONSTRAINT into TABLE PATIENT
ALTER TABLE Customer ADD  CONSTRAINT Customer_Pk PRIMARY KEY(Customer_id) ;

CREATE TABLE Category
(
  Category_id NUMBER(4)         NOT NULL,
  Category_Name VARCHAR2(1024)
  --PRIMARY KEY(Category_id)
);
--Adding CONSTRAINT into TABLE Category
ALTER TABLE Category ADD  CONSTRAINT Category_Pk PRIMARY KEY(Category_id);

CREATE TABLE ComputerParts
(
  Part_id NUMBER(4)             NOT NULL,
  Part_Name VARCHAR2(1024),
  Per_Unit_Price NUMBER(9,2),
  Category_id NUMBER(4)
  --PRIMARY KEY(Part_id),
  --FOREIGN KEY(Category_id) REFERENCES Category(Category_id)
);
--Adding CONSTRAINT into TABLE ComputerParts
ALTER TABLE ComputerParts ADD  CONSTRAINT ComputerParts_Pk PRIMARY KEY(Part_id);
ALTER TABLE ComputerParts ADD  CONSTRAINT ComputerParts_Fk FOREIGN KEY(Category_id) REFERENCES Category(Category_id) ON DELETE CASCADE;

CREATE TABLE Stock
(
   Part_id NUMBER(4)             NOT NULL,
   Quantity NUMBER(6)
   --PRIMARY KEY(Part_id) REFERENCES ComputerParts(Part_id)
);
--Adding CONSTRAINT into Stock
ALTER TABLE Stock ADD  CONSTRAINT Stock_Fk FOREIGN KEY(Part_id) REFERENCES ComputerParts(Part_id) ON DELETE CASCADE;
ALTER TABLE Stock ADD  CONSTRAINT Stock_Pk PRIMARY KEY(Part_id);


CREATE TABLE Cart
(
  Item_num NUMBER(4)            NOT NULL,
  Cart_id NUMBER(4)             NOT NULL,
  Part_id NUMBER(4)             NOT NULL,
  Quantity NUMBER(6),
  Total_Cost NUMBER(11,2)
  --PRIMARY KEY(Cart_id) REFERENCES Customer(Customer_id),
  --FOREIGN KEY(Part_id) REFERENCES ComputerParts(Part_id)
);
--Adding CONSTRAINT into Cart
ALTER TABLE Cart ADD  CONSTRAINT Cart_Fk FOREIGN KEY(Part_id) REFERENCES ComputerParts(Part_id) ON DELETE CASCADE;
ALTER TABLE Cart ADD  CONSTRAINT Cart_FFk FOREIGN KEY(Cart_id) REFERENCES Customer(Customer_id) ON DELETE CASCADE;
ALTER TABLE Cart ADD  CONSTRAINT Cart_Pk PRIMARY KEY(Item_num);


CREATE TABLE Payment
(
  Payment_id NUMBER(4)          NOT NULL,
  Cart_id NUMBER(4)             NOT NULL,
  Amount NUMBER(11,2),
  Payment_Type VARCHAR2(1024),
  PaymentDate DATE
  --PRIMARY KEY(Payment_id),
  --FOREIGN KEY(Cart_id) REFERENCES Cart(Cart_id)
);
--Adding CONSTRAINT into Payment
ALTER TABLE Payment ADD CONSTRAINT Payment_Pk PRIMARY KEY(Payment_id);
ALTER TABLE Payment ADD CONSTRAINT Payment_Fk FOREIGN KEY(Cart_id) REFERENCES Customer(Customer_id) ON DELETE CASCADE;

DESCRIBE Customer;
DESCRIBE Category;
DESCRIBE ComputerParts;
DESCRIBE Stock;
DESCRIBE Cart;
DESCRIBE Payment;