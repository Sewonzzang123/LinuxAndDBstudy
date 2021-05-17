-- 집계쿼리 : select 절에 그룹함수가 적용된 경우

select avg(salary) 
from salaries 
where emp_no='10060';

-- select 절에 그룹 함수가 있는 경우, 어떤 컬럼도 select절에 올 수 없다.
-- emp_no는 아무런 의미가 없다.
-- error!
select emp_no, avg(salary)
from salaries;

-- query 실행 순서
-- (1) from : 접근 테이블 확인
-- (2) where : 조건에 맞는 row 선택 -> 임시 테이블 생성
-- (3) 집계
-- (4) projection

-- group by 에 참여 하고 있는 칼럼은 projection 가능
-- (select 절에 올 수 있다.)
select emp_no,avg(salary)
from salaries
-- where to_date ='9999-01-01' -- 현재
group by emp_no;

-- having
-- 집계가 끝난 곳에서 row를 다시 골라내야 할 때 사용
-- 이미 where절은 시행이 되었기 때문에 having절에서 조건을 주어야 한다.
select emp_no,avg(salary)
from salaries
group by emp_no
having avg(salary) > 80000
-- order by
order by avg(salary) asc;










