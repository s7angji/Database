SELECT sum(salary) as "급여총액",
    avg(salary) as "급여평균",
    max(salary) as "최대급여",
    min(salary) as "최소급여" from EMPLOYEE;

select count(*) as "사원 수" from employee;
select count(DISTINCT job) as "직업 종류 개수" from employee;
select dno as "부서 번호", avg(salary) as "급여 평균" from employee group by dno;

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