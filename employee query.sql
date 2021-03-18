SELECT sum(salary) as "�޿��Ѿ�",
    avg(salary) as "�޿����",
    max(salary) as "�ִ�޿�",
    min(salary) as "�ּұ޿�" from EMPLOYEE;

select count(*) as "��� ��" from employee;
select count(DISTINCT job) as "���� ���� ����" from employee;
select dno as "�μ� ��ȣ", avg(salary) as "�޿� ���" from employee group by dno;

select dno, job, count(*), sum(salary) from employee group by dno, job order by dno, job;

select job, count(*), sum(salary) from employee group by job order by job;

select dno, max(salary) from employee group by dno having max(salary) >= 3000;

select * from employee, department where employee.dno = department.dno;

select e.eno, e.ename, d.dname, e.dno from employee e, department d where e.dno = d.dno and e.eno = 7788;

select e.eno, e.ename, d.dname, dno from employee e join department d using(dno)
where e.eno=7788;

select e.eno, e.ename, d.dname, e.dno from employee e join department d on e.dno = d.dno where e.eno=7788;

select e.ename, d.dname, e.salary, s.grade from employee e, department d, salgrade s
where e.dno=d.dno and e.salary between losal and hisal;

select ename, dno from employee where dno = (select dno from employee where ename='SCOTT');