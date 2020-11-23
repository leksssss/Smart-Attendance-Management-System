Students:
Note:- 
1) Let the password be firstname and last four digits of roll_no for now.
2) Email ID is firstname.lastname@gmail.com for now.

INSERT INTO Students VALUES (2018103558,'lekha3558','Lekha','Shanthini','R','lekha.shanthini@gmail.com','17-Sep-2000','F');
INSERT INTO Students VALUES (2018103561,'madhu3561','Madhumita',' ','R','madhumita@gmail.com','05-Apr-2001','F');
INSERT INTO Students VALUES (2018103531,'diviya3531','Diviya','Seshani','K','diviya.seshani@gmail.com','03-Apr-2001','F');
INSERT INTO Students VALUES (2018103567,'murali3567','Murali','Krishnan','S','murali.krishnan@gmail.com','07-Jul-2001','M');
INSERT INTO Students VALUES (2018103063,'shankar3063','Shankar','Kumar','S','shankar.kumar@gmail.com','20-Jan-2001','M');
INSERT INTO Students VALUES (2018103555,'kripa3555','Kripa','Shankar','T','kripa.shankar@gmail.com','25-Jan-2001','M');
INSERT INTO Students VALUES (2018103055,'rohit3055','Rohit','Gopalakrishnan','V','rohit.gopal@gmail.com','25-Nov-2000','M');
INSERT INTO Students VALUES (2018103031,'jerrick3031','Jerrick','Gerald',' ','jerrick.gerald@gmail.com','11-May-2001','M');
INSERT INTO Students VALUES (2018103079,'vignesh3079','Vignesh','Kumar','G','vignesh@gmail.com','26-Apr-2000','M');
INSERT INTO Students VALUES (2018103570,'niranjana3570','Niranjana',' ','R','niranjana@gmail.com','07-Aug-2000','F');
INSERT INTO Students VALUES (2018103001,'akshay3001','Akshay',' ','T','akshay@gmail.com','07-Aug-2000','M');



Faculty:
Note:-
1) Same as Students for Password and Email ID
2) For Faculty_id first two digits show the department and last three be their unique id.
3) Took Author names as faculty names. Had no other idea.

INSERT INTO Faculty VALUES (10001,'abraham001','Abraham','Silberschatz',' ','abraham.silberschatz@gmail.com');
INSERT INTO Faculty VALUES (10002,'henry002','Henry','Korth','F','henry.korth@gmail.com');
INSERT INTO Faculty VALUES (10003,'greg003','Greg','Gagne',' ','greg.gagne@gmail.com');
INSERT INTO Faculty VALUES (19001,'stephen001','Stephen','Friedberg','H','stephen.friedberg@gmail.com');
INSERT INTO Faculty VALUES (10004,'john004','John','Hopcroft','E','john.hopcroft@gmail.com');
INSERT INTO Faculty VALUES (17001,'gilbert001','Gilbert','Masters','M','gilbert.masters@gmail.com');
INSERT INTO Faculty VALUES (17002,'benny002','Benny','Joseph',' ','benny.joseph@gmail.com');
INSERT INTO Faculty VALUES (10005,'ellis005','Ellis',' Horowit',' ','ellis.horowit@gmail.com');
INSERT INTO Faculty VALUES (10006,'morris006','Morris','Mano','M','morris.mano@gmail.com');
INSERT INTO Faculty VALUES (19002,'milton002','Milton','J','S','milton.j@gmail.com');




Course:

INSERT INTO Course VALUES ('CS6106','Database Management Systems');
INSERT INTO Course VALUES ('CS6108','Operating Systems');
INSERT INTO Course VALUES ('MA6201','Linear Algebra');
INSERT INTO Course VALUES ('CS6202','Theory of Computation');
INSERT INTO Course VALUES ('CY6391','Environmental Science and Engineering'); 
INSERT INTO Course VALUES ('CS6104','Data Structures and Algorithms '); 
INSERT INTO Course VALUES ('CS6105','Digital Fundamentals and Computer Organization'); 
INSERT INTO Course VALUES ('MA6351','Probability and Statistic'); 
INSERT INTO Course VALUES ('GE6251','Engineering Graphic'); 
INSERT INTO Course VALUES ('CY6251','Engineering Chemistry'); 



Teaches:
Note:-
1) Faculty_id is taken from Faculty and Course_id from Course

INSERT INTO Teaches VALUES (10001,'CS6106');
INSERT INTO Teaches VALUES (10002,'CS6106');
INSERT INTO Teaches VALUES (10001,'CS6108');
INSERT INTO Teaches VALUES (10003,'CS6108');
INSERT INTO Teaches VALUES (19001,'MA6201');
INSERT INTO Teaches VALUES (10004,'CS6202');
INSERT INTO Teaches VALUES (17001,'CY6391');
INSERT INTO Teaches VALUES (17002,'CY6391');
INSERT INTO Teaches VALUES (10005,'CS6104');
INSERT INTO Teaches VALUES (10006,'CS6105');
INSERT INTO Teaches VALUES (19002,'MA6351');



Enrolls:
Note:-
1) Roll_no is taken from Students and Course_id from Course.

