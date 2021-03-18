-- 1.��. �����͸� ������ ���̺� ���� ����
-- create table dept_copy as select * from department where 0 = 1;
-- create table emp_copy as select * from employee where 0 = 1;





-- 2. ������ �߰�
insert into dept_copy values(10, 'ACCOUNTING', 'NEW YORK');
insert into dept_copy (dno, loc, dname) values(20, 'DALLAS', 'RESEARCH');
-- ��¥ ������ �Է�
insert into emp_copy values(7369, 'SMITH', 'CLERK', 7902, TO_DATE('17-12-1980', 'dd-mm-yyyy'), 800, NULL, 20);
-- �ٸ� ���̺��� ������ �����ؼ� �ֱ�
insert into dept_copy select * from department;
-- �������� �̿��� ID �ڵ� ����
-- 1> ������ ����
create sequence seq
    start with 1
    increment by 1
    nomaxvalue
    nominvalue;
-- 2> ���̺� ����
create table seq_test(
    id number primary key,
    title varchar2(20)
);
-- 3> ������ �߰�
insert into seq_test values(seq.nextval, 'Ÿ��Ʋ1');
insert into seq_test values(seq.nextval, 'Ÿ��Ʋ2');
-- 4> ������� ������ ��ȸ
select * from user_sequences;
-- 5> ������ ����
drop sequence seq;





-- 3. ������ ����
update dept_copy set dname = 'PROGRAMMING' where dno = 10;
update dept_copy set dname = 'HR';
update dept_copy set dname = 'PROGRAMMING', loc = 'SEOUL' where dno = 10;
-- 10�� �μ��� �������� 20�� �μ��� ���������� ����
update dept_copy set loc = (select loc from dept_copy where dno = 20) where dno = 10;




-- 4. ������ ����
delete dept_copy where dno = 10;
-- sales�μ��� �ٹ��ϴ� ��� ��� ����
delete emp_copy where dno = (select dno from dept_copy where dname = 'SALES');





