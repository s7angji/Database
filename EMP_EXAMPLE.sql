-- 1.ㄹ. 데이터를 제외한 테이블 구조 복사
-- create table dept_copy as select * from department where 0 = 1;
-- create table emp_copy as select * from employee where 0 = 1;





-- 2. 데이터 추가
insert into dept_copy values(10, 'ACCOUNTING', 'NEW YORK');
insert into dept_copy (dno, loc, dname) values(20, 'DALLAS', 'RESEARCH');
-- 날짜 데이터 입력
insert into emp_copy values(7369, 'SMITH', 'CLERK', 7902, TO_DATE('17-12-1980', 'dd-mm-yyyy'), 800, NULL, 20);
-- 다른 테이블에서 데이터 복사해서 넣기
insert into dept_copy select * from department;
-- 시퀀스를 이용한 ID 자동 증가
-- 1> 시퀀스 생성
create sequence seq
    start with 1
    increment by 1
    nomaxvalue
    nominvalue;
-- 2> 테이블 생성
create table seq_test(
    id number primary key,
    title varchar2(20)
);
-- 3> 데이터 추가
insert into seq_test values(seq.nextval, '타이틀1');
insert into seq_test values(seq.nextval, '타이틀2');
-- 4> 사용중인 시퀀스 조회
select * from user_sequences;
-- 5> 시퀀스 삭제
drop sequence seq;





-- 3. 데이터 수정
update dept_copy set dname = 'PROGRAMMING' where dno = 10;
update dept_copy set dname = 'HR';
update dept_copy set dname = 'PROGRAMMING', loc = 'SEOUL' where dno = 10;
-- 10번 부서의 지역명을 20번 부서의 지역명으로 변경
update dept_copy set loc = (select loc from dept_copy where dno = 20) where dno = 10;




-- 4. 데이터 삭제
delete dept_copy where dno = 10;
-- sales부서에 근무하는 사원 모두 삭제
delete emp_copy where dno = (select dno from dept_copy where dname = 'SALES');





