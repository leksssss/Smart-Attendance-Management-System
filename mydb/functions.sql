
    /* Function 1 : A function to show all courses attended by a specific student on a given day
     and returns the total number of hours attended on that date */

    create or replace function att_date (l_roll_no in attendance_log.roll_no%type, l_date in attendance_log.a_date%type)
    return number
    IS
    begin
        DECLARE
            CURSOR check_att_date is select al.roll_no , al.a_date , al.hour ,c.course_id , c.course_name 
            from attendance_log al , course c where c.course_id= al.course_id;
            r_row check_att_date%rowtype;
            tot number :=0;
            BEGIN
                open check_att_date;
                dbms_output.put_line('ON '||to_char(l_date,'DD-Mon-YYYY'));
                dbms_output.put_line('YOU HAVE ATTENDED: ');
                dbms_output.put_line('COURSE_ID'||chr(9)||chr(9)||'HOURS'||chr(9)||chr(9)||chr(9)||chr(9)||'COURSE_NAME');
                loop
                    fetch check_att_date into r_row;
                    exit when check_att_date%notfound;
                    
                    if r_row.roll_no = l_roll_no THEN
                        if to_char(r_row.a_date,'DD-Mon-YYYY') = to_char(l_date,'DD-Mon-YYYY') THEN
                            if r_row.hour > 0 then
                                tot := tot+ r_row.hour;
                                dbms_output.put_line(r_row.course_id ||chr(9)||chr(9)||chr(9)|| r_row.hour  ||chr(9)||chr(9)||chr(9)||r_row.course_name);
                            end IF;
                        end IF;
                    end IF;
                end loop;
                return (tot) ;
            end;   
        
    end;
    /

DECLARE
    roll_no number := &roll_no;
    a_date date := '&a_date';
    temp number;
BEGIN
    temp:=att_date(roll_no,a_date);
    dbms_output.put_line('Total Hours attended: ' || temp);
end;
/

    /* Function 1 : A function to show all courses attended by a specific student on a given day
     and returns the total number of hours attended on that date END */







/* Function 2 : A function to show the number of hours taken by a faculty for a specific course */

CREATE OR REPLACE FUNCTION FACULTY_HOURS(L_FACULTY_ID IN ATTENDANCE_LOG.FACULTY_ID%TYPE,L_COURSE_ID IN COURSE.COURSE_ID%TYPE)
RETURN NUMBER
IS
BEGIN
	DECLARE CURSOR CHECK_FACULTY_HOURS IS  SELECT DISTINCT ATTENDANCE_LOG.HOUR,to_char(ATTENDANCE_LOG.A_DATE,'DD-Mon-YYYY') as A_DATE
	FROM ATTENDANCE_LOG WHERE COURSE_ID=L_COURSE_ID AND FACULTY_ID=L_FACULTY_ID;
	H_ROW CHECK_FACULTY_HOURS%ROWTYPE;
	TOTAL NUMBER:=0;
	BEGIN
	OPEN CHECK_FACULTY_HOURS;
	DBMS_OUTPUT.PUT_LINE('FOR '||L_COURSE_ID||' YOU HAVE TAKEN:');
	LOOP
		FETCH CHECK_FACULTY_HOURS INTO H_ROW;
		EXIT WHEN CHECK_FACULTY_HOURS%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE(H_ROW.A_DATE||CHR(9)||CHR(9)||H_ROW.HOUR);
		TOTAL:=TOTAL+H_ROW.HOUR;
	END LOOP;
	RETURN TOTAL;
	END;
END;
/
	

    
DECLARE
    temp number;
    faculty_id number;
    course_id varchar(20);
BEGIN
    temp:=FACULTY_HOURS(&faculty_id,'&course_id');
    dbms_output.put_line('Total Hours taken: ' || temp);
end;
/


    /* Function 2 : A function to show the number of hours taken by a faculty for a specific course END */









     /* Function 3 : A function to display a student’s attendance in all courses */

create or replace Function get_attendance_details_all(
    a_roll_no in number,
    a_course_id in varchar
    )
    return enrolls%ROWTYPE
is
    a_enrolls enrolls%ROWTYPE;
begin
    select * into a_enrolls from enrolls where roll_no=a_roll_no and course_id=a_course_id;
    return a_enrolls;
end;
/


declare
    r_enrolls enrolls%ROWTYPE ;
    student_course varchar(10);
    v_course_name varchar(50);
    n_roll_no number := &n_roll_no;
    cursor cur1 is
    select course_id from enrolls where roll_no=n_roll_no;
begin
    open cur1;
    dbms_output.put_line('COURSE'||chr(9)||chr(9)||'PRESENT' ||chr(9)||chr(9)|| 'ABSENT'||chr(9)||chr(9)|| 'PERCENT'||chr(9)||chr(9)||'COURSE NAME' );
    loop
        fetch cur1 into student_course;
        select course_name into v_course_name from course where course_id=student_course;
        exit when cur1%NOTFOUND;
        r_enrolls := get_attendance_details_all(n_roll_no,student_course);
        dbms_output.put_line(student_course||chr(9)||chr(9)||r_enrolls.present ||chr(9)||chr(9)||r_enrolls.absent ||chr(9)||chr(9)||r_enrolls.percent||chr(9)||chr(9)||v_course_name);
    end loop;
    close cur1;
end;
/


        /* Function 3 : A function to display a student’s attendance in all courses END */









    /* Function 4 : A function to display number of hours and date on which student has attended a specific course  */

CREATE OR REPLACE FUNCTION STUDENT_HOURS(L_ROLL_NO IN ATTENDANCE_LOG.ROLL_NO%TYPE,L_COURSE_ID IN COURSE.COURSE_ID%TYPE)
RETURN NUMBER
IS
BEGIN
	DECLARE CURSOR CHECK_FACULTY_HOURS IS  SELECT DISTINCT ATTENDANCE_LOG.HOUR,to_char(ATTENDANCE_LOG.A_DATE,'DD-Mon-YYYY') as A_DATE
	FROM ATTENDANCE_LOG WHERE COURSE_ID=L_COURSE_ID AND ROLL_NO=L_ROLL_NO;
	H_ROW CHECK_FACULTY_HOURS%ROWTYPE;
	TOTAL NUMBER:=0;
	BEGIN
	OPEN CHECK_FACULTY_HOURS;
	DBMS_OUTPUT.PUT_LINE('FOR '||L_COURSE_ID||' YOU HAVE ATTENDED :');
	DBMS_OUTPUT.PUT_LINE('DATE'||CHR(9)||CHR(9)||chr(9)||'HOURS');
	LOOP
		FETCH CHECK_FACULTY_HOURS INTO H_ROW;
		EXIT WHEN CHECK_FACULTY_HOURS%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE(H_ROW.A_DATE||CHR(9)||CHR(9)||H_ROW.HOUR);
		TOTAL:=TOTAL+H_ROW.HOUR;
	END LOOP;
	RETURN TOTAL;
	END;
END;
/
	
    
DECLARE
    temp number;
    ROLL_NO number;
    course_id varchar(20);
BEGIN
    temp:=student_hours(&ROLL_NO,'&course_id');
    dbms_output.put_line('Total Hours attended: ' || temp);
end;
/


        /* Function 4 : A function to display number of hours and date on which student has attended a specific course  END */


