--Part – A 

--1.	Create a stored procedure that accepts a date and returns all faculty members who joined on that date.
CREATE OR ALTER PROC PR_DATE_FACULTY
@FDATE DATE
AS
BEGIN 
	SELECT *
	FROM FACULTY
	WHERE FacultyJoiningDate = @FDATE
END

EXEC PR_DATE_FACULTY '2012-08-20'

--2.	Create a stored procedure for ENROLLMENT table where user enters either StudentID and returns EnrollmentID, EnrollmentDate, Grade, and Status.
CREATE OR ALTER PROC PR_ENROLLMENT
@SID INT
AS
BEGIN 
	SELECT EnrollmentID , EnrollmentDate , Grade , EnrollmentStatus
	FROM ENROLLMENT
	WHERE StudentID = @SID
END

EXEC PR_ENROLLMENT 2

--3.	Create a stored procedure that accepts two integers (min and max credits) and returns all courses whose credits fall between these values.
CREATE OR ALTER PROC PR_MIN_MAX
@MIN INT,
@MAX INT
AS
BEGIN
	SELECT *
	FROM COURSE
	WHERE CourseCredits BETWEEN @MIN AND @MAX
END

EXEC PR_MIN_MAX 1 , 3

--4.	Create a stored procedure that accepts Course Name and returns the list of students enrolled in that course.
CREATE OR ALTER PROC PR_RETURN_STUDENT
@CNAME VARCHAR(100)
AS
BEGIN 
	SELECT STUNAME
	FROM STUDENT S
	JOIN ENROLLMENT E
	ON S.StudentID = E.StudentID
	JOIN COURSE C
	ON E.CourseID = C.CourseID
	WHERE CourseName = @CNAME
END

EXEC PR_RETURN_STUDENT 'DATA STRUCTURES'

--5.	Create a stored procedure that accepts Faculty Name and returns all course assignments.
CREATE OR ALTER PROC PR_FACULTY_NAME
@FNAME VARCHAR(100)
AS
BEGIN
	SELECT *
	FROM FACULTY F
	JOIN COURSE_ASSIGNMENT C
	ON F.FacultyID = C.FacultyID
	WHERE FacultyName = @FNAME
END

EXEC PR_FACULTY_NAME 'Dr. Sheth'

--6.	Create a stored procedure that accepts Semester number and Year, and returns all course assignments with faculty and classroom details.
CREATE OR ALTER PROC PR_SEM_YEAR
@SEM INT,
@YEAR INT
AS
BEGIN 
	SELECT FacultyName , ClassRoom
	FROM FACULTY F
	JOIN COURSE_ASSIGNMENT C
	ON F.FacultyID = C.FacultyID
	WHERE Semester = @SEM AND YEAR = @YEAR
END

EXEC PR_SEM_YEAR 1 , 2024

--Part – B 
--7.	Create a stored procedure that accepts the first letter of Status ('A', 'C', 'D') and returns enrollment details.
CREATE OR ALTER PROC PR_FIRST_LETTER
@WORD VARCHAR(1)
AS
BEGIN
	SELECT *
	FROM ENROLLMENT
	WHERE EnrollmentStatus LIKE @WORD+'%'
END

EXEC PR_FIRST_LETTER 'D'

--8.	Create a stored procedure that accepts either Student Name OR Department Name and returns student data accordingly.
CREATE OR ALTER PROC PR_STUNAME_DEPTNAME
@SNAME VARCHAR(100) = NULL,
@DNAME VARCHAR(50) = NULL
AS
BEGIN 
	SELECT *
	FROM STUDENT
	WHERE StuName = @SNAME OR StuDepartment = @DNAME
END

EXEC PR_STUNAME_DEPTNAME 'Raj Patel'

--9.	Create a stored procedure that accepts CourseID and returns all students enrolled grouped by enrollment status with counts.
CREATE OR ALTER PROC PR_GROUP_BY
@CID INT
AS
BEGIN
	SELECT COUNT(S)
	FROM ENROLLMENT
--Part – C 
--10.	Create a stored procedure that accepts a year as input and returns all courses assigned to faculty in that year with classroom details.
--11.	Create a stored procedure that accepts From Date and To Date and returns all enrollments within that range with student and course details.
--12.	Create a stored procedure that accepts FacultyID and calculates their total teaching load (sum of credits of all courses assigned).