-- 5. 데이터 검색
-- ㄱ. 숫자 데이터 검색
select * from employee where dno=10;
-- ㄴ. 문자 데이터 검색
select * from employee where ename='SCOTT';
-- ㄷ. 날짜 데이터 검색
select * from employee where hiredate <= '1981/01/01';
-- ㄹ. 논리 연산자 검색
select * from employee where dno=10 and job='MANAGER';
select * from employee where dno=10 or job='MANAGER';
select * from employee where not dno=10;
-- 1000과 1500 사이의 값 검색
select * from employee where salary between 1000 and 1500;
-- 300, 500, 1400 이산적인 값 검색
select * from employee where commission in(300, 500, 1400);
-- 'F'로 시작하는 이름을 가진 사원 검색
select * from employee where ename like 'F%';
-- _는 한 문자에 대한 wildcard 역할. '_A'는 A글자 앞에 1자만 아무것이나 올 수 있음.
select * from employee where ename like '_A%';
-- NULL 값 검색
select * from employee where commission is null;
select * from employee where commission is not null;
-- 오름차순, 내림차순 검색(디폴트는 오름차순, asc 생략 가능)
select * from employee order by salary asc;
select * from employee order by salary desc;
select * from employee order by salary desc, ename asc;
-- 그룹 함수
select sum(salary) as "급여총액", avg(salary) as "급여평균", max(salary) as "최대급여", min(salary) as "최소급여" from employee;
-- 테이블 행 갯수
select count(*) as "사원의 수" from employee;
-- 중복되지 않는 job 갯수
select count(distinct job) as "직업 종류의 개수" from employee;
-- 특정 컬럼을 기준으로 그룹별로 나눔
select dno as "부서 번호", avg(salary) as "급여 평균" from employee group by dno;
-- 다중 컬럼을 이용한 그룹별 검색
select dno, job, count(*), sum(salary) from employee group by dno, job order by dno, job;
-- 그룹 결과 제한
select dno, max(salary) from employee group by dno having max(salary) >= 3000;
-- 현재 근무일수
-- ROUND - 반올림 처리
select ROUND(SYSDATE - HIREDATE) as "근무일수" from employee;
-- 각 사원들이 근무한 개월 수
-- TRUNC - 날짜, 숫자를 자름
-- MONTHS_BETWEEN(date1, date2) - date1 과 date2 간의 개월 수 계산
select ename, SYSDATE, hiredate, TRUNC(MONTHS_BETWEEN(SYSDATE, hiredate)) from employee;
select ename, SYSDATE, hiredate, ROUND(MONTHS_BETWEEN(SYSDATE, hiredate)) from employee;
-- 입사한지 480개월이 지난 사원
-- ADD_MONTHS(date, n) - date에 n개월을 더함
select ename, hiredate, ADD_MONTHS(hiredate, 6) from employee;
select ename, hiredate, ADD_MONTHS(hiredate, 6), TRUNC(MONTHS_BETWEEN(SYSDATE, hiredate)) as "근무월수"
from employee where SYSDATE > ADD_MONTHS(hiredate, 480);
-- 날짜 표시
-- TO_CHAR - 날짜, 숫자를 문자로 변환
select ename, hiredate, TO_CHAR(hiredate, 'yy-mm'), TO_CHAR(hiredate, 'yyyy/mm/dd day') from employee;
-- 현재 날짜, 시간
-- DUAL - 간단하게 함수를 이용해서 계산 결과값을 확인할 때 사용하는 단순 테이블(오라클 자체 제공)
select TO_CHAR(sysdate, 'yyyy/mm/dd, hh24:mi:ss') from dual;
-- 통화 기호
-- L - 지역별 통화 기호
-- 0 - 자리수가 맞지 않으면 '0'을 채움
-- 9 - 자리수가 맞지 않으면 빈자리 무시.
select ename, TO_CHAR(salary, '999,999L') from employee;
select SYSDATE - HIREDATE as "근무일수" from employee;
select TO_CHAR(SYSDATE - HIREDATE, '99999.9999') as "근무일수" from employee;
-- 1981년 2월 20일 입사한 사원 검색
select ename, hiredate from employee where hiredate=TO_DATE(19810220, 'yyyymmdd');
select ename, hiredate from employee where hiredate=TO_DATE('0220~~~1981', 'mmdd~~~yyyy');
-- CASE를 사용하여 이름, 부서명 출력
select ename, dno,
    case
        when dno = 10 then 'ACCOUNTING'
        when dno = 20 then 'RESEARCH'
        when dno = 30 then 'SALES'
        when dno = 40 then 'OPERATIONS'
        else 'DEFAULT'
    end as "부서명"
from employee order by dno;
-- DECODE(표현식, 조건n, 결과n, ... 기본결과)
-- 직급이 'ANALYST' 사원은 200, 'SALESMAN' 사원은 180, 'MANAGER' 사원은 150, 'CLERK' 사원은 100 보너스 지급
select eno, ename, job, salary, DECODE(job, 'ANALYST', salary + 200,
                                    'SALESMAN', salary + 180,
                                    'MANAGER', salary + 150,
                                    'CLERK', salary + 100,
                                    salary) as "보너스 지급" from employee;
-- 부서명, 지역명, 사원수, 모든 사원의 평균 급여 출력
select decode(dno, 10, 'ACCOUNTING',
                    20, 'RESEARCH',
                    30, 'SALES',
                    40, 'OPERATIONS') as "부서명",
        decode(dno, 10, 'NEW YORK',
                    20, 'DALLSAS',
                    30, 'CHICAGO',
                    40, 'BOSTON') as "지역",
