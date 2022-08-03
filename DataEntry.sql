--Lab 9
CREATE OR REPLACE TRIGGER ValidStock BEFORE INSERT OR UPDATE ON Stock
FOR EACH ROW
DECLARE
	minQuantity Stock.Quantity%type := 0;
BEGIN
	IF :new.Quantity<minQuantity THEN
	 	RAISE_APPLICATION_ERROR(-20000,'Invalid Stock');
	END IF;
END;
/





--Lab 2

-- Value Insertion into table Customer
insert into Customer values(1,'Rashed','Rashedul','Ghani','12345','Dhaka,Bangladesh','01621299293');
insert into Customer values(2,'Rahat','Rahat','Islam','12245','Narsingdi,Bangladesh','01831298293');
insert into Customer values(3,'Taj','Tajmilur','Rahman','22222','Jessore,Bangladesh','01711337202');
insert into Customer values(4,'Emdad','Emdadul','Hoque','466589','Kushtia,Bangladesh','01923122696');
insert into Customer values(5,'Mahim','Mahim','Islam','1211745','Dhaka,Bangladesh','01621299293');
insert into Customer values(6,'Zaf','Zafrul','Islam','1297245','Narsingdi,Bangladesh','01831298293');
insert into Customer values(7,'Saad','Asif','Saad','2212222','Jessore,Bangladesh','01711337202');
insert into Customer values(8,'Mobarak','Mobarak','Islam','466581139','Kushtia,Bangladesh','01923122696');
insert into Customer values(9,'Mitu','Mitu','Islam','1235945','Dhaka,Bangladesh','01721299293');
insert into Customer values(10,'Taieba','Taieba','Salsabil','1257345','Dhaka,Bangladesh','01821299293');

-- Value Insertion into table Category
insert into Category values(11,'MotherBoard');
insert into Category values(12,'Processor');
insert into Category values(13,'RAM');
insert into Category values(14,'HardDisk');
insert into Category values(15,'GPU');
insert into Category values(16,'KeyBoard');
insert into Category values(17,'Mouse');
insert into Category values(18,'Speaker');
insert into Category values(19,'Monitor');
insert into Category values(20,'Mic');
insert into Category values(21,'Sound Card');

-- Value Insertion into table ComputerParts
insert into ComputerParts values(111,'GA B85-H3D',5000,11);
insert into ComputerParts values(112,'GA B110M',8000,11);
insert into ComputerParts values(211,'Intel Core i3-9100',11000,12);
insert into ComputerParts values(212,'Intel Core i5-9400f',15000,12);
insert into ComputerParts values(311,'Transcend 8GB DDR4',3000,13);
insert into ComputerParts values(312,'Transcend 16GB DDR4',5500,13);
insert into ComputerParts values(412,'WD 1 TB SATA',4500,14);
insert into ComputerParts values(511,'Nvidia RTX 3070',55000,15);
insert into ComputerParts values(512,'AMD RX570',15000,15);
insert into ComputerParts values(611,'Logitech G Pro',4500,16);
insert into ComputerParts values(612,'RED DRAGON',5500,16);
insert into ComputerParts values(711,'Razer Viper Mini',2500,17);
insert into ComputerParts values(811,'Razer Speaker',3500,18);
insert into ComputerParts values(911,'Dell 24 inch',15000,19);
insert into ComputerParts values(1011,'Dell mic',1500,20);


-- Value Insertion into table Stock
insert into Stock values(111,12);
insert into Stock values(112,15);
insert into Stock values(211,-1);
insert into Stock values(212,25);
insert into Stock values(311,19);
insert into Stock values(312,7);
insert into Stock values(412,10);
insert into Stock values(511,5);
insert into Stock values(512,15);
insert into Stock values(611,20);
insert into Stock values(612,27);
insert into Stock values(711,25);
insert into Stock values(811,30);
insert into Stock values(911,15);
insert into Stock values(1011,5);

-- Value Insertion into table Cart
insert into Cart values(1,2,111,2,10000);
insert into Cart values(2,2,212,1,15000);
insert into Cart values(3,2,312,2,11000);
insert into Cart values(4,2,412,1,55000);
insert into Cart values(5,10,511,1,55000);
insert into Cart values(6,10,312,2,11000);
insert into Cart values(7,10,611,1,4500);
insert into Cart values(8,3,612,1,5500);
insert into Cart values(9,3,711,1,2500);
insert into Cart values(10,3,911,1,15000);
insert into Cart values(11,4,811,1,3500);
insert into Cart values(12,4,1011,1,1500);
insert into Cart values(13,4,412,1,4500);
insert into Cart values(14,4,512,1,15000);

---Value Insertion into table Payment
insert into Payment values(1,2,25000,'Cash','3-JUL-22');
insert into Payment values(2,2,66000,'Card','19-JAN-22');
insert into Payment values(3,10,55000,'Cash','23-FEB-22');
insert into Payment values(4,10,15500,'Card','25-NOV-21');
insert into Payment values(5,3,8000,'Cash','15-MAR-22');
insert into Payment values(6,3,15000,'Card','7-APR-22');
insert into Payment values(7,4,5000,'Cash','9-DEC-20');
insert into Payment values(8,4,15000,'Card','1-MAY-22');


