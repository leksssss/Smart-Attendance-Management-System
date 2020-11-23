/* View 1 : A view table to show students who have shortage of attendance */
CREATE OR REPLACE VIEW shortage_att AS
SELECT s.first_name,s.last_name,e.roll_no,e.course_id,e.percent from enrolls e inner join students s 
on e.percent<75 and (e.present+e.absent)>0 and e.roll_no=s.roll_no;


/* View 2 : A view table to show students who do not have shortage of attendance */
CREATE OR REPLACE VIEW not_shortage_att AS
SELECT s.first_name,s.last_name,e.roll_no,e.course_id,e.percent from enrolls e inner join students s 
on e.percent>=75 and e.roll_no=s.roll_no;

/* View 3 : A view table to show students who have full attendance */
CREATE OR REPLACE VIEW full_att AS
SELECT s.first_name,s.last_name,e.roll_no,e.course_id,e.percent from enrolls e inner join students s 
on e.percent=100 and e.roll_no=s.roll_no;


/* View 4 : A view table to show which all courses a student has enrolled under which faculty */
CREATE or REPLACE VIEW enrollment AS
select s.roll_no , s.first_name, s.last_name , c.course_id , c.course_name , f.faculty_id,f.first_name as f_first_name , f.last_name as f_last_name
from students s,faculty f ,course c,student_faculty sf 
where s.roll_no=sf.roll_no and c.course_id=sf.course_id and f.faculty_id=sf.faculty_id; 


/* View 5 : A view table to show the number of students enrolled in each course */
CREATE OR REPLACE VIEW CLASS_STRENGTH AS SELECT C.COURSE_ID,C.COURSE_NAME,COUNT(E.ROLL_NO) AS STRENGTH FROM ENROLLS E INNER JOIN COURSE C
ON E.COURSE_ID=C.COURSE_ID GROUP BY (C.COURSE_ID,C.COURSE_NAME);


