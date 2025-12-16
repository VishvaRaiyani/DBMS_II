--Part – A 
--1.	INSERT Procedures: Create stored procedures to insert records into STUDENT tables (SP_INSERT_STUDENT)
--StuID	Name	Email	Phone	Department	DOB	EnrollmentYear
--10	Harsh Parmar	harsh@univ.edu	9876543218	CSE	2005-09-18	2023
--20	Om Patel	om@univ.edu	9876543211	IT	2002-08-22	2022

CREATE OR ALTER PROC PR_INSERT_STUDENT
@STUID INT,
@SNAME VARCHAR(100),
@SEMAIL VARCHAR(100),
@SPHONE VARCHAR(15),
@SDEPT VARCHAR(50),
@SDOB DATE,
@SENROLL INT
AS
BEGIN 
	INSERT INTO STUDENT(StudentID , StuName ,StuEmail , StuPhone , StuDepartment , StuDateOFBirth , StuEnrollmentYear) VALUES (@STUID , @SNAME , @SEMAIL , @SPHONE,@SDEPT,	@SDOB,@SENROLL)
END

--CREATE OR ALTER PROC PR_INSERT_STUDENT_2
--@STUID INT,
--@SNAME VARCHAR(100),
--@SEMAIL VARCHAR(100),
--@SPHONE VARCHAR(15),
--@SDEPT VARCHAR(50),
--@SDOB DATE,
--@SENROLL INT
--AS
--BEGIN 
--	INSERT INTO STUDENT VALUES (@STUID , @SNAME , @SEMAIL , @SPHONE,@SDEPT,	@SDOB,@SENROLL)
--END

EXEC SP_INSERT_STUDENT 10, 'Harsh Parmar' , 'harsh@univ.edu' , '9876543218' , 'CSE' , '2005-09-18' , 2023
EXEC SP_INSERT_STUDENT 20, 'Om Patel' , 'om@univ.edu' , '9876543211' ,'IT' , '2002-08-22' , 2022

SELECT * FROM STUDENT

--2.	INSERT Procedures: Create stored procedures to insert records into COURSE tables 
--(SP_INSERT_COURSE)
--CourseID	CourseName	Credits	Dept	Semester
--CS330	Computer Networks	4	CSE	5
--EC120	Electronic Circuits	3	ECE	2

CREATE OR ALTER PROC PR_INSERT_COURSE
@CID VARCHAR(10),
@CNAME VARCHAR(100),
@CCREDITS INT,
@CDEPT VARCHAR(100),
@CSEM INT
AS
BEGIN 
	INSERT INTO COURSE VALUES (@CID , @CNAME , @CCREDITS , @CDEPT , @CSEM)
END

EXEC SP_INSERT_COURSE 'CS330' , 'Computer Networks' , 4 , 'CSE' , 5
EXEC SP_INSERT_COURSE 'EC120' , 'Electronic Circuits' , 3 , 'ECE' , 2

SELECT * FROM COURSE

--3.	UPDATE Procedures: Create stored procedure SP_UPDATE_STUDENT to update Email and Phone in STUDENT table. (Update using studentID)
CREATE OR ALTER PROC PR_UPADTE_STUDENT
@SEMAIL VARCHAR(100),
@SPHONE VARCHAR(15),
@SID INT
AS
BEGIN
	UPDATE STUDENT
	SET StuEmail = @SEMAIL , StuPhone = @SPHONE
	WHERE StudentID = @SID
END

EXEC SP_UPADTE_STUDENT 'vishva@univ.edu' , '9512254546' , 5

SELECT * FROM STUDENT

--4.	DELETE Procedures: Create stored procedure SP_DELETE_STUDENT to delete records from STUDENT where Student Name is Om Patel.
CREATE OR ALTER PROC PR_DELETE_STUDENT
AS
BEGIN
	DELETE FROM STUDENT
	WHERE StuName = 'OM PATEL'
END

EXEC SP_DELETE_STUDENT

SELECT * FROM STUDENT

--5.	SELECT BY PRIMARY KEY: Create stored procedures to select records by primary key (SP_SELECT_STUDENT_BY_ID) from Student table.
CREATE OR ALTER PROC PR_SELECT_STUDENT_BY_ID
@SID INT
AS
BEGIN
	SELECT * FROM STUDENT
	WHERE StudentID = @SID
END

EXEC SP_SELECT_STUDENT_BY_ID 2

--6.	Create a stored procedure that shows details of the first 5 students ordered by EnrollmentYear.
CREATE OR ALTER PROC PR_DETAILS_FIRST_5_STUDENT
AS
BEGIN
	SELECT TOP 5 * 
	FROM STUDENT
	ORDER BY StuEnrollmentYear
END

EXEC SP_DETAILS_FIRST_5_STUDENT

--Part – B  
--7.	Create a stored procedure which displays faculty designation-wise count.
CREATE OR ALTER PROC PR_DESIGNATION_WISE_COUNT_FACULTY
AS
BEGIN
	SELECT FacultyDesignation , COUNT(FacultyID) AS DESIGNATION_WISE_COUNT_FACULTY 
	FROM FACULTY
	GROUP BY FacultyDesignation
END

EXEC SP_DESIGNATION_WISE_COUNT_FACULTY

--8.	Create a stored procedure that takes department name as input and returns all students in that department.
CREATE OR ALTER PROC PR_RETURN_STUDENT_DEPARTMENT
@SDEPT VARCHAR(50)
AS
BEGIN
	SELECT * 
	FROM STUDENT
	WHERE StuDepartment = @SDEPT
END

EXEC SP_RETURN_STUDENT_DEPARTMENT 'CSE'

--Part – C 

--9.	Create a stored procedure which displays department-wise maximum, minimum, and average credits of courses.
CREATE OR ALTER PROC PR_DEPARTMENT_WISE_CREDITS
AS
BEGIN
	SELECT CourseDepartment , MAX(CourseCredits) AS MAX_COURSE_CREDITS,
	 	   MIN(CourseCredits) AS MIN_COURSE_CREDITS,
		   AVG(CourseCredits) AS AVG_COURSE_CREDITS
	FROM COURSE
	GROUP BY CourseDepartment
END

EXEC SP_DEPARTMENT_WISE_CREDITS

--10.	Create a stored procedure that accepts StudentID as parameter and returns all courses the student is enrolled in with their grades.
CREATE OR ALTER PROC PR_RETURN_COURSE_STUDENT
@SID INT
AS
BEGIN
	SELECT C.CourseName , E.Grade
	FROM COURSE C
	JOIN ENROLLMENT E
	ON E.CourseID = C.CourseID
	WHERE E.StudentID = @SID
END

EXEC SP_RETURN_COURSE_STUDENT 1

