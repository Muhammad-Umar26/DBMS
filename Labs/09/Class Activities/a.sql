

-- Activity Q1
create table students_delete_logs(
    stu_id int,
    stu_name varchar(20),
    deleted_by varchar(20),
    deleted_on date
);


create or replace trigger after_delete
after delete on Students
for each row
begin
insert into students_delete_logs(stu_id,stu_name,deleted_by,deleted_on) values 
(:OLD.stu_id,:OLD.stu_name,SYS_CONTEXT('USERENV','SESSION_USER'),SYSDATE);
end;
/

delete from students where stu_id = 23;
select * from STUDENTS_DELETE_LOGS;


-- Activity 2

create or replace trigger prevent_students_table
before drop on schema
begin 
IF  ora_dict_obj_name = 'STUDENTS' and ora_dict_obj_type = 'TABLE'
then
RAISE_APPLICATION_ERROR(num => -20000, msg => 'Cannot Drop Object');
end if;
end;
/

DROP TABLE students;
