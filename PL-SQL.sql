select ename from employee where eno
in(select eno from employee where manager is null);

select eno, ename, job, salary from employee
    where salary < all(select salary from employee
    where job='SALESMEN') and job <> 'SALESMEN';

-- create table dept_copy as select * from department;

update dept_copy set loc=(select loc from dept_copy where dno=20)
    where dno=10;

create or REPLACE view v_emp(���, ����̸�, �μ���ȣ, ������)
    as select eno, ename, dno, job
    from employee where job like 'salesman';

-- PL/SQL
set SERVEROUTPUT on
declare
    v_eno number(4); -- ���� ����
    v_ename employee.ename%type;

begin
    v_eno := 7788; -- �ʱ�ȭ
    v_ename := 'scott';
    dbms_output.put_line('�����ȣ          ����̸�');
    dbms_output.put_line('-------------------------');
    dbms_output.put_line(v_eno||'           '||v_ename);
end;
