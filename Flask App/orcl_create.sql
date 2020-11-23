CREATE TABLE Students(
    roll_no int NOT NULL ,
    pass_word varchar(25) NOT NULL,
    first_name varchar(20) NOT NULL,
    last_name varchar(20) NOT NULL,
    initials varchar(5) NOT NULL,
    email_id varchar(40) NOT NULL,
    dob date NOT NULL,
    gender varchar(1) NOT NULL,
    PRIMARY KEY(roll_no)
);

CREATE TABLE Faculty(
    faculty_id int NOT NULL ,
    pass_word varchar(25) NOT NULL,
    first_name varchar(20) NOT NULL,
    last_name varchar(20) NOT NULL,
    initials varchar(5) NOT NULL,
    email_id varchar(40) NOT NULL,
    PRIMARY KEY(faculty_id)
);


CREATE TABLE Course(
    course_id varchar(10) NOT NULL ,
    course_name varchar(60) NOT NULL,
    PRIMARY KEY(course_id)
);



CREATE TABLE Enrolls(
    roll_no int NOT NULL,
    course_id varchar(10) NOT NULL,
    present int NOT NULL,
    absent int NOT NULL,
    percent int NOT NULL,
    PRIMARY KEY (roll_no, course_id),
    FOREIGN KEY (roll_no) REFERENCES Students (roll_no) on delete CASCADE,
    FOREIGN KEY (course_id) REFERENCES Course (course_id) on delete CASCADE
);

CREATE TABLE Teaches(
    faculty_id int NOT NULL,
    course_id varchar(10) NOT NULL,
    PRIMARY KEY (faculty_id, course_id),
    FOREIGN KEY (faculty_id) REFERENCES Faculty (faculty_id) on delete CASCADE,
    FOREIGN KEY (course_id) REFERENCES Course (course_id) on delete CASCADE
);

CREATE TABLE Student_Faculty(
    roll_no int NOT NULL,
    faculty_id int NOT NULL,
    course_id varchar(10) NOT NULL,
    PRIMARY KEY (roll_no,faculty_id,course_id),
    FOREIGN KEY (roll_no,course_id) REFERENCES Enrolls (roll_no,course_id) on delete CASCADE,
    FOREIGN KEY (faculty_id,course_id) REFERENCES Teaches (faculty_id,course_id)
);



CREATE TABLE Attendance_Log(
    attendance_id int not null,
    roll_no int NOT NULL,
    course_id varchar(10) NOT NULL,
    faculty_id int NOT NULL ,
    hour int NOT NULL,
    a_date timestamp,
    PRIMARY KEY (attendance_id,roll_no,faculty_id,course_id),
    FOREIGN KEY (roll_no,faculty_id,course_id) REFERENCES Student_Faculty (roll_no,faculty_id,course_id)
);


CREATE SEQUENCE attendance_seq START WITH 1;

CREATE OR REPLACE TRIGGER attendance_trigger
BEFORE INSERT ON Attendance_Log
FOR EACH ROW

begin
    select attendance_seq.NEXTVAL into :new.attendance_id FROM DUAL;
end;
/

