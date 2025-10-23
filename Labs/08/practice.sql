set serveroutput on;

declare
sec_name varchar(20) := 'Sec-5A';
course_name varchar(20) := 'Database systems Lab';

Begin
DBMS_OUTPUT.PUT_LINE('Welcome ' || sec_name || ' to the ' || course_name);
End;
/

declare
a int := 10;
b int := 20;
c int;
f real;

begin
c := a + b;
DBMS_OUTPUT.PUT_LINE('Value of c is ' || c);
f := 70.0/3.0;
DBMS_OUTPUT.PUT_LINE('Value of f is ' || f);
end;
/

declare
num1 number := 21;
num2 number := 22;

begin
DBMS_OUTPUT.PUT_LINE('Output variable num1 = ' || num1);
DBMS_OUTPUT.PUT_LINE('Output variable num2 = ' || num2);

declare
n1 int := 45;
n2 int := 12;

begin
DBMS_OUTPUT.PUT_LINE('local variables n1 and n2 are ' || n1 || ' and ' || n2);
end;

end;
/

declare
e_name varchar(20);

begin
select first_name into e_name from employees where employee_id = 1010;
DBMS_OUTPUT.put_line('Employee name is ' || e_name);

exception
when
no_data_found then
DBMS_OUTPUT.PUT_LINE('No employee found');
end;
/

declare

begin
update employees set salary = salary * 1.10 where department_id = (select department_id from departments where department_name = 'Administration');
DBMS_OUTPUT.PUT_LINE('salary updated successfully');
end;
/

declare

e_id employees.employee_id%type;
e_name employees.first_name%type;
d_name departments.department_name%type;

begin
select employee_id, first_name, department_name into e_id, e_name, d_name from employees inner join departments on employees.department_id = departments.department_id where employee_id = 100;

DBMS_OUTPUT.PUT_LINE('Employee Id: ' || e_id);
DBMS_OUTPUT.PUT_LINE('Employee first name: ' || e_name);
DBMS_OUTPUT.PUT_LINE('Department Name: ' || d_name);

end;
/

declare

e_id EMPLOYEES.EMPLOYEE_ID%type := 100;
e_sal employees.salary%type;
e_did employees.department_id%type;

begin
select salary, department_id into e_sal, e_did from employees where employee_id = e_id;

case e_did

    when 90 then
        update employees set salary = e_sal + 100 where employee_id = e_id;
        DBMS_OUTPUT.PUT_LINE('Salary Updated:' || e_sal);
    
    when 50 then
        update employees set salary = e_sal + 200 where employee_id = e_id;
        DBMS_OUTPUT.PUT_LINE('Salary Updated:' || e_sal);
    
    when 40 then
        update employees set salary = e_sal + 300 where employee_id = e_id;
        DBMS_OUTPUT.PUT_LINE('Salary Updated:' || e_sal);
    
    else
        DBMS_OUTPUT.PUT_LINE('No such record');

end case;

end;
/