-- 5. ������ �˻�
-- ��. ���� ������ �˻�
select * from employee where dno=10;
-- ��. ���� ������ �˻�
select * from employee where ename='SCOTT';
-- ��. ��¥ ������ �˻�
select * from employee where hiredate <= '1981/01/01';
-- ��. �� ������ �˻�
select * from employee where dno=10 and job='MANAGER';
select * from employee where dno=10 or job='MANAGER';
select * from employee where not dno=10;
-- 1000�� 1500 ������ �� �˻�
select * from employee where salary between 1000 and 1500;
-- 300, 500, 1400 �̻����� �� �˻�
select * from employee where commission in(300, 500, 1400);
-- 'F'�� �����ϴ� �̸��� ���� ��� �˻�
select * from employee where ename like 'F%';
-- _�� �� ���ڿ� ���� wildcard ����. '_A'�� A���� �տ� 1�ڸ� �ƹ����̳� �� �� ����.
select * from employee where ename like '_A%';
-- NULL �� �˻�
select * from employee where commission is null;
select * from employee where commission is not null;
-- ��������, �������� �˻�(����Ʈ�� ��������, asc ���� ����)
select * from employee order by salary asc;
select * from employee order by salary desc;
select * from employee order by salary desc, ename asc;
-- �׷� �Լ�
select sum(salary) as "�޿��Ѿ�", avg(salary) as "�޿����", max(salary) as "�ִ�޿�", min(salary) as "�ּұ޿�" from employee;
-- ���̺� �� ����
select count(*) as "����� ��" from employee;
-- �ߺ����� �ʴ� job ����
select count(distinct job) as "���� ������ ����" from employee;
-- Ư�� �÷��� �������� �׷캰�� ����
select dno as "�μ� ��ȣ", avg(salary) as "�޿� ���" from employee group by dno;
-- ���� �÷��� �̿��� �׷캰 �˻�
select dno, job, count(*), sum(salary) from employee group by dno, job order by dno, job;
-- �׷� ��� ����
select dno, max(salary) from employee group by dno having max(salary) >= 3000;
-- ���� �ٹ��ϼ�
-- ROUND - �ݿø� ó��
select ROUND(SYSDATE - HIREDATE) as "�ٹ��ϼ�" from employee;
-- �� ������� �ٹ��� ���� ��
-- TRUNC - ��¥, ���ڸ� �ڸ�
-- MONTHS_BETWEEN(date1, date2) - date1 �� date2 ���� ���� �� ���
select ename, SYSDATE, hiredate, TRUNC(MONTHS_BETWEEN(SYSDATE, hiredate)) from employee;
select ename, SYSDATE, hiredate, ROUND(MONTHS_BETWEEN(SYSDATE, hiredate)) from employee;
-- �Ի����� 480������ ���� ���
-- ADD_MONTHS(date, n) - date�� n������ ����
select ename, hiredate, ADD_MONTHS(hiredate, 6) from employee;
select ename, hiredate, ADD_MONTHS(hiredate, 6), TRUNC(MONTHS_BETWEEN(SYSDATE, hiredate)) as "�ٹ�����"
from employee where SYSDATE > ADD_MONTHS(hiredate, 480);
-- ��¥ ǥ��
-- TO_CHAR - ��¥, ���ڸ� ���ڷ� ��ȯ
select ename, hiredate, TO_CHAR(hiredate, 'yy-mm'), TO_CHAR(hiredate, 'yyyy/mm/dd day') from employee;
-- ���� ��¥, �ð�
-- DUAL - �����ϰ� �Լ��� �̿��ؼ� ��� ������� Ȯ���� �� ����ϴ� �ܼ� ���̺�(����Ŭ ��ü ����)
select TO_CHAR(sysdate, 'yyyy/mm/dd, hh24:mi:ss') from dual;
-- ��ȭ ��ȣ
-- L - ������ ��ȭ ��ȣ
-- 0 - �ڸ����� ���� ������ '0'�� ä��
-- 9 - �ڸ����� ���� ������ ���ڸ� ����.
select ename, TO_CHAR(salary, '999,999L') from employee;
select SYSDATE - HIREDATE as "�ٹ��ϼ�" from employee;
select TO_CHAR(SYSDATE - HIREDATE, '99999.9999') as "�ٹ��ϼ�" from employee;
-- 1981�� 2�� 20�� �Ի��� ��� �˻�
select ename, hiredate from employee where hiredate=TO_DATE(19810220, 'yyyymmdd');
select ename, hiredate from employee where hiredate=TO_DATE('0220~~~1981', 'mmdd~~~yyyy');
-- CASE�� ����Ͽ� �̸�, �μ��� ���
select ename, dno,
    case
        when dno = 10 then 'ACCOUNTING'
        when dno = 20 then 'RESEARCH'
        when dno = 30 then 'SALES'
        when dno = 40 then 'OPERATIONS'
        else 'DEFAULT'
    end as "�μ���"
from employee order by dno;
-- DECODE(ǥ����, ����n, ���n, ... �⺻���)
-- ������ 'ANALYST' ����� 200, 'SALESMAN' ����� 180, 'MANAGER' ����� 150, 'CLERK' ����� 100 ���ʽ� ����
select eno, ename, job, salary, DECODE(job, 'ANALYST', salary + 200,
                                    'SALESMAN', salary + 180,
                                    'MANAGER', salary + 150,
                                    'CLERK', salary + 100,
                                    salary) as "���ʽ� ����" from employee;
-- �μ���, ������, �����, ��� ����� ��� �޿� ���
select decode(dno, 10, 'ACCOUNTING',
                    20, 'RESEARCH',
                    30, 'SALES',
                    40, 'OPERATIONS') as "�μ���",
        decode(dno, 10, 'NEW YORK',
                    20, 'DALLSAS',
                    30, 'CHICAGO',
                    40, 'BOSTON') as "����",
