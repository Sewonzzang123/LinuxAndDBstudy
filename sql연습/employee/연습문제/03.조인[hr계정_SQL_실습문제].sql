-- 테이블간 조인(JOIN) SQL 문제입니다.

-- 문제 1. 
-- 현재 급여가 많은 직원부터 직원의 사번, 이름, 그리고 연봉을 출력 하시오.
select t1.emp_no '사번', t1.first_name '이름', t2.salary '연봉'
from employees t1, salaries t2
where t1.emp_no=t2.emp_no
and t2.to_date = '9999-01-01'
order by t2.salary desc;

-- 문제2.
-- 전체 사원의 사번, 이름, 현재 직책을 이름 순서로 출력하세요.
select t1.emp_no '사번', t1.first_name '이름', t2.title '직책'
from employees t1, titles t2
where t1.emp_no = t2.emp_no
and t2.to_date = '9999-01-01'
order by t1.first_name;

-- 문제3.
-- 전체 사원의 사번, 이름, 현재 부서를 이름 순서로 출력하세요..
select t1.emp_no '사번', t1.first_name '이름', t3.dept_name '현재 부서'
from employees t1, dept_emp t2, departments t3
where t1.emp_no = t2.emp_no
and t2.dept_no = t3.dept_no
and t2.to_date = '9999-01-01';

-- 문제4.
-- 전체 사원의 사번, 이름, 연봉, 직책, 부서를 모두 이름 순서로 출력합니다.
select t3.emp_no '사번', t3.first_name '이름', t4.salary '연봉', t5.title '직책', t1.dept_name '부서'
from departments t1, dept_emp t2, employees t3, salaries t4, titles t5
where t1.dept_no = t2.dept_no
and t2.emp_no = t3.emp_no 
and t3.emp_no = t4.emp_no
and t4.emp_no = t5.emp_no
and t4.to_date = '9999-01-01'
and t5.to_date = '9999-01-01'
and t2.to_date = '9999-01-01'
order by t3.first_name asc;

-- 문제5.
-- ‘Technique Leader’의 직책으로 과거에 근무한 적이 있는 모든 사원의 사번과 이름을 출력하세요. 
-- (현재 ‘Technique Leader’의 직책(으로 근무하는 사원은 고려하지 않습니다.) 
-- 이름은 first_name과 last_name을 합쳐 출력 합니다.
select t1.emp_no '사번' , concat(t1.first_name, ' ', t1.last_name) '이름'
from employees t1, titles t2
where t1.emp_no =t2.emp_no
and t2.title ='Technique Leader'
and t2.to_date not like '9999-01-01';

-- 문제6.
-- 직원 이름(last_name) 중에서 S(대문자)로 시작하는 직원들의 이름, 부서명, 직책을 조회하세요.
select t1.last_name, t3.dept_name, t4.title
from employees t1, dept_emp t2, departments t3, titles t4
where t1.emp_no = t2.emp_no 
and t2.dept_no = t3.dept_no
and t1.emp_no = t4.emp_no
and t1.last_name like 'S%';

-- 문제7.
-- 현재, 직책이 Engineer인 사원 중에서 현재 급여가 40000 이상인 사원을 급여가 큰 순서대로 출력하세요.
select t2.salary, t3.first_name
from titles t1, salaries t2, employees t3
where t1.emp_no = t2.emp_no 
and t2.emp_no = t3.emp_no
and t1.to_date = '9999-01-01'
and t2.to_date = '9999-01-01'
and t1.title = 'Engineer'
and t2.salary >= 40000
order by t2.salary desc;

-- 문제8.
-- 현재 급여가  50000이 넘는 직책을 직책, 급여로 급여가 큰 순서대로 출력하시오
select t2.title, t1.salary
from salaries t1, titles t2
where t1.emp_no = t2.emp_no
and t1.salary > 50000
and t1.to_date = '9999-01-01'
and t2.to_date = '9999-01-01'
order by t1.salary desc;

-- 문제9.
-- 현재, 부서별 평균 연봉을 연봉이 큰 부서 순서대로 출력하세요.
select avg(t1.salary) , t3.dept_name
from salaries t1, dept_emp t2, departments t3
where t1.emp_no = t2.emp_no
and t2.dept_no = t3.dept_no
and t1.to_date = '9999-01-01'
and t2.to_date = '9999-01-01'
group by t2.dept_no
order by avg(t1.salary) desc;

-- 문제10.
-- 현재, 직책별 평균 연봉을 연봉이 큰 직책 순서대로 출력하세요.
select t2.title, avg(t1.salary)
from salaries t1, titles t2
where t1.emp_no = t2.emp_no
-- and t1.to_date = '9999-01-01'
-- and t2.to_date = '9999-01-01'
group by t2.title
order by avg(t1.salary) desc;