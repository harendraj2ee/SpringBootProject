--------------------------------------------------------
--  File created - Wednesday-October-09-2019   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table RC_REPORT
--------------------------------------------------------

  CREATE TABLE "TASDB"."RC_REPORT" 
   (	"REPORT_ID" NUMBER(9,0), 
	"REPORT_NAME" VARCHAR2(100 BYTE), 
	"DB_OBJECT_ID" VARCHAR2(100 BYTE), 
	"REPORT_ACTION" VARCHAR2(100 BYTE), 
	"REPORT_GROUP_NAME" VARCHAR2(100 BYTE), 
	"REPORT_TYPE" VARCHAR2(100 BYTE), 
	"REPORT_ACTIVE" CHAR(1 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table RC_REPORT_GROUP
--------------------------------------------------------

  CREATE TABLE "TASDB"."RC_REPORT_GROUP" 
   (	"REPORT_GROUP_NAME" VARCHAR2(100 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table RC_REPORT_RUN_LOG
--------------------------------------------------------

  CREATE TABLE "TASDB"."RC_REPORT_RUN_LOG" 
   (	"REPORT_ID" NUMBER(9,0), 
	"START_TIME" DATE, 
	"END_TIME" DATE, 
	"RESULT_TEXT" VARCHAR2(4000 BYTE)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table RC_REPORT_SCHEDULE
--------------------------------------------------------

  CREATE TABLE "TASDB"."RC_REPORT_SCHEDULE" 
   (	"REPORT_ID" NUMBER(9,0), 
	"SCHEDULE_TYPE" VARCHAR2(50 BYTE), 
	"SCHEDULE_DAY" NUMBER(5,0), 
	"SCHEDULE_TIME" VARCHAR2(4 BYTE), 
	"RUNNING_STATUS" VARCHAR2(50 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table UC_REPORT_ACCESS
--------------------------------------------------------

  CREATE TABLE "TASDB"."UC_REPORT_ACCESS" 
   (	"USER_ROLE_NAME" VARCHAR2(50 BYTE), 
	"REPORT_ID" NUMBER(9,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table UC_USER_DETAILS
--------------------------------------------------------

  CREATE TABLE "TASDB"."UC_USER_DETAILS" 
   (	"USER_ID" VARCHAR2(50 BYTE), 
	"FULL_NAME" VARCHAR2(100 BYTE), 
	"EMAIL" VARCHAR2(100 BYTE), 
	"PHONE" VARCHAR2(20 BYTE), 
	"MANAGER_ID" VARCHAR2(50 BYTE), 
	"MANAGER_EMAIL" VARCHAR2(100 BYTE), 
	"MANAGER_PHONE" VARCHAR2(20 BYTE), 
	"PASSWORD" VARCHAR2(200 BYTE), 
	"ACTIVE" CHAR(1 BYTE), 
	"CREATE_DATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table UC_USER_ROLE
--------------------------------------------------------

  CREATE TABLE "TASDB"."UC_USER_ROLE" 
   (	"USER_ROLE_NAME" VARCHAR2(50 BYTE), 
	"HOMEPAGE_ID" VARCHAR2(1000 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Table UC_USER_ROLE_MAPPING
--------------------------------------------------------

  CREATE TABLE "TASDB"."UC_USER_ROLE_MAPPING" 
   (	"USER_ROLE_NAME" VARCHAR2(50 BYTE), 
	"USER_ID" VARCHAR2(50 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for View RC_REPORT_SCHEDULE_CHECK
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "TASDB"."RC_REPORT_SCHEDULE_CHECK" ("REPORT_ID", "REPORT_NAME", "DB_OBJECT_ID") AS 
  SELECT r.report_id, r.report_name, r.db_object_id
  FROM rc_report r,
       rc_report_schedule rs
 WHERE     UPPER (rs.running_status) NOT LIKE 'RUNNING'
       AND UPPER (r.report_type) = 'SCHEDULED'
       AND rs.report_id = r.report_id
       AND r.report_active = 'Y'
       AND UPPER (rs.schedule_type) = 'DAILY'
       AND TO_NUMBER (rs.schedule_time) <
              TO_NUMBER (TO_CHAR (SYSDATE, 'hh24mi'))
       AND r.reporT_id NOT IN
              (SELECT reporT_id
                 FROM rc_report_run_log
                WHERE TO_CHAR (start_time, 'dd-mon-yyyy') =
                         TO_CHAR (SYSDATE, 'dd-mon-yyyy'))
;
--------------------------------------------------------
--  DDL for View VUC_USER_DETAILS
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "TASDB"."VUC_USER_DETAILS" ("USER_ID", "FULL_NAME", "EMAIL", "PHONE", "MANAGER_ID", "MANAGER_EMAIL", "MANAGER_PHONE", "ENCRYPTED_PASSWORD", "ACTIVE", "CREATE_DATE") AS 
  SELECT "USER_ID",
          "FULL_NAME",
          "EMAIL",
          "PHONE",
          "MANAGER_ID",
          "MANAGER_EMAIL",
          "MANAGER_PHONE",
          "PASSWORD",
          "ACTIVE",
          "CREATE_DATE"
     FROM uc_user_details
;
--------------------------------------------------------
--  DDL for View VUC_USER_ROLE
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "TASDB"."VUC_USER_ROLE" ("USER_ROLE_NAME", "HOMEPAGE_ID") AS 
  select "USER_ROLE_NAME","HOMEPAGE_ID" from UC_USER_ROLE
;
--------------------------------------------------------
--  DDL for View VUC_USER_ROLE_MAPPING
--------------------------------------------------------

  CREATE OR REPLACE FORCE EDITIONABLE VIEW "TASDB"."VUC_USER_ROLE_MAPPING" ("USER_ROLE_NAME", "USER_ID") AS 
  select "USER_ROLE_NAME","USER_ID" from UC_USER_ROLE_MAPPING
;
REM INSERTING into TASDB.RC_REPORT
SET DEFINE OFF;
Insert into TASDB.RC_REPORT (REPORT_ID,REPORT_NAME,DB_OBJECT_ID,REPORT_ACTION,REPORT_GROUP_NAME,REPORT_TYPE,REPORT_ACTIVE) values (1,'TEST_REPORT','VW_REPORT_1','XX','TEST_GROUP','SCHEDULED','Y');
REM INSERTING into TASDB.RC_REPORT_GROUP
SET DEFINE OFF;
Insert into TASDB.RC_REPORT_GROUP (REPORT_GROUP_NAME) values ('TEST_GROUP');
REM INSERTING into TASDB.RC_REPORT_RUN_LOG
SET DEFINE OFF;
REM INSERTING into TASDB.RC_REPORT_SCHEDULE
SET DEFINE OFF;
Insert into TASDB.RC_REPORT_SCHEDULE (REPORT_ID,SCHEDULE_TYPE,SCHEDULE_DAY,SCHEDULE_TIME,RUNNING_STATUS) values (1,'DAILY',0,'1500','PENDING');
REM INSERTING into TASDB.UC_REPORT_ACCESS
SET DEFINE OFF;
REM INSERTING into TASDB.UC_USER_DETAILS
SET DEFINE OFF;
Insert into TASDB.UC_USER_DETAILS (USER_ID,FULL_NAME,EMAIL,PHONE,MANAGER_ID,MANAGER_EMAIL,MANAGER_PHONE,PASSWORD,ACTIVE,CREATE_DATE) values ('air1234','Anuj','alkjlj@airtel.com','8877887799','2234','anuj@airtel.com','8899888998','12345','Y',to_date('24-09-19','DD-MM-RR'));
Insert into TASDB.UC_USER_DETAILS (USER_ID,FULL_NAME,EMAIL,PHONE,MANAGER_ID,MANAGER_EMAIL,MANAGER_PHONE,PASSWORD,ACTIVE,CREATE_DATE) values ('abdcde12','AK singh','abcd@airtel.com','8877887799','2424','xyz@in.ibm.com','9998886644','xdsfsf','Y',to_date('23-09-19','DD-MM-RR'));
Insert into TASDB.UC_USER_DETAILS (USER_ID,FULL_NAME,EMAIL,PHONE,MANAGER_ID,MANAGER_EMAIL,MANAGER_PHONE,PASSWORD,ACTIVE,CREATE_DATE) values ('h123jk','Avinash','alkjjj@airtel.com','8877887799','22242','abdk@airtel.com','0987654327','asdfgh','Y',to_date('24-09-19','DD-MM-RR'));
Insert into TASDB.UC_USER_DETAILS (USER_ID,FULL_NAME,EMAIL,PHONE,MANAGER_ID,MANAGER_EMAIL,MANAGER_PHONE,PASSWORD,ACTIVE,CREATE_DATE) values ('ASHISH','test','admin@airtel.in','9810709558','a1dv52yu','admin@airtel.in','9810709558','YYut1Yfoq+pi+4mUqNU7bQ==','Y',to_date('13-09-19','DD-MM-RR'));
Insert into TASDB.UC_USER_DETAILS (USER_ID,FULL_NAME,EMAIL,PHONE,MANAGER_ID,MANAGER_EMAIL,MANAGER_PHONE,PASSWORD,ACTIVE,CREATE_DATE) values ('MUKESH','Mukesh Tiwari','admin@airtel.in','9810709558','a1dv52yu','admin@airtel.in','9810709558','YYut1Yfoq+pi+4mUqNU7bQ==','Y',to_date('13-09-19','DD-MM-RR'));
Insert into TASDB.UC_USER_DETAILS (USER_ID,FULL_NAME,EMAIL,PHONE,MANAGER_ID,MANAGER_EMAIL,MANAGER_PHONE,PASSWORD,ACTIVE,CREATE_DATE) values ('A1RETR3F','Mukesh Tiwari','admin@airtel.in','9810709558','a1dv52yu','admin@airtel.in','9810709558','YYut1Yfoq+pi+4mUqNU7bQ==','Y',to_date('13-09-19','DD-MM-RR'));
Insert into TASDB.UC_USER_DETAILS (USER_ID,FULL_NAME,EMAIL,PHONE,MANAGER_ID,MANAGER_EMAIL,MANAGER_PHONE,PASSWORD,ACTIVE,CREATE_DATE) values ('AB12JH','Sanju','dskadjdks@gmail.com','8877887799','GF3423','kumar@gmail.com','9988776655','abcdkd','N',to_date('23-09-19','DD-MM-RR'));
Insert into TASDB.UC_USER_DETAILS (USER_ID,FULL_NAME,EMAIL,PHONE,MANAGER_ID,MANAGER_EMAIL,MANAGER_PHONE,PASSWORD,ACTIVE,CREATE_DATE) values ('123wqe','Vivek Kumar','alkjlj@airtel.com','8877887799','2424fsd','abcccc@airtel.com','dsada12','a123456','Y',to_date('23-09-19','DD-MM-RR'));
Insert into TASDB.UC_USER_DETAILS (USER_ID,FULL_NAME,EMAIL,PHONE,MANAGER_ID,MANAGER_EMAIL,MANAGER_PHONE,PASSWORD,ACTIVE,CREATE_DATE) values ('BBRR321','Suraj Prakash','prakash@airtel.com','7787779970','2221qsw','sumit@airtel.com','8888899876','e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855','N',to_date('23-09-19','DD-MM-RR'));
Insert into TASDB.UC_USER_DETAILS (USER_ID,FULL_NAME,EMAIL,PHONE,MANAGER_ID,MANAGER_EMAIL,MANAGER_PHONE,PASSWORD,ACTIVE,CREATE_DATE) values ('AB12RV2','Vishnu','xyz@airtel.com','28782174821','877777','aud@airtel.com','0987654321','e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855','N',to_date('24-09-19','DD-MM-RR'));
Insert into TASDB.UC_USER_DETAILS (USER_ID,FULL_NAME,EMAIL,PHONE,MANAGER_ID,MANAGER_EMAIL,MANAGER_PHONE,PASSWORD,ACTIVE,CREATE_DATE) values ('12vsew','Suriya','alkjljk@airtel.com','8877887799','2234','tina@airtel.com','8899888998','123455','Y',to_date('24-09-19','DD-MM-RR'));
Insert into TASDB.UC_USER_DETAILS (USER_ID,FULL_NAME,EMAIL,PHONE,MANAGER_ID,MANAGER_EMAIL,MANAGER_PHONE,PASSWORD,ACTIVE,CREATE_DATE) values ('ASDE213','harendra','harendra@ibm.com','9968444679','AIR1243','xyz@in.ibm.com','9978666878','SCKrBUbdfKOFiOrG+Mwhew==','Y',to_date('24-09-19','DD-MM-RR'));
Insert into TASDB.UC_USER_DETAILS (USER_ID,FULL_NAME,EMAIL,PHONE,MANAGER_ID,MANAGER_EMAIL,MANAGER_PHONE,PASSWORD,ACTIVE,CREATE_DATE) values ('HKS12343','Jitesh','alkjlj@airtel.com','9968444679','AIR1243','xyz@in.ibm.com','9978666878','/UHy5KHJ0hGaqw+8pjUDzA==','Y',to_date('01-10-19','DD-MM-RR'));
Insert into TASDB.UC_USER_DETAILS (USER_ID,FULL_NAME,EMAIL,PHONE,MANAGER_ID,MANAGER_EMAIL,MANAGER_PHONE,PASSWORD,ACTIVE,CREATE_DATE) values ('PRA123','Prakas','prks@airtel.com','9968444679','ABR123','suraj@airtel.com','9978666878','pcRb7HnAOdaNbh5zHyn86g==','Y',to_date('01-10-19','DD-MM-RR'));
Insert into TASDB.UC_USER_DETAILS (USER_ID,FULL_NAME,EMAIL,PHONE,MANAGER_ID,MANAGER_EMAIL,MANAGER_PHONE,PASSWORD,ACTIVE,CREATE_DATE) values ('KUMAR123','Prakas','prks@airtel.com','9968444679','ABR123','suraj@airtel.com','9978666878','U2Np1nr/D/2j8KNhiL0Nsw==','Y',to_date('01-10-19','DD-MM-RR'));
Insert into TASDB.UC_USER_DETAILS (USER_ID,FULL_NAME,EMAIL,PHONE,MANAGER_ID,MANAGER_EMAIL,MANAGER_PHONE,PASSWORD,ACTIVE,CREATE_DATE) values ('RAJ123','Rajendra','rajendra@airtel.com','8888876541',null,'rj@airtel.com','8888999567','lLqjU14uUYv2yNVFgezlYg==','N',to_date('01-10-19','DD-MM-RR'));
Insert into TASDB.UC_USER_DETAILS (USER_ID,FULL_NAME,EMAIL,PHONE,MANAGER_ID,MANAGER_EMAIL,MANAGER_PHONE,PASSWORD,ACTIVE,CREATE_DATE) values ('Prakash','Prakash Singh','pksdg@in.ibm.com','8777788865','sdf33','xyz@in.ibm.com','9998886633','1234$raj','N',to_date('23-09-19','DD-MM-RR'));
Insert into TASDB.UC_USER_DETAILS (USER_ID,FULL_NAME,EMAIL,PHONE,MANAGER_ID,MANAGER_EMAIL,MANAGER_PHONE,PASSWORD,ACTIVE,CREATE_DATE) values ('ARB123','Piyush','abcddd@airtel.com','8877887799','2234','xyzzzz@in.ibm.com','8899888998','xyzaaa','Y',to_date('23-09-19','DD-MM-RR'));
Insert into TASDB.UC_USER_DETAILS (USER_ID,FULL_NAME,EMAIL,PHONE,MANAGER_ID,MANAGER_EMAIL,MANAGER_PHONE,PASSWORD,ACTIVE,CREATE_DATE) values ('123wqeq','Vivek Kumar','alkjlj@airtel.com','8877887799','2424fsd','abcccc@airtel.com','dsada12','sssssss','Y',to_date('23-09-19','DD-MM-RR'));
Insert into TASDB.UC_USER_DETAILS (USER_ID,FULL_NAME,EMAIL,PHONE,MANAGER_ID,MANAGER_EMAIL,MANAGER_PHONE,PASSWORD,ACTIVE,CREATE_DATE) values ('AAIRR123','Suraj Prakash','prakash@airtel.com','7787779970','2221qsw','sumit@airtel.com','8888899876','e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855','Y',to_date('23-09-19','DD-MM-RR'));
Insert into TASDB.UC_USER_DETAILS (USER_ID,FULL_NAME,EMAIL,PHONE,MANAGER_ID,MANAGER_EMAIL,MANAGER_PHONE,PASSWORD,ACTIVE,CREATE_DATE) values ('ar12fed12','Suraj','abtd@airtel.com','8877887799','2234','abddd@airtel.com','8899888998','123456','N',to_date('24-09-19','DD-MM-RR'));
Insert into TASDB.UC_USER_DETAILS (USER_ID,FULL_NAME,EMAIL,PHONE,MANAGER_ID,MANAGER_EMAIL,MANAGER_PHONE,PASSWORD,ACTIVE,CREATE_DATE) values ('ABC123','Animesh','animesh@in.ibm.com','9968444679','123ABC',null,null,'wGREoP12sE1Ltch6/+ZmDg==','Y',to_date('24-09-19','DD-MM-RR'));
Insert into TASDB.UC_USER_DETAILS (USER_ID,FULL_NAME,EMAIL,PHONE,MANAGER_ID,MANAGER_EMAIL,MANAGER_PHONE,PASSWORD,ACTIVE,CREATE_DATE) values ('HKS123','Harendra','harens44@in.ibm.com','9968444679','ABC123','mukesh@in.ibm.com','9978666878','fl+Dt+8BDbqiGtMdO4sH4A==','Y',to_date('24-09-19','DD-MM-RR'));
Insert into TASDB.UC_USER_DETAILS (USER_ID,FULL_NAME,EMAIL,PHONE,MANAGER_ID,MANAGER_EMAIL,MANAGER_PHONE,PASSWORD,ACTIVE,CREATE_DATE) values ('HKS12322','Hare','hns44@in.ibm.com','9968444679','ABC123','mukesh@in.ibm.com','9978666878','74Z1w16Hd2a+aHfDzPybYQ==','Y',to_date('24-09-19','DD-MM-RR'));
Insert into TASDB.UC_USER_DETAILS (USER_ID,FULL_NAME,EMAIL,PHONE,MANAGER_ID,MANAGER_EMAIL,MANAGER_PHONE,PASSWORD,ACTIVE,CREATE_DATE) values ('RAHUL','Rahul','r@airtel.com','9968444679','ABC123','jk@airtel.com','9978666878','IMYL2li8xBpJ2HW26WRIjw==','N',to_date('30-09-19','DD-MM-RR'));
Insert into TASDB.UC_USER_DETAILS (USER_ID,FULL_NAME,EMAIL,PHONE,MANAGER_ID,MANAGER_EMAIL,MANAGER_PHONE,PASSWORD,ACTIVE,CREATE_DATE) values ('Jitesh','Jitesh Gupta','jitesh@gmail.com','7877886655','yttiiu2','ritesh@gmail.com','7788996655','kumar%456','Y',to_date('23-09-19','DD-MM-RR'));
Insert into TASDB.UC_USER_DETAILS (USER_ID,FULL_NAME,EMAIL,PHONE,MANAGER_ID,MANAGER_EMAIL,MANAGER_PHONE,PASSWORD,ACTIVE,CREATE_DATE) values ('Harendra','Harendra Kumar Sah','harens44@in.ibm.com','9968444679','XYZ123','mukesh@in.ibm.com','9971152988','Abcd@123','Y',to_date('23-09-19','DD-MM-RR'));
Insert into TASDB.UC_USER_DETAILS (USER_ID,FULL_NAME,EMAIL,PHONE,MANAGER_ID,MANAGER_EMAIL,MANAGER_PHONE,PASSWORD,ACTIVE,CREATE_DATE) values ('abd938','Dinesh','alkjlj@airtel.com','8877887799','2424fsd','xyz@in.ibm.com','0987654321','kumar@123','N',to_date('23-09-19','DD-MM-RR'));
Insert into TASDB.UC_USER_DETAILS (USER_ID,FULL_NAME,EMAIL,PHONE,MANAGER_ID,MANAGER_EMAIL,MANAGER_PHONE,PASSWORD,ACTIVE,CREATE_DATE) values ('SAURABH','Saurabh Pahwa','admin@airtel.in','9810709558','a1dv52yu','admin@airtel.in','9810709558','p68/ByxfF2mn4rKAwsxOQQ==','Y',to_date('13-09-19','DD-MM-RR'));
Insert into TASDB.UC_USER_DETAILS (USER_ID,FULL_NAME,EMAIL,PHONE,MANAGER_ID,MANAGER_EMAIL,MANAGER_PHONE,PASSWORD,ACTIVE,CREATE_DATE) values ('A1DV52YU','Ritesh Vishwakarma','admin@airtel.in','9810709558','a1dv52yu','admin@airtel.in','9810709558','LywbC5uVq3hp9RqIz7iYNA==','Y',to_date('13-09-19','DD-MM-RR'));
Insert into TASDB.UC_USER_DETAILS (USER_ID,FULL_NAME,EMAIL,PHONE,MANAGER_ID,MANAGER_EMAIL,MANAGER_PHONE,PASSWORD,ACTIVE,CREATE_DATE) values ('ARCD123','Animesh','ani@gmail.com','7654345679','3476tr','ashish@gmail.com','8888999777','pass@123','Y',to_date('23-09-19','DD-MM-RR'));
Insert into TASDB.UC_USER_DETAILS (USER_ID,FULL_NAME,EMAIL,PHONE,MANAGER_ID,MANAGER_EMAIL,MANAGER_PHONE,PASSWORD,ACTIVE,CREATE_DATE) values ('ABC23T','R K sinnha','jaikk@gmail.com','7876787867','sde32','jlkjkl@yahoo.com','9876567877','jkAS','Y',to_date('23-09-19','DD-MM-RR'));
Insert into TASDB.UC_USER_DETAILS (USER_ID,FULL_NAME,EMAIL,PHONE,MANAGER_ID,MANAGER_EMAIL,MANAGER_PHONE,PASSWORD,ACTIVE,CREATE_DATE) values ('dsfsd11','Vivek','alkjlj@airtel.com','8877887799','2424fsd','abcccc@airtel.com','dsada12','123456','Y',to_date('23-09-19','DD-MM-RR'));
Insert into TASDB.UC_USER_DETAILS (USER_ID,FULL_NAME,EMAIL,PHONE,MANAGER_ID,MANAGER_EMAIL,MANAGER_PHONE,PASSWORD,ACTIVE,CREATE_DATE) values ('123wqeqaa','Vivek Kumar','alkjlj@airtel.com','8877887799','2424fsd','abcccc@airtel.com','dsada12','123456','Y',to_date('23-09-19','DD-MM-RR'));
Insert into TASDB.UC_USER_DETAILS (USER_ID,FULL_NAME,EMAIL,PHONE,MANAGER_ID,MANAGER_EMAIL,MANAGER_PHONE,PASSWORD,ACTIVE,CREATE_DATE) values ('123wqeqq','Vivek Kumar','alkjlsj@airtel.com','8877887799','2424fsd','abcccc@airtel.com','dsada12','e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855','N',to_date('23-09-19','DD-MM-RR'));
Insert into TASDB.UC_USER_DETAILS (USER_ID,FULL_NAME,EMAIL,PHONE,MANAGER_ID,MANAGER_EMAIL,MANAGER_PHONE,PASSWORD,ACTIVE,CREATE_DATE) values ('RAJU','Raju','raju@airtel.com','9999977787','AIR2341','manoj@airtel.com','8888877767','HS+geD0Zz09cK0ydxWMbLQ==','Y',to_date('30-09-19','DD-MM-RR'));
Insert into TASDB.UC_USER_DETAILS (USER_ID,FULL_NAME,EMAIL,PHONE,MANAGER_ID,MANAGER_EMAIL,MANAGER_PHONE,PASSWORD,ACTIVE,CREATE_DATE) values ('AKASH','Akash','ak@airtel.com','9968444678','AIR1243','ankus@airtel.com','9178666879','bD9F476pPhCYT6P3K6oWXg==','N',to_date('04-10-19','DD-MM-RR'));
Insert into TASDB.UC_USER_DETAILS (USER_ID,FULL_NAME,EMAIL,PHONE,MANAGER_ID,MANAGER_EMAIL,MANAGER_PHONE,PASSWORD,ACTIVE,CREATE_DATE) values ('PRABHU','prabhu','prabhu@airtel.com','9968444679','ab1234','jk@airtel.com','9978666878','URXMKjdGTeQ2+ooCON68vg==','N',to_date('09-10-19','DD-MM-RR'));
REM INSERTING into TASDB.UC_USER_ROLE
SET DEFINE OFF;
Insert into TASDB.UC_USER_ROLE (USER_ROLE_NAME,HOMEPAGE_ID) values ('USER_ROLE','user/HomePage');
Insert into TASDB.UC_USER_ROLE (USER_ROLE_NAME,HOMEPAGE_ID) values ('USER_ADMIN','Dashboard');
REM INSERTING into TASDB.UC_USER_ROLE_MAPPING
SET DEFINE OFF;
Insert into TASDB.UC_USER_ROLE_MAPPING (USER_ROLE_NAME,USER_ID) values ('USER_ROLE','A1DV52YU');
Insert into TASDB.UC_USER_ROLE_MAPPING (USER_ROLE_NAME,USER_ID) values ('USER_ROLE','ASHISH');
Insert into TASDB.UC_USER_ROLE_MAPPING (USER_ROLE_NAME,USER_ID) values ('USER_ROLE','MUKESH');
Insert into TASDB.UC_USER_ROLE_MAPPING (USER_ROLE_NAME,USER_ID) values ('USER_ADMIN','MUKESH');
Insert into TASDB.UC_USER_ROLE_MAPPING (USER_ROLE_NAME,USER_ID) values ('USER_ROLE','A1RETR3F');
Insert into TASDB.UC_USER_ROLE_MAPPING (USER_ROLE_NAME,USER_ID) values ('USER_ADMIN','A1RETR3F');
Insert into TASDB.UC_USER_ROLE_MAPPING (USER_ROLE_NAME,USER_ID) values ('USER_ROLE','ASDE213');
Insert into TASDB.UC_USER_ROLE_MAPPING (USER_ROLE_NAME,USER_ID) values ('USER_ROLE','HKS12343');
Insert into TASDB.UC_USER_ROLE_MAPPING (USER_ROLE_NAME,USER_ID) values ('USER_ADMIN','PRA123');
Insert into TASDB.UC_USER_ROLE_MAPPING (USER_ROLE_NAME,USER_ID) values ('USER_ADMIN','KUMAR123');
Insert into TASDB.UC_USER_ROLE_MAPPING (USER_ROLE_NAME,USER_ID) values ('USER_ROLE','KUMAR123');
Insert into TASDB.UC_USER_ROLE_MAPPING (USER_ROLE_NAME,USER_ID) values ('USER_ADMIN','RAJ123');
Insert into TASDB.UC_USER_ROLE_MAPPING (USER_ROLE_NAME,USER_ID) values ('USER_ROLE','ABC123');
Insert into TASDB.UC_USER_ROLE_MAPPING (USER_ROLE_NAME,USER_ID) values ('USER_ROLE','HKS123');
Insert into TASDB.UC_USER_ROLE_MAPPING (USER_ROLE_NAME,USER_ID) values ('USER_ROLE','HKS12322');
Insert into TASDB.UC_USER_ROLE_MAPPING (USER_ROLE_NAME,USER_ID) values ('USER_ROLE','RAHUL');
Insert into TASDB.UC_USER_ROLE_MAPPING (USER_ROLE_NAME,USER_ID) values ('USER_ADMIN','AKASH');
Insert into TASDB.UC_USER_ROLE_MAPPING (USER_ROLE_NAME,USER_ID) values ('USER_ROLE','SAURABH');
Insert into TASDB.UC_USER_ROLE_MAPPING (USER_ROLE_NAME,USER_ID) values ('USER_ADMIN','SAURABH');
Insert into TASDB.UC_USER_ROLE_MAPPING (USER_ROLE_NAME,USER_ID) values ('USER_ROLE','RAJU');
Insert into TASDB.UC_USER_ROLE_MAPPING (USER_ROLE_NAME,USER_ID) values ('USER_ROLE','AKASH');
Insert into TASDB.UC_USER_ROLE_MAPPING (USER_ROLE_NAME,USER_ID) values ('USER_ADMIN','PRABHU');
--------------------------------------------------------
--  DDL for Index PK_RC_REPORT
--------------------------------------------------------

  CREATE UNIQUE INDEX "TASDB"."PK_RC_REPORT" ON "TASDB"."RC_REPORT" ("REPORT_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index PK_RC_REPORT_GROUP
--------------------------------------------------------

  CREATE UNIQUE INDEX "TASDB"."PK_RC_REPORT_GROUP" ON "TASDB"."RC_REPORT_GROUP" ("REPORT_GROUP_NAME") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index PK_UC_USER_ROLE
--------------------------------------------------------

  CREATE UNIQUE INDEX "TASDB"."PK_UC_USER_ROLE" ON "TASDB"."UC_USER_ROLE" ("USER_ROLE_NAME") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Index PK_UC_USER_DETAILS
--------------------------------------------------------

  CREATE UNIQUE INDEX "TASDB"."PK_UC_USER_DETAILS" ON "TASDB"."UC_USER_DETAILS" ("USER_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
--------------------------------------------------------
--  DDL for Procedure PUC_ADD_ROLE
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "TASDB"."PUC_ADD_ROLE" (p_user_role         VARCHAR2,
                                          p_homepage_id       VARCHAR2,
                                          p_result_text   OUT VARCHAR2)
AS
   v_result_text   VARCHAR2 (4000);
   excp_err        EXCEPTION;
   v_exists        NUMBER (9);
BEGIN
   IF p_user_role IS NULL
   THEN
      v_result_text := 'user role cannot be blank';
      RAISE excp_err;
   END IF;

   IF p_homepage_id IS NULL
   THEN
      v_result_text := 'homepage cannot be blank';
      RAISE excp_err;
   END IF;

   v_exists := 0;

   SELECT COUNT (*)
     INTO v_exists
     FROM uc_user_role
    WHERE user_role_name = p_user_role;

   IF v_exists > 0
   THEN
      v_result_text := 'User Role [' || p_user_role || '] already exists';
      RAISE excp_err;
   END IF;



   INSERT INTO uc_user_role
        VALUES (p_user_role, p_homepage_id);

   COMMIT;

   p_result_text := 'Success';
EXCEPTION
   WHEN excp_err
   THEN
      ROLLBACK;
      p_result_text := 'Error: ' || v_result_text;
   WHEN OTHERS
   THEN
      v_result_text := SUBSTR (SQLERRM, 1, 500);
      ROLLBACK;
      p_result_text := 'SQL Error: ' || v_result_text;
END;

/
--------------------------------------------------------
--  DDL for Procedure PUC_ADD_USER
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "TASDB"."PUC_ADD_USER" 
(
   p_user_id             VARCHAR2,
   p_full_name           VARCHAR2,
   p_email               VARCHAR2,
   p_phone               VARCHAR2,
   p_manager_id          VARCHAR2,
   p_manager_email       VARCHAR2,
   p_manager_phone       VARCHAR2,
   p_password            VARCHAR2,
   p_role_list           VARCHAR2,
   p_active              VARCHAR2,
   p_result_text     OUT VARCHAR2
)
AS
   v_result_text   VARCHAR2 (4000);
   v_user_id       UC_USER_DETAILS.USER_ID%TYPE;
   excp_err        EXCEPTION;
   v_active        VARCHAR2 (1);
   v_create_date   DATE;
   v_exists        VARCHAR2 (1);
   v_role_list     VARCHAR2 (4000);
   v_manager_id    UC_USER_DETAILS.manager_id%TYPE;
BEGIN
   v_user_id := UPPER (p_user_id);
   v_role_list := UPPER (p_role_list);
   v_manager_id := UPPER (p_manager_id);

   IF v_user_id IS NULL
   THEN
      v_result_text := 'user id cannot be blank';
      RAISE excp_err;
   END IF;

   IF p_password IS NULL
   THEN
      v_result_text := 'password cannot be blank';
      RAISE excp_err;
   END IF;

   IF v_role_list IS NULL
   THEN
      v_result_text := 'role list cannot be blank';
      RAISE excp_err;
   END IF;

   v_exists := NULL;

   SELECT MAX (active)
     INTO v_exists
     FROM uc_user_details
    WHERE user_id = v_user_id;

   IF v_exists IS NOT NULL
   THEN
      v_result_text :=
            'User ['
         || v_user_id
         || '] already exists with status active='
         || v_exists;
      RAISE excp_err;
   END IF;



   IF p_active IS NOT NULL
   THEN
      v_active := p_active;
   ELSE
      v_active := 'Y';
   END IF;


   v_create_date := SYSDATE;



   INSERT INTO uc_user_details
        VALUES (v_user_id, p_full_name, p_email, p_phone, p_manager_id,
                p_manager_email, p_manager_phone, p_password, v_active,
                v_create_date);



   puc_map_role_to_user (
         v_user_id
      || ','
      || REPLACE (RTRIM (LTRIM (v_role_list, ';'), ';'),
                  ';',
                  ';' || v_user_id || ','),
      v_result_text
   );

   IF UPPER (v_result_text) LIKE '%ERROR%'
   THEN
      RAISE excp_err;
   END IF;

   COMMIT;

   p_result_text :=
         'User created successfully with user id = '
      || v_user_id
      || ' with active status '
      || p_active;
EXCEPTION
   WHEN excp_err
   THEN
      ROLLBACK;
      p_result_text := 'Error: ' || v_result_text;
   WHEN OTHERS
   THEN
      v_result_text := SUBSTR (SQLERRM, 1, 500);
      ROLLBACK;
      p_result_text := 'SQL Error: ' || v_result_text;
END;

/
--------------------------------------------------------
--  DDL for Procedure PUC_AUTHENTICATE_USER
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "TASDB"."PUC_AUTHENTICATE_USER" 
(
   p_user_id           VARCHAR2,
   p_password          VARCHAR2,
   p_homepage_id   OUT VARCHAR2,
   p_role_list     OUT VARCHAR2,
   p_result_text   OUT VARCHAR2
)
AS
   v_result_text   VARCHAR2 (4000);
   v_password      VARCHAR2 (4000);
   excp_err        EXCEPTION;
   v_homepage_id   uc_user_role.homepage_id%TYPE;
   v_active        CHAR (1);
   v_create_date   DATE;
   v_exists        CHAR (1);
   v_role_list     VARCHAR2 (4000);
BEGIN
   IF p_user_id IS NULL
   THEN
      v_result_text := 'user id cannot be blank';
      RAISE excp_err;
   END IF;

   IF p_password IS NULL
   THEN
      v_result_text := 'password cannot be blank';
      RAISE excp_err;
   END IF;

   v_exists := NULL;

   SELECT MAX (active), MAX ("PASSWORD")
     INTO v_exists, v_password
     FROM uc_user_details
    WHERE user_id = upper(p_user_id);

   IF v_exists IS NULL
   THEN
      v_result_text := 'User [' || upper(p_user_id) || '] does not exist';
      RAISE excp_err;
   ELSIF v_exists <> 'Y'
   THEN
      v_result_text := 'User [' || upper(p_user_id) || '] is inactive';
      RAISE excp_err;
   ELSIF v_password <> p_password
   THEN
      v_result_text := 'Password mismatch';
      RAISE excp_err;
   ELSE
      SELECT MAX (ur.homepage_id)
        INTO v_homepage_id
        FROM uc_user_role_mapping urm,
             uc_user_role ur
       WHERE     urm.user_id = upper(p_user_id)
             AND ur.user_role_name = ur.user_role_name;

      v_role_list := NULL;


      SELECT LISTAGG (user_role_name, ', ') WITHIN GROUP (ORDER BY user_id)
                csv
        INTO v_role_list
        FROM uc_user_role_mapping
       WHERE user_id = UPPER (p_user_id);

      IF v_homepage_id IS NULL OR v_role_list IS NULL
      THEN
         p_homepage_id := v_homepage_id;
         p_role_list := v_role_list;
         v_result_text :=
            'User Authenticated, but not authorized to view any report';
         RAISE excp_err;
      ELSE
         p_homepage_id := v_homepage_id;
         p_role_list := v_role_list;
         p_result_text := 'SUCCESS';
      END IF;
   END IF;
EXCEPTION
   WHEN excp_err
   THEN
      ROLLBACK;
      p_result_text := 'Error: ' || v_result_text;
   WHEN OTHERS
   THEN
      v_result_text := SUBSTR (SQLERRM, 1, 500);
      ROLLBACK;
      p_result_text := 'SQL Error: ' || v_result_text;
END;

/
--------------------------------------------------------
--  DDL for Procedure PUC_EDIT_USER
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "TASDB"."PUC_EDIT_USER" 
(
   p_user_id             VARCHAR2,
   p_full_name           VARCHAR2,
   p_email               VARCHAR2,
   p_phone               VARCHAR2,
   p_manager_id          VARCHAR2,
   p_manager_email       VARCHAR2,
   p_manager_phone       VARCHAR2,
   p_password            VARCHAR2,
   p_role_list           VARCHAR2,
   p_active              CHAR,
   p_result_text     OUT VARCHAR2
)
AS
   v_result_text   VARCHAR2 (4000);
   excp_err        EXCEPTION;
   v_active        CHAR (1);
   v_create_date   DATE;
   v_exists        CHAR (1);
BEGIN
   IF p_user_id IS NULL
   THEN
      v_result_text := 'user id cannot be blank';
      RAISE excp_err;
   END IF;

   IF p_password IS NULL
   THEN
      v_result_text := 'password cannot be blank';
      RAISE excp_err;
   END IF;

   IF p_role_list IS NULL
   THEN
      v_result_text := 'role list cannot be blank';
      RAISE excp_err;
   END IF;

   v_exists := NULL;

   SELECT MAX (active)
     INTO v_exists
     FROM uc_user_details
    WHERE user_id = p_user_id;

   IF v_exists IS NULL
   THEN
      v_result_text := 'User [' || p_user_id || '] does not exist';
      RAISE excp_err;
   END IF;

   IF p_active IS NOT NULL
   THEN
      v_active := p_active;
   ELSE
      v_active := 'Y';
   END IF;

   v_create_date := SYSDATE;


   INSERT INTO uc_user_details
        VALUES (p_user_id, p_full_name, p_email, p_phone, p_manager_id,
                p_manager_email, p_manager_phone, p_password, v_active,
                v_create_date);

   puc_map_role_to_user (
         p_user_id
      || ','
      || REPLACE (RTRIM (LTRIM (p_role_list, ';'), ';'),
                  ';',
                  ';' || p_user_id || ','),
      v_result_text
   );

   IF UPPER (v_result_text) LIKE '%ERROR%'
   THEN
      RAISE excp_err;
   END IF;

   COMMIT;

   p_result_text := 'Success';
EXCEPTION
   WHEN excp_err
   THEN
      ROLLBACK;
      p_result_text := 'Error: ' || v_result_text;
   WHEN OTHERS
   THEN
      v_result_text := SUBSTR (SQLERRM, 1, 500);
      ROLLBACK;
      p_result_text := 'SQL Error: ' || v_result_text;
END;

/
--------------------------------------------------------
--  DDL for Procedure PUC_MAP_ROLE_TO_USER
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "TASDB"."PUC_MAP_ROLE_TO_USER" ( p_user_role_mapping VARCHAR2, p_result_text OUT VARCHAR2)
AS
   v_result_text         VARCHAR2 (4000);
   excp_err              EXCEPTION;
   v_count_of_mappings   NUMBER (9);
   v_high_count          NUMBER (9);
   v_exists              NUMBER (9);
   v_user_role_mapping   VARCHAR2 (4000);
   v_one_pair            VARCHAR2 (2000);
   v_role                VARCHAR2 (500);
   v_user_id             VARCHAR2 (500);
BEGIN
   IF p_user_role_mapping IS NULL
   THEN
      v_result_text := 'user role mapping cannot be blank';
      RAISE excp_err;
   END IF;

   v_user_role_mapping :=
      RTRIM (LTRIM (RTRIM (LTRIM (p_user_role_mapping, ';'), ';'), ','), ',')||';';

   v_count_of_mappings :=
        LENGTH (v_user_role_mapping)
      - LENGTH (REPLACE (v_user_role_mapping, ';'));

   FOR i IN 1 .. v_count_of_mappings
   LOOP
      v_high_count := i;

      IF v_high_count > v_count_of_mappings
      THEN
         v_high_count := 0;
      END IF;

      v_one_pair := delimit (v_user_role_mapping, ';', i - 1, v_high_count);

      IF v_one_pair NOT LIKE '%,%' OR v_one_pair LIKE '%,%,%'
      THEN
         v_result_text := 'invalid format for user - role mapping';
         RAISE excp_err;
      END IF;

      v_role := delimit (v_one_pair, ',', 1, 0);
      v_user_id := delimit (v_one_pair, ',', 0, 1);
      v_exists := 0;

      SELECT COUNT (*)
        INTO v_exists
        FROM uc_user_role
       WHERE user_role_name = v_role;

      IF v_exists <> 1
      THEN
         v_result_text := 'role [' || v_role || '] does not exist';
         RAISE excp_err;
      END IF;

      v_exists := 0;

      SELECT COUNT (*)
        INTO v_exists
        FROM uc_user_details
       WHERE user_id = v_user_id;

      IF v_exists <> 1
      THEN
         v_result_text := 'user id [' || v_user_id || '] does not exist';
         RAISE excp_err;
      END IF;

      v_exists := 0;

      SELECT COUNT (*)
        INTO v_exists
        FROM uc_user_role_mapping
       WHERE user_id = v_user_id AND user_role_name = v_role;

      IF v_exists > 0
      THEN
         v_result_text :=
               'mapping of user id ['
            || v_user_id
            || '] and user role ['
            || v_role
            || '] already exists';
         RAISE excp_err;
      END IF;

      INSERT INTO uc_user_role_mapping
           VALUES (v_role, v_user_id);
   END LOOP;


   --   COMMIT;

   p_result_text := 'Success';
EXCEPTION
   WHEN excp_err
   THEN
      --      ROLLBACK;
      p_result_text := 'Error: ' || v_result_text;
   WHEN OTHERS
   THEN
      v_result_text := SUBSTR (SQLERRM, 1, 500);
      --      ROLLBACK;
      p_result_text := 'Sql error: ' || v_result_text;
END;

/
--------------------------------------------------------
--  DDL for Procedure RC_UPDATE_REPORT_RUN_LOG
--------------------------------------------------------
set define off;

  CREATE OR REPLACE EDITIONABLE PROCEDURE "TASDB"."RC_UPDATE_REPORT_RUN_LOG" 
(
   p_report_id             rc_report.report_id%TYPE,
   p_running_status        rc_report_schedule.running_status%TYPE,
   p_report_result_text    rc_report_run_log.result_text%TYPE,
   p_result_text        out   VARCHAR2
)
AS
   v_result_text   VARCHAR2 (4000);
   excp_err        EXCEPTION;
BEGIN
   IF p_running_status NOT IN ('RUNNING', 'PENDING')
   THEN
      v_result_text :=
         'Report running status can only be [RUNNING] or [PENDING]';
      RAISE excp_err;
   END IF;

   UPDATE rc_report_schedule
      SET running_status = p_running_status
    WHERE report_id = p_report_id;

   IF p_running_status = 'RUNNING'
   THEN
      INSERT INTO rc_report_run_log
           VALUES (p_report_id, SYSDATE, NULL, NULL);
   ELSE
      UPDATE rc_report_run_log
         SET end_time = SYSDATE, result_text = p_report_result_text
       WHERE     report_id = p_report_id
             AND TO_CHAR (start_time, 'dd-mon-yyyy') =
                    TO_CHAR (SYSDATE, 'dd-mon-yyyy');
   END IF;



   p_result_text :=
         'Success in rc_update_report_running_status (p_report_id='
      || p_report_id
      || ',p_running_status='
      || p_running_status
      || ',time:'
      || SYSDATE
      || ') Message:'
      || v_result_text;

   COMMIT;
EXCEPTION
   WHEN excp_err
   THEN
      ROLLBACK;
      p_result_text :=
            'Error in rc_update_report_running_status (p_report_id='
         || p_report_id
         || ',p_running_status='
         || p_running_status
         || ',time:'
         || SYSDATE
         || ') Message:'
         || v_result_text;
   WHEN OTHERS
   THEN
      ROLLBACK;
      v_result_text := SUBSTR (SQLERRM, 1, 500);
      p_result_text :=
            'SQL Error in rc_update_report_running_status (p_report_id='
         || p_report_id
         || ',p_running_status='
         || p_running_status
         || ',time:'
         || SYSDATE
         || ') Message:'
         || v_result_text;
END;

/
--------------------------------------------------------
--  DDL for Function DELIMIT
--------------------------------------------------------

  CREATE OR REPLACE EDITIONABLE FUNCTION "TASDB"."DELIMIT" (
   p_string      IN   VARCHAR,
   p_delimit     IN   VARCHAR,
   p_start_loc   IN   NUMBER,
   p_end_loc     IN   NUMBER
)
   RETURN VARCHAR2
AS
   p_substr    VARCHAR2 (1000);
   high_num    NUMBER (2);
   start_loc   NUMBER (2);
   end_loc     NUMBER (2);
BEGIN
   high_num := (LENGTH (p_string) - LENGTH (REPLACE (p_string, p_delimit, '')))
               / LENGTH (p_delimit);

   IF high_num < ABS (p_start_loc) OR high_num < ABS (p_end_loc)
   THEN
      RETURN 'ERR-NotEnoughDelimiters';
   END IF;

   IF p_start_loc < 0
   THEN
      start_loc := high_num + p_start_loc + 1;
   ELSE
      start_loc := p_start_loc;
   END IF;

   IF p_end_loc < 0
   THEN
      end_loc := high_num + p_end_loc + 1;
   ELSE
      end_loc := p_end_loc;
   END IF;

   IF start_loc > end_loc AND start_loc > 0 AND end_loc > 0
   THEN
      RETURN 'ERR-EndLocLessThanStartLoc';
   END IF;

   IF start_loc = end_loc
   THEN
      RETURN '';
   END IF;

   IF start_loc > 0 AND end_loc > 0
   THEN
      p_substr :=
         SUBSTR (p_string,
                 INSTR (p_string, p_delimit, 1, start_loc) + LENGTH (p_delimit),
                   INSTR (p_string, p_delimit, 1, end_loc)
                 - INSTR (p_string, p_delimit, 1, start_loc)
                 - LENGTH (p_delimit)
                );
   ELSIF start_loc = 0 AND end_loc > 0
   THEN
      p_substr := SUBSTR (p_string, 1, INSTR (p_string, p_delimit, 1, end_loc) - 1);
   ELSIF start_loc > 0 AND end_loc = 0
   THEN
      p_substr := SUBSTR (p_string, INSTR (p_string, p_delimit, 1, start_loc) + LENGTH (p_delimit));
   END IF;

   RETURN p_substr;
END;

/
--------------------------------------------------------
--  Constraints for Table UC_USER_DETAILS
--------------------------------------------------------

  ALTER TABLE "TASDB"."UC_USER_DETAILS" ADD CONSTRAINT "PK_UC_USER_DETAILS" PRIMARY KEY ("USER_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Constraints for Table RC_REPORT_GROUP
--------------------------------------------------------

  ALTER TABLE "TASDB"."RC_REPORT_GROUP" ADD CONSTRAINT "PK_RC_REPORT_GROUP" PRIMARY KEY ("REPORT_GROUP_NAME")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Constraints for Table RC_REPORT
--------------------------------------------------------

  ALTER TABLE "TASDB"."RC_REPORT" ADD CONSTRAINT "PK_RC_REPORT" PRIMARY KEY ("REPORT_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Constraints for Table UC_USER_ROLE
--------------------------------------------------------

  ALTER TABLE "TASDB"."UC_USER_ROLE" ADD CONSTRAINT "PK_UC_USER_ROLE" PRIMARY KEY ("USER_ROLE_NAME")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1
  BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS"  ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table RC_REPORT
--------------------------------------------------------

  ALTER TABLE "TASDB"."RC_REPORT" ADD CONSTRAINT "FK_RC_REPORT_1" FOREIGN KEY ("REPORT_GROUP_NAME")
	  REFERENCES "TASDB"."RC_REPORT_GROUP" ("REPORT_GROUP_NAME") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table RC_REPORT_SCHEDULE
--------------------------------------------------------

  ALTER TABLE "TASDB"."RC_REPORT_SCHEDULE" ADD CONSTRAINT "FK_RC_REPORT_SCHEDULE_1" FOREIGN KEY ("REPORT_ID")
	  REFERENCES "TASDB"."RC_REPORT" ("REPORT_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table UC_REPORT_ACCESS
--------------------------------------------------------

  ALTER TABLE "TASDB"."UC_REPORT_ACCESS" ADD CONSTRAINT "FK_UC_REPORT_ACCESS_1" FOREIGN KEY ("USER_ROLE_NAME")
	  REFERENCES "TASDB"."UC_USER_ROLE" ("USER_ROLE_NAME") ENABLE;
  ALTER TABLE "TASDB"."UC_REPORT_ACCESS" ADD CONSTRAINT "FK_UC_REPORT_ACCESS_2" FOREIGN KEY ("REPORT_ID")
	  REFERENCES "TASDB"."RC_REPORT" ("REPORT_ID") ENABLE;
--------------------------------------------------------
--  Ref Constraints for Table UC_USER_ROLE_MAPPING
--------------------------------------------------------

  ALTER TABLE "TASDB"."UC_USER_ROLE_MAPPING" ADD CONSTRAINT "FK1_UC_USER_ROLE_MAPPING" FOREIGN KEY ("USER_ROLE_NAME")
	  REFERENCES "TASDB"."UC_USER_ROLE" ("USER_ROLE_NAME") ENABLE;
  ALTER TABLE "TASDB"."UC_USER_ROLE_MAPPING" ADD CONSTRAINT "FK2_UC_USER_ROLE_MAPPING" FOREIGN KEY ("USER_ID")
	  REFERENCES "TASDB"."UC_USER_DETAILS" ("USER_ID") ENABLE;