count(*) as "�����", round(avg(salary)) as "��ձ޿�" from employee group by dno;
-- join ���̺� ��Ī ���
select e.eno, e.ename, d.dname, e.dno from employee e, department d where e.dno = d.dno and e.eno=7788;
-- using ��� - inner join
select e.eno, e.ename, d.dname, dno from employee e join department d using(dno) where e.eno=7788;
-- on ��� - inner join
select e.eno, e.ename, d.dname, e.dno from employee e join department d on e.dno=d.dno where e.eno=7788;
-- 3���� ���̺� join
select e.ename, d.dname, e.salary, s.grade from employee e, department d, salgrade s
where e.dno = d.dno and salary between losal and hisal;
-- natural join - �ڵ����� ���� Į���� �����Ŀ� ���� ó��
select e.eno, e.ename, d.dname, dno from employee e natural join department d where e.eno=7788;
-- self join - �ڽ��� ���̺��� ����
select e.ename as "���", m.ename as "���ӻ��" from employee e, employee m where e.manager=m.eno;

select e.eno as "�����ȣ", e.ename as "����̸�", e.manager as "���ӻ����ȣ", m.ename as "���ӻ���̸�"
from (select eno, ename, manager from employee)e, (select eno, ename from employee)m
where m.eno=e.manager;

-- left outer join - ���� ���̺� NULL�� ����
select e.ename as "���", m.ename as "���ӻ��"
from employee e left outer join employee m on e.manager=m.eno;
select e.ename as "���", m.ename as "���ӻ��"
from employee m right outer join employee e on e.manager=m.eno;

-- �̸��� 'A'�� ���Ե� ��� ����� �μ�
-- natural join
select e.ename, d.dname from employee e natural join department d
where dno in(10, 20, 30, 40) and e.ename like '%A%';
-- equi join(����Ŭ 9i ���� ���)
select e.ename, d.dname from employee e, department d
where e.dno=d.dno and e.ename like '%A%';
-- ���� ����
select ename, dno from employee where dno = (select dno from employee where ename='SCOTT');
-- ���������� ���� ���
select ename from employee where eno in (select eno from employee where manager is null);
select ename from employee where manager is null;
-- RESEARCH���� �ٹ��ϴ� ���
select dno, ename, job from employee
where dno=(select dno from department where dname='RESEARCH');
-- �ּ� �޿��� �޴� �����ȣ�� �̸� ���
select eno, ename from employee where salary in(select min(salary) from employee group by dno);
-- ������ salesman�� �ƴϸ鼭 ������ salesman�� ������� �޿��� ���� ����� ��� ���
select eno, ename, job, salary from employee
    where salary < all(select salary from employee where job='SALESMAN') and job <> 'SALESMAN';
-- ������ SALESMAN�� �ƴϸ鼭 ������ SALESMAN�� ������� �޿��� ���� ����� ��� ���
select eno, ename, job, salary from employee
    where salary < any(select salary from employee where job='SALESMAN') and job <> 'SALESMAN';
-- ���� ���̺� ����, ������ ����
-- create table dept_copy as select * from department;
-- create table emp_copy as select * from employee;

-- dept_copy ��� ������ ����
-- delete from dept_copy;
-- department�� ��� �����͸� dept_copy �߰�
insert into dept_copy select * from department;
-- 10�� �μ��� �������� 20�� �μ��� ���������� ����
update dept_copy set loc=(select loc from dept_copy where dno=20) where dno=10;
-- 10�� �μ��� �μ���� �������� 30�� �μ��� �μ���� ���������� ����
update dept_copy set dname=(select dname from dept_copy where dno=30),
                    loc=(select loc from dept_copy where dno=30) where dno=10;
update dept_copy set (dname, loc)=(select dname, loc from dept_copy where dno=20) where dno=10;
-- ������ ��� ��� ����
delete emp_copy where dno=(select dno from department where dname='SALES');
-- View - ���� ���̺�(DB���� ����)
create or replace view v_emp(���, ����̸�, �μ���ȣ, ������) as select eno, ename, dno, job
from employee where job like 'SALESMAN';
-- view ����
-- drop view v_emp;
-- PL/SQL ����
set serveroutput on
declare
    v_eno number(4);
    v_ename employee.ename%type;
begin
    v_eno:=7788;
    v_ename:='scott';
    dbms_output.put_line('�����ȣ          ����̸�');
    dbms_output.put_line('-------------------------------------');
    dbms_output.put_line(v_eno||'            '||v_ename);
end;
