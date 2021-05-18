-- inner join

select * -- emp_no : error 어느쪽에 있는지 명시해줘야해(a.emp_no,b.emp_no)
from employees a, titles b -- alias
where a.emp_no = b.emp_no; -- join condition


-- 예제: employees 테이블과 titles 테이블를 join하여 
--      직원의 이름과 직책을 모두 출력 하세요.
select concat(t1.first_name,' ',t1.last_name) as 'name', t2.title
from employees t1, titles t2
where t1.emp_no = t2.emp_no;

-- 예제10:employees 테이블과 titles 테이블를 join하여
--       직원의 이름과 직책을 출력하되 여성 엔지니어만 출력하세요.
select concat(t1.first_name,' ',t1.last_name) as 'name', t2.title, t1.gender
from employees t1, titles t2
where t1.emp_no = t2.emp_no -- join condition1
and t1.gender='F' -- row-select condition1
and t2.title = 'Engineer'; -- row-select condition2

--
-- ANSI / ISO SQL1999 JOIN 표준 문법
-- 

-- table 작명 규칙 : -s 붙이기 ㄴㄴ
-- pk, fk 작명 규칙: pk는 그냥 no라고 하고 fk에서는 emp_no로 붙여줘야됨

-- 1) natural join
-- 두 테이블에 공통 칼럼이 있으면 별다른 조건없이 묵시적으로 join됨
-- 쓸 일이 없음

-- salaries와 titles를 natural join하게되면 공통칼럼인
-- to_date,from_date,emp_no 가 모두 join되어버려서 의도와 다른 결과가 나올수 있음
select a.first_name, b.title
from employees a
natural join titles b;

-- 예제: 현재 근무하고 있는 직원의 이름과 타이틀, 월급을 출력
select a.first_name, b.title, c.salary
from employees a
join titles b on a.emp_no = b.emp_no
join salaries c on b.emp_no = c.emp_no
where c.to_date like '9999-%';

-- 2)join ~ using
-- 위의 작명규칙을 따르면 쓸 일이 없음
select a.first_name, b.title
from employees a
join titles b using (emp_no);

-- 3)join ~ on
-- outter join 하기에는 좋음
-- left join ~ on, right join ~ on
select a.first_name, b.title
from employees a
join titles b on a.emp_no = b.emp_no;



-- outter join
select * from dept;
-- insert into dept values(null, '총무');
-- insert into dept values(null, '개발');
-- insert into dept values(null, '영업');
-- insert into dept values(null, '기획');

select * from emp;
-- insert into emp values(null, '둘리', 1);
-- insert into emp values(null, '마이콜', 2);
-- insert into emp values(null, '또치', 3);
-- insert into emp values(null, '길동', null);


select a.name as '이름', ifnull(b.name, '없음') as '부서'
from emp a
left join dept b on a.dept_no=b.no; -- 길동

select a.name as '이름', b.name as '부서'
from emp a
right join dept b on a.dept_no=b.no; -- 기획



-- ---
-- 실습문제 1:  현재 회사 상황을 반영한 직원별 근무부서를  
--           사번, 직원 전체이름, 근무부서 형태로 출력해 보세요.
select a.emp_no '사번', concat(a.first_name,' ',last_name) '전체 이름', b.dept_name '근무부서'
from employees a, departments b, dept_emp c
where a.emp_no = c.emp_no
and b.dept_no = c.dept_no
and c.to_date = '9999-01-01';

--  실습문제 2:  현재 회사에서 지급되고 있는 급여체계를 반영한 결과를 출력하세요.
--             사번,  전체이름, 연봉  이런 형태로 출력하세요.  
select a.emp_no '사번', concat(a.first_name,' ',last_name) '전체 이름', b.salary '연봉'
from employees a, salaries b
where a.emp_no = b.emp_no
and b.to_date = '9999-01-01';


