-- 서브쿼리(SUBQUERY) SQL 문제입니다.

-- 문제1.
-- 현재 평균 연봉보다 많은 월급을 받는 직원은 몇 명이나 있습니까?
select count(*)
from salaries
where to_date ='9999-01-01' 
and salary > (select avg(salary)
				from salaries
				where to_date = '9999-01-01');


-- 문제2. 
-- 현재, 각 부서별로 최고의 급여를 받는 사원의 사번, 이름, 부서 연봉을 조회하세요. 단 조회결과는 연봉의 내림차순으로 정렬되어 나타나야 합니다. 
select t1.emp_no '사번', t1.first_name '이름', t3.dept_no '부서', t2.salary '연봉'
from employees t1, salaries t2, dept_emp t3
where  t1.emp_no = t2.emp_no
and t2.emp_no = t3.emp_no
and t2.to_date = '9999-01-01'
and t3.to_date = '9999-01-01'
and (t2.salary, t3.dept_no) in (select max(t1.salary) 'max_salary', t2.dept_no
						   from salaries t1, dept_emp t2
						  where t1.emp_no = t2.emp_no
							and t1.to_date = '9999-01-01'
							and t2.to_date = '9999-01-01'
					   group by t2.dept_no)
order by t2.salary desc;

-- 문제3.
-- 현재, 자신의 부서 평균 급여보다 연봉(salary)이 많은 사원의 사번, 이름과 연봉을 조회하세요 
select t2.emp_no '사번', t2.first_name '이름', t1.salary '연봉'
from salaries t1, employees t2, dept_emp t3, (select t2.dept_no, avg(t1.salary) as 'avg_salary'
											from salaries t1, dept_emp t2
											where t1.emp_no = t2.emp_no
											and t1.to_date='9999-01-01'
											and t2.to_date='9999-01-01'
											group by t2.dept_no) t4
where t1.emp_no = t2.emp_no
and t2.emp_no = t3.emp_no
and t3.dept_no = t4.dept_no
and t1.to_date='9999-01-01'
and t3.to_date='9999-01-01'
and t1.salary > t4.avg_salary;

-- 문제4.
-- 현재, 사원들의 사번, 이름, 매니저 이름, 부서 이름으로 출력해 보세요.

select t1.emp_no '사번', t1.first_name '이름', t4.manager_name, t3.dept_name '부서 이름' 
from employees t1, dept_emp t2, departments t3, (select t2.first_name 'manager_name', t1.emp_no, t1.dept_no
												from dept_manager t1, employees t2
												where t1.emp_no = t2.emp_no
												and t1.to_date = '9999-01-01')t4
where t1.emp_no = t2.emp_no
and t2.dept_no = t3.dept_no
and t3.dept_no = t4.dept_no
and t2.to_date = '9999-01-01';

-- 문제5.
-- 현재, 평균연봉이 가장 높은 부서의 사원들의 사번, 이름, 직책, 연봉을 조회하고 연봉 순으로 출력하세요.
select t1.emp_no '사번', t1.first_name '이름', t2.title '직책', t3.salary '연봉'
from employees t1, titles t2, salaries t3, dept_emp t4, (select t3.dept_no, max(t3.avg_salary) 'max_avg_salary'
														from (select t2.dept_no, avg(t1.salary) 'avg_salary'
																from salaries t1, dept_emp t2
																where t1.emp_no = t2.emp_no
																and t1.to_date = '9999-01-01'
																and t2.to_date = '9999-01-01'
																group by t2.dept_no) t3)t5
where t1.emp_no = t2.emp_no
and t2.emp_no = t3.emp_no
and t1.emp_no = t4.emp_no
and t4.dept_no = t5.dept_no
and t2.to_date = '9999-01-01'
and t3.to_date = '9999-01-01'
and t4.to_date = '9999-01-01'
order by t3.salary desc;

-- 문제6.
-- 평균 연봉이 가장 높은 부서는? 
select t1.dept_name '연봉이 가장 높은 부서'
from departments t1, (select t3.dept_no, max(t3.avg_salary) 'max_avg_salary'
						from (select t2.dept_no, avg(t1.salary) 'avg_salary'
								from salaries t1, dept_emp t2
								where t1.emp_no = t2.emp_no
								group by t2.dept_no) t3) t2
where t1.dept_no = t2.dept_no;

-- 문제7.
-- 평균 연봉이 가장 높은 직책?
select t1.title '가장 연봉이 높은 직책', max(t1.avg_salary) 'max_avg_salary'
from (select t2.title, avg(t1.salary) 'avg_salary'
		from salaries t1, titles t2
		where t1.emp_no = t2.emp_no
		group by t2.title
        order by avg_salary desc) t1;

-- 문제8.
-- 현재 자신의 매니저보다 높은 연봉을 받고 있는 직원은?
-- 부서이름, 사원이름, 연봉, 매니저 이름, 메니저 연봉 순으로 출력합니다.
-- deptno를 고정시키고, salary값을 비교한 후에 출력
select t1.dept_name '부서이름', t2.first_name '사원이름', t3.salary '연봉', t5.first_name '매니저 이름', t5.salary '매니저 연봉'
from departments t1, employees t2, salaries t3, dept_emp t4, (select t1.salary, t3.first_name, t2.dept_no
																from salaries t1, dept_manager t2, employees t3
																where t1.emp_no = t2.emp_no
                                                                and t1.emp_no = t3.emp_no
																and t2.to_date = '9999-01-01'
																and t1.to_date = '9999-01-01') t5
where t1.dept_no = t4.dept_no
and t2.emp_no = t3.emp_no
and t3.emp_no = t4.emp_no
and t4.dept_no = t5.dept_no
and t3.to_date = '9999-01-01'
and t4.to_date = '9999-01-01'
and t3.salary > t5.salary;


