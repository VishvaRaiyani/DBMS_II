--Part – A 

--1.	Retrieve all unique departments from the STUDENT table.
SELECT DISTINCT StuDepartment 
FROM STUDENT

--2.	Insert a new student record into the STUDENT table.
--(9, 'Neha Singh', 'neha.singh@univ.edu', '9876543218', 'IT', '2003-09-20', 2021)
INSERT INTO STUDENT VALUES (9, 'Neha Singh', 'neha.singh@univ.edu', '9876543218', 'IT', '2003-09-20', 2021)

SELECT * FROM STUDENT

--3.	Change the Email of student 'Raj Patel' to 'raj.p@univ.edu'. (STUDENT table)
UPDATE STUDENT
SET StuEmail = 'raj.p@univ.edu'
WHERE StuName = 'Raj Patel'

--4.	Add a new column 'CGPA' with datatype DECIMAL(3,2) to the STUDENT table.
ALTER TABLE STUDENT
ADD CGPA DECIMAL(3 , 2)

SELECT * FROM STUDENT

--5.	Retrieve all courses whose CourseName starts with 'Data'. (COURSE table)
SELECT COURSENAME
FROM COURSE
WHERE CourseName LIKE 'DATA%'

--6.	Retrieve all students whose Name contains 'Shah'. (STUDENT table)
SELECT *
FROM STUDENT
WHERE StuName LIKE '%SHAH%'

--7.	Display all Faculty Names in UPPERCASE. (FACULTY table)
SELECT UPPER(FACULTYNAME) AS UPPERCASE_NAME
FROM FACULTY

--8.	Find all faculty who joined after 2015. (FACULTY table)
SELECT *
FROM FACULTY
WHERE FacultyJoiningDate > '2015'

--9.	Find the SQUARE ROOT of Credits for the course 'Database Management Systems'. (COURSE table)
SELECT SQRT(COURSECREDITS) AS COURSE_CREDITS_SQRT
FROM COURSE
WHERE CourseName = 'Database Management Systems'

--10.	Find the Current Date using SQL Server in-built function.
SELECT GETDATE() AS CURRENTDATE

--11.	Find the top 3 students who enrolled earliest (by EnrollmentYear). (STUDENT table)
SELECT TOP 3 *
FROM STUDENT
ORDER BY StuEnrollmentYear

select * from student ORDER BY StuEnrollmentYear

--12.	Find all enrollments that were made in the year 2022. (ENROLLMENT table)
SELECT *
FROM ENROLLMENT
WHERE EnrollmentDate BETWEEN '2022-01-01' AND '2022-12-31'

--13.	Find the number of courses offered by each department. (COURSE table)
SELECT CourseDepartment ,COUNT(COURSEID) AS COURSE_EACH_DEPARTMENT
FROM COURSE
GROUP BY CourseDepartment

--14.	Retrieve the CourseID which has more than 2 enrollments. (ENROLLMENT table)
SELECT CourseID AS COUNT_ENROLLMENT  
FROM ENROLLMENT
GROUP BY CourseID
HAVING COUNT(EnrollmentID) > 2 

--15.	Retrieve all the student name with their enrollment status. (STUDENT & ENROLLMENT table)
SELECT STUNAME , ENROLLMENTSTATUS
FROM STUDENT S
JOIN ENROLLMENT E
ON S.STUDENTID = E.STUDENTID

--16.	Select all student names with their enrolled course names. (STUDENT, COURSE, ENROLLMENT table)
SELECT STUNAME , COURSENAME
FROM STUDENT S
JOIN ENROLLMENT E
ON S.StudentID = E.StudentID
JOIN COURSE C
ON E.CourseID = C.CourseID

--17.	Create a view called 'ActiveEnrollments' showing only active enrollments with student name and  course name. (STUDENT, COURSE, ENROLLMENT,  table)
CREATE VIEW ActiveEnrollments
AS
SELECT STUNAME , COURSENAME , ENROLLMENTSTATUS
FROM STUDENT S
JOIN ENROLLMENT E
ON S.StudentID = E.StudentID
JOIN COURSE C
ON C.CourseID = E.CourseID
WHERE EnrollmentStatus = 'ACTIVE'

DROP VIEW ActiveEnrollments

SELECT * FROM ActiveEnrollments

--18.	Retrieve the student’s name who is not enrol in any course using subquery. (STUDENT, ENROLLMENT TABLE)
SELECT STUNAME
FROM STUDENT
WHERE StudentID NOT IN (SELECT StudentID FROM ENROLLMENT)

--19.	Display course name having second highest credit. (COURSE table)
SELECT TOP 1 COURSENAME , COURSECREDITS
FROM COURSE
WHERE CourseCredits < (SELECT MAX(COURSECREDITS) FROM COURSE)
ORDER BY CourseCredits DESC


--Part – B 

--20.	Retrieve all courses along with the total number of students enrolled. (COURSE, ENROLLMENT table)
SELECT CourseName , COUNT(ENROLLMENTID) AS TOTAL_NUMBER_OF_STUDENTS
FROM COURSE C
JOIN ENROLLMENT E
ON C.CourseID = E.CourseID
GROUP BY CourseName

--21.	Retrieve the total number of enrollments for each status, showing only statuses that have more than 2 enrollments. (ENROLLMENT table)
SELECT EnrollmentStatus , COUNT(EnrollmentID) AS TOTAL_NUM
FROM ENROLLMENT
GROUP BY EnrollmentStatus
HAVING COUNT(EnrollmentID) > 2

--22.	Retrieve all courses taught by 'Dr. Sheth' and order them by Credits. (FACULTY, COURSE, COURSE_ASSIGNMENT table)
SELECT COURSENAME , FACULTYNAME
FROM COURSE C1
JOIN COURSE_ASSIGNMENT C2
ON C1.CourseID = C2.CourseID
JOIN FACULTY F
ON C2.FacultyID = F.FacultyID
WHERE FacultyName = 'DR. SHETH'
ORDER BY CourseCredits

--Part – C 
--23.	List all students who are enrolled in more than 3 courses. (STUDENT, ENROLLMENT table)
SELECT StuName ,  COUNT(CourseID) AS TOTAL_ENROLLED
FROM STUDENT S
JOIN ENROLLMENT E
ON S.StudentID = E.StudentID
GROUP BY StuName
HAVING COUNT(CourseID) > 3

--24.	Find students who have enrolled in both 'CS101' and 'CS201' Using Sub Query. (STUDENT, ENROLLMENT table)
SELECT STUNAME
FROM STUDENT
WHERE StudentID IN (SELECT E1.STUDENTID
					FROM ENROLLMENT E1
					WHERE E1.CourseID = 'CS101')
				AND StudentID IN(SELECT E2.STUDENTID
								FROM ENROLLMENT E2
								WHERE E2.CourseID = 'CS201')
--25.	Retrieve department-wise count of faculty members along with their average years of experience 
--(calculate experience from JoiningDate). (Faculty table)
SELECT FacultyDepartment , COUNT(FacultyID) AS NO_OF_FACULTY, AVG(YEAR(GETDATE()) - YEAR(FacultyJoiningDate)) AS EXPERIENCE_FACULTY
FROM FACULTY
GROUP BY FacultyDepartment