count(*) as "사원수", round(avg(salary)) as "평균급여" from employee group by dno;
-- join 테이블 별칭 사용
select e.eno, e.ename, d.dname, e.dno from employee e, department d where e.dno = d.dno and e.eno=7788;
-- using 사용 - inner join
select e.eno, e.ename, d.dname, dno from employee e join department d using(dno) where e.eno=7788;
-- on 사용 - inner join
select e.eno, e.ename, d.dname, e.dno from employee e join department d on e.dno=d.dno where e.eno=7788;
-- 3개의 테이블 join
select e.ename, d.dname, e.salary, s.grade from employee e, department d, salgrade s
where e.dno = d.dno and salary between losal and hisal;
-- natural join - 자동으로 공통 칼럼을 조사후에 조인 처리
select e.eno, e.ename, d.dname, dno from employee e natural join department d where e.eno=7788;
-- self join - 자신의 테이블을 조인
select e.ename as "사원", m.ename as "직속상관" from employee e, employee m where e.manager=m.eno;

select e.eno as "사원번호", e.ename as "사원이름", e.manager as "직속상관번호", m.ename as "직속상관이름"
from (select eno, ename, manager from employee)e, (select eno, ename from employee)m
where m.eno=e.manager;

-- left outer join - 왼쪽 테이블에 NULL값 존재
select e.ename as "사원", m.ename as "직속상관"
from employee e left outer join employee m on e.manager=m.eno;
select e.ename as "사원", m.ename as "직속상관"
from employee m right outer join employee e on e.manager=m.eno;

-- 이름에 'A'가 포함된 모든 사원과 부서
-- natural join
select e.ename, d.dname from employee e natural join department d
where dno in(10, 20, 30, 40) and e.ename like '%A%';
-- equi join(오라클 9i 이전 방식)
select e.ename, d.dname from employee e, department d
where e.dno=d.dno and e.ename like '%A%';
-- 서버 쿼리
select ename, dno from employee where dno = (select dno from employee where ename='SCOTT');
-- 부하직원이 없는 사원
select ename from employee where eno in (select eno from employee where manager is null);
select ename from employee where manager is null;
-- RESEARCH에서 근무하는 사원
select dno, ename, job from employee
where dno=(select dno from department where dname='RESEARCH');
-- 최소 급여를 받는 사원번호와 이름 출력
select eno, ename from employee where salary in(select min(salary) from employee group by dno);
-- 직급이 salesman가 아니면서 직급이 salesman인 사원보다 급여가 적은 사원을 모두 출력
select eno, ename, job, salary from employee
    where salary < all(select salary from employee where job='SALESMAN') and job <> 'SALESMAN';
-- 직급이 SALESMAN가 아니면서 직급이 SALESMAN인 사원보다 급여가 적은 사원을 모두 출력
select eno, ename, job, salary from employee
    where salary < any(select salary from employee where job='SALESMAN') and job <> 'SALESMAN';
-- 기존 테이블 구조, 데이터 복사
-- create table dept_copy as select * from department;
-- create table emp_copy as select * from employee;

-- dept_copy 모든 데이터 삭제
-- delete from dept_copy;
-- department의 모든 데이터를 dept_copy 추가
insert into dept_copy select * from department;
-- 10번 부서의 지역명을 20번 부서의 지역명으로 변경
update dept_copy set loc=(select loc from dept_copy where dno=20) where dno=10;
-- 10번 부서의 부서명과 지역명을 30번 부서의 부서명과 지역명으로 변경
update dept_copy set dname=(select dname from dept_copy where dno=30),
                    loc=(select loc from dept_copy where dno=30) where dno=10;
update dept_copy set (dname, loc)=(select dname, loc from dept_copy where dno=20) where dno=10;
-- 영업부 사원 모두 삭제
delete emp_copy where dno=(select dno from department where dname='SALES');
-- View - 가상 테이블(DB보안 가능)
create or replace view v_emp(사원, 사원이름, 부서번호, 담당업무) as select eno, ename, dno, job
from employee where job like 'SALESMAN';
-- view 삭제
-- drop view v_emp;
-- PL/SQL 기초
set serveroutput on
declare
    v_eno number(4);
    v_ename employee.ename%type;
begin
    v_eno:=7788;
    v_ename:='scott';
    dbms_output.put_line('사원번호          사원이름');
    dbms_output.put_line('-------------------------------------');
    dbms_output.put_line(v_eno||'            '||v_ename);
end;
