1)
    /* Get Student Details */

CREATE or REPLACE PROCEDURE getStudentDetails(no in students.roll_no%type , r_student out students%rowtype)
IS
BEGIN
    SELECT * into r_student from students  where roll_no = no;
END;
/

DECLARE
temp_student students%rowtype;
roll_no number := &roll_no;
BEGIN
    getStudentDetails(roll_no,temp_student);
    dbms_output.put_line('DETAILS:');
    dbms_output.put_line('ROLL NO:'||'      |   '||temp_student.roll_no);
    dbms_output.put_line('FIRST NAME:'||'   |   '|| temp_student.first_name);
    dbms_output.put_line('LAST NAME:'||'    |   '|| temp_student.last_name);
    dbms_output.put_line('EMAIL ID:'||'     |   '|| temp_student.email_id);
    dbms_output.put_line('DOB:'||'          |   '|| to_char(temp_student.dob,'DD-MM-YYYY'));
END;
/

    /* Get Student Details END */



2)
    /* To show how many classes they have attended on a day (Given roll_no,course_id,a_date) */
    
create or replace procedure abs_pre (l_roll_no in attendance_log.roll_no%type,l_date in attendance_log.a_date%type , l_cid in attendance_log.course_id%type)
    IS
    cursor check_att is select hour from attendance_log where a_date=l_date and course_id=l_cid and roll_no=l_roll_no;
        r_row check_att%rowtype;
        flag number :=0;
        
        BEGIN
            open check_att;
            loop
            fetch check_att into r_row;
            exit when check_att%notfound;
            if r_row.hour > 0 THEN
                dbms_output.put_line('YOU WERE PRESENT FOR '||r_row.hour||' hours');
                flag:=1;
            ELSE
                dbms_output.put_line('YOU WERE ABSENT FOR '||r_row.hour*-1||' hours');
                flag:=1;
            end IF;
            end loop;
            close check_att;

            if flag = 0 THEN
                dbms_output.put_line ('There was no class on '||l_date||' for the course '||l_cid);
            end if;
           
            
        end;    
    /

DECLARE
    roll_no students.roll_no%type := &roll_no;
    a_date attendance_log.a_date%type := '&attendance_date';
    course_id course.course_id%type := '&course_id';
BEGIN
    course_id := upper(course_id);
    abs_pre(roll_no,a_date,course_id);
 end;
/

    /* To show how many classes they have attended on a day (Given roll_no,course_id,a_date) END */



3)
    /* To show students enrolled in a course */

CREATE OR REPLACE PROCEDURE students_enrolled (id enrolls.course_id%type)
IS
BEGIN
    DECLARE
    CURSOR Enrolled is select s.roll_no, e.course_id,s.first_name, s.last_name from students s , enrolls e where s.roll_no=e.roll_no;
    r_enrolled enrolled%rowtype;

    BEGIN
        open enrolled;
        dbms_output.put_line('ROLL NO'||chr(9)||chr(9)||chr(9)||chr(9)||'FIRST NAME'||chr(9)||chr(9)||chr(9)||'LAST NAME');
        dbms_output.put_line('--------------------------------------------------------------------------------');
        loop
            fetch enrolled into r_enrolled ;
            exit when enrolled%notfound;
            if r_enrolled.course_id = id then 
                dbms_output.put_line(r_enrolled.roll_no||chr(9)||chr(9)||chr(9)||r_enrolled.first_name||chr(9)||chr(9)||chr(9)||chr(9)|| r_enrolled.last_name);
            end if;
        end loop;
        close enrolled;
    end;
end;
/

DECLARE
    course_id course.course_id%type := '&course_id';
BEGIN
    course_id:=upper(course_id);
    students_enrolled(course_id);
END;
/

    /* To show students enrolled in a course END */



4)
    /* To show the courses enrolled by a student */

CREATE OR REPLACE PROCEDURE courses_enrolled (id enrolls.roll_no%type)
IS
BEGIN
    DECLARE
    CURSOR Enrolled is select c.course_id,c.course_name,e.roll_no as roll_no from course c, enrolls e
    where c.course_id=e.course_id;
    r_enrolled enrolled%rowtype;

    BEGIN
        open enrolled;
        dbms_output.put_line('COURSE ID'||chr(9)||chr(9)||chr(9)||'COURSE NAME');
        dbms_output.put_line('---------------------------------------------------------------------');
        loop
            fetch enrolled into r_enrolled ;
            exit when enrolled%notfound;
            if r_enrolled.roll_no=id THEN
                dbms_output.put_line(r_enrolled.course_id||chr(9)||chr(9)||chr(9)||chr(9)||r_enrolled.course_name);
            end if;
        end loop;
        close enrolled;
    end;
