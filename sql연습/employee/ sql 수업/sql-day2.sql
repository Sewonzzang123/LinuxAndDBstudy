-- error 1046 대비
use employees;

-- select 연습
-- 예제 : deaprtments 테이블의 모든 데이터를 출력.
select * from departments;
select dept_no, dept_name from departments;

select * from employees;
-- 예제 : employees 테이블에서 직원의 이름,  성별, 입사일을 출력
select first_name, gender, hire_date from employees;

-- 예제 : (alias)employees 테이블에서 직원의 이름,  성별, 입사일을 출력
select first_name as '이름', gender as 성별, hire_date '입사일' 
from employees;

-- concat, alias(as, 생략 가능)
-- 예제 : employees 테이블에서 직원의 전체이름,  성별, 입사일을 출력
select concat(first_name,' ',last_name) as full_name,gender,hire_date from employees;
select concat(first_name,' ',last_name) full_name,gender,hire_date from employees;
select concat(first_name,' ',last_name) as '전체 이름',gender as 성별,hire_date as 입사일 from employees;

-- distinct
-- 예제 : titles 테이블에서 직급은 어떤 것들이 있는지 직급이름을 한 번씩만 출력
select distinct(title) from titles;

-- where
-- 예제 : employees 테이블에서 1991년 이전에 입사한 직원의 이름, 
--       성별, 입사일을 출력
select  concat(first_name,' ',last_name) as 이름, gender '성별',hire_date '입사일'
from employees
where hire_date<'1992-01-01';

-- where 절 #2:논리연산자
-- 예제 : employees 테이블에서 1989년 이전에 입사한 여직원의 이름, 
--       입사일을 출력
select first_name '이름', hire_date '입사일'
from employees
where gender = 'F'
and hire_date<'1990-01-01';
    
-- IN
-- 예제 : dept_emp 테이블에서 부서 번호가 d005나 d009에 속한 사원의
--       사번, 부서번호 출력
select emp_no '사번', dept_no '부서번호'
from dept_emp
-- where dept_no ='doo5' or dept_no='d009';
where dept_no in('d005','d009');

-- LIKE
--  와일드 카드를 사용하여 특정 문자를 포함한 값에 대한 조건을 처리
--  % 는 0에서부터 여러 개의 문자열을 나타냄
-- _ 는 단 하나의 문자를 나타내는 와일드 카드
-- 예제 : employees 테이블에서 1989년에 입사한 직원의 이름, 
--       입사일을 출력  
select  first_name '이름', hire_date '입사일'
from employees
where hire_date like '1989%';
-- where '1988-12-31' < hire_date and hire_date< '1990-01-01';
-- where hire_date between '1988-12-31' and '1990-01-01';

-- ORDER BY절
-- 예제 : 남자직원 employees 테이블에서 직원의 전체이름,  성별, 입사일을  입사일 순으로 출력
select concat(first_name,' ',last_name) '이름', gender '성별', hire_date '입사일'
from employees
where gender = 'M'
order by hire_date asc;

-- 예제 : salaries 테이블에서 2001년 월급을 가장 높은순으로 사번, 
--        월급순으로 출력
select emp_no '사번', salary '월급'
from salaries 
where from_date like '2001-%'
and to_date like '2001-%'
order by salary desc;


-- 직원들의 월급을 사번, 월급 순으로 사번, 월급으로 출력
select emp_no, salary
from salaries
order by emp_no asc , salary desc;

-- 




