
  
    /* Trigger 1 : Trigger to update present, absent and percentage attributes in enrolls table
     when a tuple is added to attendance_log */

create or replace trigger enrolls_insert
after insert
on Attendance_Log
for each row
declare
    r_x enrolls%rowtype;
    new_percent number;
    new_absent number;
    new_present number;
    cursor cur1 is select * from enrolls where roll_no=:new.roll_no and course_id=:new.course_id;
begin
    open cur1;
    fetch cur1 into r_x;
    new_absent := r_x.absent;
    new_present := r_x.present;
    if :new.hour < 0 then
        new_absent := r_x.absent + :new.hour*(-1);
    else
        new_present := r_x.present + :new.hour;
    end if;
        
    new_percent := (new_present / (new_present + new_absent)) * 100;
    update enrolls set present=new_present,absent=new_absent,percent=new_percent where roll_no=:new.roll_no and course_id=:new.course_id;
    close cur1;
end;
/

  /* Trigger 1 : Trigger to update present, absent and percentage attributes in enrolls table 
  when a tuple is added to attendance_log  END */




    /* Trigger 2 : Trigger to update present, absent and percentage attributes in enrolls table
     when an hour attribute of a tuple is updated in attendance_log */

create or replace trigger enrolls_update
after update
on Attendance_Log
for each row
declare
    r_x enrolls%rowtype;
    new_percent number;
    new_absent number;
    new_present number;
    cursor cur1 is select * from enrolls where roll_no=:new.roll_no and course_id=:new.course_id;
begin
    open cur1;
    fetch cur1 into r_x;
    new_absent := r_x.absent;
    new_present := r_x.present;

    if :old.hour < 0 then
        new_absent := new_absent - :old.hour*(-1);
    else
        new_present := new_present - :old.hour;
    end if;

    if :new.hour < 0 then 
        new_absent := new_absent + :new.hour*(-1);
    else
        new_present := r_x.present + :new.hour;
    end if;
        
    new_percent := (new_present / (new_present + new_absent)) * 100;
    update enrolls set present=new_present,absent=new_absent,percent=new_percent where roll_no=:new.roll_no and course_id=:new.course_id;
    close cur1;
end;
/

    /* Trigger 2 : Trigger to update present, absent and percentage attributes in enrolls table
     when an hour attribute of a tuple is updated in attendance_log END */


 
    /* Trigger 3 : Trigger to update present, absent and percentage attributes in enrolls table 
    when a tuple of attendance_log is deleted */

create or replace trigger enrolls_delete
after delete
on Attendance_Log
for each row
declare
    r_x enrolls%rowtype;
    new_percent number;
    new_absent number;
    new_present number;
    cursor cur1 is select * from enrolls where roll_no=:old.roll_no and course_id=:old.course_id;
begin
    open cur1;
    fetch cur1 into r_x;
    new_absent := r_x.absent;
    new_present := r_x.present;
    if :old.hour < 0 then
        new_absent := r_x.absent - :old.hour*(-1);
    else
        new_present := r_x.present - :old.hour;
    end if;

    if (new_present + new_absent) = 0
    then
        dbms_output.put_line('You havent attended any classes');
    else
        new_percent := (new_present / (new_present + new_absent)) * 100;
    end if;
    update enrolls set present=new_present,absent=new_absent,percent=new_percent where roll_no=:old.roll_no and course_id=:old.course_id;
    close cur1;
end;
/

/* Trigger 3 : Trigger to update present, absent and percentage attributes in enrolls table 
when a tuple of attendance_log is deleted END */




    /* Trigger 4 : Trigger to provide a notification if attendance percentage drops below 75 in enrolls table */

CREATE OR REPLACE TRIGGER notify_shortage
after update of percent on enrolls  
for each ROW
BEGIN
    if :new.percent<75 THEN
        dbms_output.put_line('SHORTAGE OF ATTENDANCE FOR '||:new.roll_no||' in '||:new.course_id);
    end if;
end;
/

    /* Trigger 4 : Trigger to provide a notification if attendance percentage drops below 75 in enrolls table END */





    /* Trigger 5 : Trigger Trigger to auto increment the attendance_id attribute in attendance_log table */

CREATE SEQUENCE id_seq START WITH 1;

CREATE OR REPLACE TRIGGER log_id 
BEFORE INSERT ON attendance_log
FOR EACH ROW

BEGIN
  SELECT id_seq.NEXTVAL
  INTO   :new.attendance_id
  FROM   dual;
END;
/

    /* Trigger 5 : Trigger to auto increment the attendance_id attribute in attendance_log table END */



 
    /* Trigger 6 : Trigger to insert system date and time in a_date attribute
    when a tuple is inserted in attendance_log table */
create or replace trigger a_date_insert
before insert on Attendance_Log
for each row
begin
 :new.a_date := localtimestamp;
end;
/
    /* Trigger 6 : Trigger to insert system date and time in a_date attribute
    when a tuple is inserted in attendance_log table END */


