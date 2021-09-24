---------STORE PROCEDURES------------

--WORKING WITH STORED PROCEDURES:

CREATE PROCEDURE SP_Get_Emp_Details
AS 
BEGIN
SELECT EMPNO,ENAME,SAL FROM EMP
END

EXECUTE SP_Get_Emp_Details;

--ALTERING AN EXISTING PROCEDURES

ALTER PROCEDURE SP_Get_Emp_Details
AS
BEGIN
SELECT EMPNO,ENAME,SAL,SAL+150 AS COMMISION FROM EMP
END

--SP WITH ENCRYPTION

CREATE PROCEDURE SP_Get_Emp_Details_param
@EMPNO INT,
@SAL INT
WITH ENCRYPTION
AS
BEGIN
SELECT EMPNO,ENAME,SAL FROM EMP WHERE EMPNO>@EMPNO AND SAL>@SAL
END

EXECUTE SP_Get_Emp_Details_param 7521,2999

--COMMAND TO VIEW THE TEXT OF THE STORED_PROC: 
SP_HELPTEXT SP_Get_Emp_Details_param

ALTER PROCEDURE SP_Get_Emp_Details_param 
@EMPNO INT,
@SAL INT
WITH ENCRYPTION
AS
BEGIN
SELECT EMPNO,ENAME,SAL FROM EMP WHERE EMPNO>@EMPNO AND SAL>@SAL
END
	

CREATE TABLE employee
(
    id         INTEGER NOT NULL PRIMARY KEY,
    first_name VARCHAR(10),
    last_name  VARCHAR(10),
    salary     DECIMAL(10, 2),
    city       VARCHAR(20),
);


INSERT INTO employee VALUES  (2,'Monu','Rathor',4789, 'Agra');
INSERT INTO employee VALUES  (4,'Rahul','Saxena',5567,'London');
INSERT INTO employee VALUES  (5,'prabhat','kumar',4467,'Bombay');
INSERT INTO employee VALUES  (6,'ramu','kksingh',3456,'jk');

SELECT * FROM   employee;

ALTER PROCEDURE EMP_INS_UPDT_DEL 	     (@id            INTEGER,
                                          @first_name    VARCHAR(10),
                                          @last_name     VARCHAR(10),
                                          @salary        DECIMAL(10, 2),
                                          @city          VARCHAR(20),
                                          @StatementType NVARCHAR(20) = '')
AS
  BEGIN
      IF @StatementType = 'Insert'
        BEGIN
            INSERT INTO employee
                        (id,
                         first_name,
                         last_name,
                         salary,
                         city)
            VALUES     ( @id,
                         @first_name,
                         @last_name,
                         @salary,
                         @city)
        END

      IF @StatementType = 'Select'
        BEGIN
            SELECT *
            FROM   employee where id = @id;
        END

      IF @StatementType = 'Update'
        BEGIN
            UPDATE employee
            SET    first_name = @first_name,
                   last_name = @last_name,
                   salary = @salary,
                   city = @city
            WHERE  id = @id
        END
      ELSE IF @StatementType = 'Delete'
        BEGIN
            DELETE FROM employee WHERE  id = @id
        END
  END

  ---------------INDEXES----------------------

  --CREATING AN UNIQUE INDEX
  SELECT * INTO DEPT_UINDX FROM DEPT;
  SELECT * FROM DEPT_UINDX;
  CREATE UNIQUE INDEX UNQ_INDX ON DEPT_UINDX(LOC);
  INSERT INTO DEPT_UINDX VALUES(50,'ANALYST','ABCDE')
  

  --CREATING AN NON-UNIQUE INDEX

  SELECT*INTO DEPT_NUINDX FROM DEPT;
  SELECT * FROM DEPT_NUINDX ;
  CREATE INDEX NUIQ_INDX ON DEPT_NUINDX(LOC);
  INSERT INTO DEPT_NUINDX VALUES(60,'LEAD','BOSTON')

  SELECT * FROM DEPT_NUINDX WHERE LOC='BOSTON'

  --CREATING AN UNIQUE INDEX--THE COST IS 50% USING WHERE CLAUSE

  CREATE UNIQUE INDEX UNQ_INDX ON DEPT_UINDX(LOC);
  SELECT * FROM DEPT_UINDX WHERE LOC='CHICAGO';


  -------WORKING WITH TRIGGERS----------

  --CREATE A TABLE FOR PERFORMING DML TRANSACTION:
  SELECT * FROM EMP;
  SELECT EMPNO,ENAME,SAL,DEPTNO INTO TRIG_EMP FROM EMP WHERE DEPTNO IN (20);

--CREATE AN AUDIT TABLE TO CAPTURE THE CHANGES OCCURED AT THE BASE TABLE: 
CREATE TABLE TRIG_DATA(EMPNO INT,ENAME VARCHAR(20),SAL INT,
AUDIT_ACTION VARCHAR(100),AUDIT_TIMESTAMP DATETIME)

SELECT * FROM TRIG_EMP;
SELECT * FROM TRIG_DATA;
--CREATE A TRIGGER FOR FIRING WHEN ANY DML ACTION HAPPENS: 
--TRIGGER FOR INSERT OPERATION: 
CREATE TRIGGER TRIG_INS
ON TRIG_EMP
FOR INSERT
AS
BEGIN
	DECLARE @EMPNO INT;
	DECLARE @ENAME VARCHAR(10);
	DECLARE @SAL INT;
	DECLARE @AUDIT_ACTION VARCHAR(100);

	SELECT @EMPNO=I.EMPNO FROM INSERTED I;
	SELECT @ENAME=I.ENAME FROM INSERTED I;
	SELECT @SAL =I.SAL FROM INSERTED I;
	SELECT @AUDIT_ACTION='INSERTED RECORD-AFTER INSERT TRIGGER';

	INSERT INTO TRIG_DATA (EMPNO,ENAME,SAL,AUDIT_ACTION,AUDIT_TIMESTAMP)
	VALUES(@EMPNO,@ENAME,@SAL,@AUDIT_ACTION,GETDATE());
	PRINT 'AFTER INSERTION- TRIGGER FIRED';

END

INSERT INTO TRIG_EMP VALUES(7999,'EEASDVF',9999,30);

SELECT * FROM TRIG_EMP;
SELECT * FROM TRIG_DATA;