end;
/

DECLARE
    roll_no students.roll_no%type := &roll_no;
BEGIN
    courses_enrolled(roll_no);
END;
/

    /* To show the courses enrolled by a student END */





5)
     /* To show no of available bunks */

CREATE OR REPLACE PROCEDURE remain_bunk (rno in students.roll_no%type , cid in course.course_id%type)
IS
BEGIN
    DECLARE
        temp number;
        p number;
        a number;
    BEGIN
        select present into p from enrolls where roll_no = rno and course_id = cid;
        select absent into a from enrolls where roll_no = rno and course_id = cid;
        temp := ((p*100)/75) - (p+a);
        temp := floor(temp);
        if temp < 0 THEN
            temp := temp * (-3);
            dbms_output.put_line('You have to attend next '||temp||' classes');
        
        ELSE
            dbms_output.put_line('You can bunk next '||temp||' classes');
        end if;
    END;
END;
/

DECLARE
    roll_no students.roll_no%type := &roll_no;
    course_id course.course_id%type := '&course_id';
    bunk_left number;
BEGIN
    course_id := upper(course_id);
    remain_bunk(roll_no,course_id);
END;
/

    /* To show no of available bunks END */



6)  /* To show the students who have shortage of attendance */

Given a course id and faculty id, will return all students who have shortage of attendance

CREATE OR REPLACE PROCEDURE att_shortage (cid in course.course_id%type , fid in faculty.faculty_id%type)
IS
BEGIN
    DECLARE CURSOR stu_att is select sf.faculty_id,sf.roll_no,s.first_name,s.last_name,e.course_id,e.percent,e.absent,e.present
    from enrolls e , students s ,student_faculty sf where sf.roll_no=e.roll_no and sf.course_id=e.course_id and sf.roll_no=s.roll_no;
    r_row stu_att%rowtype;
    BEGIN
        OPEN stu_att;
        dbms_output.put_line('roll_no'||chr(9)||chr(9)||'first_name'||chr(9)||'last_name'||chr(9)||'percent');
        loop
            fetch stu_att into r_row;
            exit when stu_att%notfound;
            if r_row.faculty_id = fid THEN
                if r_row.course_id = cid THEN
                    if r_row.percent<75 and (r_row.absent+r_row.present)>0 THEN
                        dbms_output.put_line(r_row.roll_no||chr(9)|| r_row.first_name ||chr(9)||chr(9)||r_row.last_name ||chr(9)||chr(9)|| r_row.percent);
                    end if;
                end if;
            end if;
        end loop;

    END;
END;
/

DECLARE
    v_course_id varchar(20) := '&v_course_id';
    n_faculty_id number := &n_faculty_id;
BEGIN
    v_course_id := upper(v_course_id);
    att_shortage(v_course_id,n_faculty_id);
END;
/

    /* To show the students who have shortage of attendance END */










/* Implementaion*/
CREATE OR REPLACE PROCEDURE all_att(rno in students.roll_no%type)
IS
BEGIN
    DECLARE
        CURSOR cur_att is select * from enrolls;
        r_row cur_att%rowtype;
        BEGIN
            open  cur_att;
            loop
                fetch cur_att into r_row;
                exit when cur_att%notfound;
                if r_row.roll_no = rno  then
                    dbms_output.put_line(r_row.course_id||chr(9)||chr(9)||r_row.present||chr(9)||r_row.absent||chr(9)||r_row.percent);
                end if;
            end loop;
        end;
end;
/

BEGIN
    all_att(2018103075);
end;
/

  /* Implementation */

CREATE OR REPLACE PROCEDURE remain_bunk (rno in students.roll_no%type , cid in course.course_id%type)
IS
BEGIN
    DECLARE
        temp number;
        p number;
        a number;
        c_name course.course_name%type;
    BEGIN
        select present into p from enrolls where roll_no = rno and course_id = cid;
        select absent into a from enrolls where roll_no = rno and course_id = cid;
        select course_name into c_name from course where course_id=cid;
        temp := ((p*100)/75) - (p+a);
        temp := floor(temp);
        if temp < 0 THEN
            temp := temp * (-3);
            dbms_output.put_line('You have to attend next '||temp||' classes in '||c_name);
        
        ELSE
            dbms_output.put_line('You can bunk next '||temp||' classes in '||c_name);
        end if;
    END;
END;
/

DECLARE
    roll_no students.roll_no%type := &roll_no;
    course_id course.course_id%type := '&course_id';
    bunk_left number;
BEGIN
    course_id := upper(course_id);
    remain_bunk(roll_no,course_id);
END;
/

    /* END */

