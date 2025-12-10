--Q1
create or replace trigger trg_before_insert_students
before insert on students
for each row
begin
    :new.student_name := upper(:new.student_name);
end;
/

--Q2
create or replace trigger trg_prevent_weekend_delete
before delete on employees
begin
    if to_char(sysdate, 'dy') in ('sat','sun') then
        raise_application_error(-20001, 'deletion not allowed on weekends');
    end if;
end;
/

--Q3
create table log_salary_audit (
    emp_id number,
    old_salary number,
    new_salary number,
    changed_on date
);

create or replace trigger trg_log_salary_update
after update of salary on employees
for each row
begin
    insert into log_salary_audit values (:old.emp_id, :old.salary, :new.salary, sysdate);
end;
/

--Q4
create or replace trigger trg_no_negative_price
before update on products
for each row
begin
    if :new.price < 0 then
        raise_application_error(-20002, 'negative price not allowed');
    end if;
end;
/

--Q5
create or replace trigger trg_courses_insert
before insert on courses
for each row
begin
    :new.created_by := user;
    :new.created_on := sysdate;
end;
/

--Q6
create or replace trigger trg_default_department
before insert on emp
for each row
begin
    if :new.department_id is null then
        :new.department_id := 100;
    end if;
end;
/

--Q7
create or replace trigger trg_sales_compound
for insert on sales
compound trigger

    total_sales number := 0;

    before statement is
    begin
        total_sales := 0;
    end before statement;

    after each row is
    begin
        total_sales := total_sales + :new.amount;
    end after each row;

    after statement is
    begin
        dbms_output.put_line('total sales = ' || total_sales);
    end after statement;

end;
/

--Q8
create table schema_ddl_log (
    action_type varchar2(50),
    object_name varchar2(100),
    event_time date
);

create or replace trigger trg_schema_ddl_audit
after create or drop on schema
begin
    insert into schema_ddl_log values (ora_sysevent, ora_dict_obj_name, sysdate);
end;
/

--Q9
create or replace trigger trg_prevent_update_shipped
before update on orders
for each row
begin
    if :old.order_status = 'shipped' then
        raise_application_error(-20003, 'cannot update shipped order');
    end if;
end;
/

--Q10
create table login_audit (
    username varchar2(50),
    login_time date
);

create or replace trigger trg_logon_audit
after logon on database
begin
    insert into login_audit values (sys_context('userenv','session_user'), sysdate);
end;
/
