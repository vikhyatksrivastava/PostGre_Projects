CREATE TABLE "Employee".member_address (
    member_id VARCHAR(50),
    city VARCHAR(100),
    address_type VARCHAR(50),
    address_type_code VARCHAR(20)
);

alter table "Employee".member_physical_address rename to member_address;

INSERT INTO "Employee".member_address(member_id, city, address_type, address_type_code) VALUES('EMP_01','New Delhi','Physical','P');
INSERT INTO "Employee".member_address(member_id, city, address_type, address_type_code) VALUES('EMP_01','Greater Noida (West)','Mailing','M');
INSERT INTO "Employee".member_address(member_id, city, address_type, address_type_code) VALUES('EMP_02','Gurugram','Physical','P');
INSERT INTO "Employee".member_address(member_id, city, address_type, address_type_code) VALUES('EMP_03','Jaunpur','Mailing','M');

UPDATE "Employee".member_address SET member_id = 'EMP_02' where city in ('Gurugram','Jaunpur');

select * from "Employee".member_address ;

Getting data into single row from multiple rows.

WITH physical_loc (member_id, city, address_type) AS (
  SELECT member_id, city, address_type
  FROM "Employee".member_address
  WHERE address_type_code = 'P'
),
mailing_loc (member_id, city, address_type) AS (
  SELECT member_id, city, address_type
  FROM "Employee".member_address
  WHERE address_type_code = 'M'
)
SELECT pl.member_id, pl.city AS physical_city, pl.address_type, 
       ml.city AS mailing_city, ml.address_type
FROM physical_loc pl
JOIN mailing_loc ml ON pl.member_id = ml.member_id;