INSERT INTO Enrolls VALUES (2018103558,'CS6106',0,0,0);
INSERT INTO Enrolls VALUES (2018103558,'CS6108',0,0,0);
INSERT INTO Enrolls VALUES (2018103558,'MA6201',0,0,0);
INSERT INTO Enrolls VALUES (2018103558,'CY6391',0,0,0);
INSERT INTO Enrolls VALUES (2018103561,'CS6106',0,0,0);
INSERT INTO Enrolls VALUES (2018103561,'CS6108',0,0,0);
INSERT INTO Enrolls VALUES (2018103561,'MA6201',0,0,0);
INSERT INTO Enrolls VALUES (2018103561,'CY6391',0,0,0);
INSERT INTO Enrolls VALUES (2018103567,'CS6106',0,0,0);
INSERT INTO Enrolls VALUES (2018103567,'CS6108',0,0,0);
INSERT INTO Enrolls VALUES (2018103567,'CS6202',0,0,0);
INSERT INTO Enrolls VALUES (2018103567,'CY6391',0,0,0);
INSERT INTO Enrolls VALUES (2018103555,'CS6106',0,0,0);
INSERT INTO Enrolls VALUES (2018103555,'CS6108',0,0,0);
INSERT INTO Enrolls VALUES (2018103555,'MA6201',0,0,0);
INSERT INTO Enrolls VALUES (2018103555,'CY6391',0,0,0);




Student_Faculty:

INSERT INTO Student_Faculty VALUES (2018103558,10001,'CS6106');
INSERT INTO Student_Faculty VALUES (2018103558,10002,'CS6106');
INSERT INTO Student_Faculty VALUES (2018103558,10003,'CS6108');
INSERT INTO Student_Faculty VALUES (2018103558,19001,'MA6201');
INSERT INTO Student_Faculty VALUES (2018103558,17001,'CY6391');

INSERT INTO Student_Faculty VALUES (2018103561,10001,'CS6106');
INSERT INTO Student_Faculty VALUES (2018103561,10002,'CS6106');
INSERT INTO Student_Faculty VALUES (2018103561,10003,'CS6108');
INSERT INTO Student_Faculty VALUES (2018103561,19001,'MA6201');
INSERT INTO Student_Faculty VALUES (2018103561,17002,'CY6391');

INSERT INTO Student_Faculty VALUES (2018103567,10001,'CS6106');
INSERT INTO Student_Faculty VALUES (2018103567,10002,'CS6106');
INSERT INTO Student_Faculty VALUES (2018103567,10003,'CS6108');
INSERT INTO Student_Faculty VALUES (2018103567,10004,'CS6202');
INSERT INTO Student_Faculty VALUES (2018103567,17002,'CY6391');

INSERT INTO Student_Faculty VALUES (2018103555,10001,'CS6106');
INSERT INTO Student_Faculty VALUES (2018103555,10002,'CS6106');
INSERT INTO Student_Faculty VALUES (2018103555,10003,'CS6108');
INSERT INTO Student_Faculty VALUES (2018103555,19001,'MA6201');
INSERT INTO Student_Faculty VALUES (2018103555,17002,'CY6391');



Attendace_Log:

INSERT INTO Attendance_Log (roll_no,faculty_id,course_id,hour) VALUES  (2018103558,10001,'CS6106',4);
INSERT INTO Attendance_Log (roll_no,faculty_id,course_id,hour) VALUES  (2018103558,10002,'CS6106',2);
INSERT INTO Attendance_Log (roll_no,faculty_id,course_id,hour) VALUES  (2018103558,10003,'CS6108',2);
INSERT INTO Attendance_Log (roll_no,faculty_id,course_id,hour) VALUES  (2018103558,19001,'MA6201',2);
INSERT INTO Attendance_Log (roll_no,faculty_id,course_id,hour) VALUES  (2018103558,17001,'CY6391',2);

INSERT INTO Attendance_Log (roll_no,faculty_id,course_id,hour) VALUES  (2018103561,10001,'CS6106',4);
INSERT INTO Attendance_Log (roll_no,faculty_id,course_id,hour) VALUES  (2018103561,10002,'CS6106',-2);
INSERT INTO Attendance_Log (roll_no,faculty_id,course_id,hour) VALUES  (2018103561,10003,'CS6108',2);
INSERT INTO Attendance_Log (roll_no,faculty_id,course_id,hour) VALUES  (2018103561,19001,'MA6201',2);
INSERT INTO Attendance_Log (roll_no,faculty_id,course_id,hour) VALUES  (2018103561,17002,'CY6391',2);

INSERT INTO Attendance_Log (roll_no,faculty_id,course_id,hour) VALUES  (2018103567,10001,'CS6106',4);
INSERT INTO Attendance_Log (roll_no,faculty_id,course_id,hour) VALUES  (2018103567,10002,'CS6106',-2);
INSERT INTO Attendance_Log (roll_no,faculty_id,course_id,hour) VALUES  (2018103567,10003,'CS6108',2);
INSERT INTO Attendance_Log (roll_no,faculty_id,course_id,hour) VALUES  (2018103567,10004,'CS6202',-2);
INSERT INTO Attendance_Log (roll_no,faculty_id,course_id,hour) VALUES  (2018103567,17002,'CY6391',2);

INSERT INTO Attendance_Log (roll_no,faculty_id,course_id,hour) VALUES  (2018103555,10001,'CS6106',4);
INSERT INTO Attendance_Log (roll_no,faculty_id,course_id,hour) VALUES  (2018103555,10002,'CS6106',-2);
INSERT INTO Attendance_Log (roll_no,faculty_id,course_id,hour) VALUES  (2018103555,10003,'CS6108',2);
INSERT INTO Attendance_Log (roll_no,faculty_id,course_id,hour) VALUES  (2018103555,19001,'MA6201',-2);
INSERT INTO Attendance_Log (roll_no,faculty_id,course_id,hour) VALUES  (2018103555,17002,'CY6391',2);
