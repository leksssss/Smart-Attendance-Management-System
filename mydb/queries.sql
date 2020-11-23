
        /* Query 1 : To view number of students enrolled in each course */

select c.course_id,c.course_name,count(e.roll_no) as students_enrolled from enrolls e inner join course c on
 e.course_id=c.course_id GROUP by (c.course_id,c.course_name);


     /* Query 2 : To view number of courses enrolled by each student */

select e.roll_no,s.first_name,s.last_name,count(e.course_id) as courses_enrolled from enrolls e inner join students s on
 e.roll_no=s.roll_no group by (e.roll_no,s.first_name,s.last_name);


     /* Query 3 : To list the faculties taking a specific course */

SELECT FACULTY.FACULTY_ID,FACULTY.FIRST_NAME,FACULTY.LAST_NAME,FACULTY.INITIALS
FROM FACULTY INNER JOIN TEACHES ON FACULTY.FACULTY_ID=TEACHES.FACULTY_ID WHERE COURSE_ID='&COURSE_ID';



    /* Query 4 : To view the names of students enrolled in a course (sort by FIRST_NAME) */

SELECT STUDENTS.FIRST_NAME,STUDENTS.LAST_NAME,STUDENTS.INITIALS FROM STUDENTS
WHERE ROLL_NO IN(SELECT ROLL_NO FROM STUDENT_FACULTY WHERE COURSE_ID='&COURSE_ID') ORDER BY STUDENTS.FIRST_NAME ASC;



     /* Query 5 : To list the students and their corresponding courses under a specific faculty */

SELECT STUDENTS.FIRST_NAME,STUDENTS.LAST_NAME,COURSE.COURSE_ID,COURSE.COURSE_NAME
FROM STUDENTS JOIN (COURSE JOIN STUDENT_FACULTY ON COURSE.COURSE_ID=STUDENT_FACULTY.COURSE_ID) ON
 STUDENTS.ROLL_NO=STUDENT_FACULTY.ROLL_NO WHERE FACULTY_ID='&FACULTY_ID';


      /* Query 6 : To list the number of boys in each course */

SELECT ENROLLS.COURSE_ID,COUNT(STUDENTS.ROLL_NO) AS BOYS
FROM (STUDENTS JOIN ENROLLS ON STUDENTS.ROLL_NO=ENROLLS.ROLL_NO)
WHERE ENROLLS.COURSE_ID IN (SELECT DISTINCT COURSE.COURSE_ID FROM
 (COURSE JOIN STUDENT_FACULTY ON COURSE.COURSE_ID=STUDENT_FACULTY.COURSE_ID))
AND STUDENTS.ROLL_NO IN (SELECT DISTINCT ROLL_NO FROM STUDENTS WHERE GENDER='M')
GROUP BY ENROLLS.COURSE_ID;


 
     /* Query 7 : To list the number of girls in each course */

SELECT ENROLLS.COURSE_ID,COUNT(STUDENTS.ROLL_NO) AS GIRLS
FROM (STUDENTS JOIN ENROLLS ON STUDENTS.ROLL_NO=ENROLLS.ROLL_NO)
WHERE ENROLLS.COURSE_ID IN (SELECT DISTINCT COURSE.COURSE_ID FROM
 (COURSE JOIN STUDENT_FACULTY ON COURSE.COURSE_ID=STUDENT_FACULTY.COURSE_ID))
AND STUDENTS.ROLL_NO IN (SELECT DISTINCT ROLL_NO FROM STUDENTS WHERE GENDER='F')
GROUP BY ENROLLS.COURSE_ID;



     /* Query 8 : To list the number of boys who have shortage of attendance in each course */

SELECT ENROLLS.COURSE_ID,COUNT(STUDENTS.ROLL_NO) AS BOYS
FROM (STUDENTS JOIN ENROLLS ON STUDENTS.ROLL_NO=ENROLLS.ROLL_NO)
WHERE ENROLLS.COURSE_ID IN (SELECT DISTINCT COURSE.COURSE_ID FROM
 (COURSE JOIN STUDENT_FACULTY ON COURSE.COURSE_ID=STUDENT_FACULTY.COURSE_ID))
AND ENROLLS.PERCENT<75
GROUP BY ENROLLS.COURSE_ID;



     /* Query 9 : To list name of faculties and courses (sort by maximum number of students) */

SELECT SF.COURSE_ID,C.COURSE_NAME,SF.FACULTY_ID,F.FIRST_NAME,F.LAST_NAME,COUNT(SF.ROLL_NO) AS TOT
FROM FACULTY F,STUDENT_FACULTY SF,COURSE C WHERE F.FACULTY_ID=SF.FACULTY_ID AND SF.COURSE_ID=C.COURSE_ID
GROUP BY (SF.COURSE_ID,SF.FACULTY_ID,C.COURSE_NAME,F.FIRST_NAME,F.LAST_NAME) ORDER BY TOT DESC;



  /* Query 10 : To show students whose name is starting with a vowel: */

        select concat(concat(first_name,' '),last_name) as Names_Starting_With_Vowels from students where 
        first_name like 'A%' or first_name like 'E%' or first_name like 'I%' or first_name like 'O%' or first_name like 'U%';



    /* Query 11 : To show students whose name starts with a consonant: */

        select concat(concat(first_name,' '),last_name) as Names_Starting_With_Consonants from students where
        first_name not like 'A%' and first_name not like 'E%' and first_name not like 'I%' and first_name not like 'O%' 
        and first_name not like 'U%';



 /* Query 12 : To show students who have attended morning classes: */
       
        select distinct(s.roll_no),concat(concat(s.first_name,' '),s.last_name) as Students_Attended_FN_Class from
        attendance_log a inner join students s on to_char(a_date,'HH24')>0 and to_char(a_date,'HH24')<12 and s.roll_no=a.roll_no;


   /* Query 13 : To show students who have attended afternoon classes: */
        
        select distinct(s.roll_no),concat(concat(s.first_name,' '),s.last_name) as Students_Attended_AN_Class from 
        attendance_log a inner join students s on to_char(a_date,'HH24')>12 and to_char(a_date,'HH24')<24 and s.roll_no=a.roll_no;


    /* Query 14 : To show students not enrolled in any course     */

        select roll_no,concat(concat(first_name,' '),last_name) as NAMES_NOT_ENROLLED from students
        minus
        select s.roll_no,concat(concat(s.first_name,' '),s.last_name) from students s inner join enrolls e on
        s.roll_no=e.roll_no;