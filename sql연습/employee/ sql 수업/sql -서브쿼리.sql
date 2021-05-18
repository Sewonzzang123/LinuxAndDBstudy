-- subquery

-- 1) from절의 서브쿼리

	select now() as n, sysdate() as b, 3+1 as c;
    
    select s.n,s.b,s.c
    from (select now() as n, sysdate() as b, 3+1 as c) s;
    
    
-- 2) where절의 서브쿼리
--     예제:  현재 Fai Bale이 근무하는 부서에서 근무하는 직원의 사번, 전체 이름을 
--              출력해보세요. 

select b.dept_no 'dept_no'
from employees a, dept_emp b
where a.emp_no = b.emp_no
and b.to_date = '9999-01-01'
and concat(a.first_name,' ',a.last_name) = 'Fai Bale';

select a.emp_no '사번', a.first_name '이름'
from employees a, dept_emp b
where a.emp_no =  b.emp_no
and b.to_date = '9999-01-01'
and b.dept_no = (select b.dept_no
					from employees a, dept_emp b
					where a.emp_no = b.emp_no
					and b.to_date = '9999-01-01'
					and concat(a.first_name,' ',a.last_name) = 'Fai Bale');

-- 2-1) where절의 서브쿼리 : 단일행
-- 단일행 연산자 : =, >, <, >=, <=, <>, !=

-- 실습문제 1:   현재 전체사원의 평균 연봉보다 적은 급여를 받는  
--                           사원의  이름, 급여를 나타내세요.

select a.first_name '이름', b.salary '급여'
from employees a, salaries b
where a.emp_no = b.emp_no
and b.to_date= '9999-01-01'
and b.salary < (select avg(b.salary)
				from employees a, salaries b
				where a.emp_no = b.emp_no
				and b.to_date = '9999-01-01');
-- order by b.salary desc; -- 검증

select avg(b.salary)
from employees a, salaries b
where a.emp_no = b.emp_no
and b.to_date = '9999-01-01';

-- 실습문제 2:   현재 가장적은 평균 급여를 받고 있는 직책에해서  
--             평균 급여를 구하세요  
-- 1.직책별 평균 급여
-- 2.가장 적은 평균 급여
-- sol1 : having절에 서브쿼리
select c.title as 'title' , min(c.avgsalary) 'minavgsalary'
from (	select a.title as 'title', avg(salary) as 'avgsalary'
		from titles a, salaries b
		where a.emp_no = b.emp_no
		and b.to_date = '9999-01-01'
        and a.to_date = '9999-01-01'
        group by a.title) c;
	
    select avg(a.salary)
    from salaries a,titles b, (select c.title as 'title' , min(c.avgsalary) 'minavgsalary'
									from (	select a.title as 'title', avg(salary) as 'avgsalary'
									from titles a, salaries b
									where a.emp_no = b.emp_no
									and b.to_date = '9999-01-01'
                                    and a.to_date = '9999-01-01'
									group by a.title) c)c
    where a.emp_no = b.emp_no
    and b.title = c.title
    and b.to_date ='9999-01-01'
	and a.to_date ='9999-01-01';
  -- sol2  
    select min(c.avgsalary) 'minavgsalary'
	from (	select a.title as 'title', avg(salary) as 'avgsalary'
			from titles a, salaries b
			where a.emp_no = b.emp_no
			and b.to_date = '9999-01-01'
			and a.to_date = '9999-01-01'
			group by a.title) c;
   
   -- sol3 
    select a.title as 'title', avg(salary) as 'avgsalary'
		from titles a, salaries b
		where a.emp_no = b.emp_no
		and b.to_date = '9999-01-01'
        and a.to_date = '9999-01-01'
        group by a.title
        order by avgsalary asc
        limit 0,1 ; -- top-k
    
-- 2-2) where 절의 서브쿼리: 복수행
-- 		복수행 연산자 : in, not in, any, all

-- any 사용법
-- 1. =any : in과 동일
-- 2. >any, >=any : 최소값
-- 3. <any, <=any : 최대값
-- 4. <>any : not in

-- all 사용법
-- 1. =all
-- 2. >all, >=all : 최대값
-- 3. <all, <=all : 최소값

-- 예제 : 현재 급여가 50000이상인 직원 이름 출력
-- sol1
select a.first_name, b.salary
from employees a, salaries b
where a.emp_no = b.emp_no
and b.to_date='9999-01-01'
and (a.emp_no,b.salary) in (select emp_no, salary
						from salaries
						where to_date = '9999-01-01'
						and salary >50000)
order by b.salary asc;

-- sol2 in = =any
select a.first_name, b.salary
from employees a, salaries b
where a.emp_no = b.emp_no
and b.to_date='9999-01-01'
and (a.emp_no,b.salary) =any (select emp_no, salary
						from salaries
						where to_date = '9999-01-01'
						and salary >50000)
order by b.salary asc;

-- sol2
select a.first_name, b.salary
from employees a, salaries b
where a.emp_no = b.emp_no
and b.to_date='9999-01-01'
and b.salary>50000
order by b.salary asc;

-- 예제: 각 부서별로 최고 월급을 받는 직원의 이름과 월급을 출력
-- sol1 : where절 subquery =any
select a.first_name , b.salary, c.dept_no
from employees a, salaries b, dept_emp c
where a.emp_no = b.emp_no
and b.emp_no = c.emp_no
and b.to_date = '9999-01-01'
and c.to_date = '9999-01-01'
and (b.salary,c.dept_no) =any (select max(b.salary) 'max_salary', c.dept_no 'dept_no'
								from  salaries b, dept_emp c
								where b.emp_no = c.emp_no
								and b.to_date = '9999-01-01'
								and c.to_date = '9999-01-01'
								group by c.dept_no)
order by c.dept_no;

-- sol2 : from subquery
select a.first_name , b.salary, c.dept_no
from employees a, salaries b, dept_emp c, (select max(b.salary) 'max_salary', c.dept_no 'dept_no'
											from  salaries b, dept_emp c
											where b.emp_no = c.emp_no
											and b.to_date = '9999-01-01'
											and c.to_date = '9999-01-01'
											group by c.dept_no)d
where a.emp_no = b.emp_no
and b.emp_no = c.emp_no
and b.salary = d.max_salary
and c.dept_no = d.dept_no
and b.to_date = '9999-01-01'
and c.to_date = '9999-01-01';
