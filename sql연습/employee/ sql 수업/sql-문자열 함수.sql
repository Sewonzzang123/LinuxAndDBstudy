-- 함수: 문자열 함수

-- UCASE,UPPER : 대문자 변환
select UPPER('SEoul'), UCASE('seOUL');
select upper(first_name) from employees;

-- lower : 소문자 변환
select lower('SEoul'), lower('seOUL');
select lower(first_name) from employees;

-- substring (문자열, 시작 index, length)
select substring('Happy Day', 3, 2);

-- 예제 : 1989년에 입사한 직원의 이름,입사일를 출력
select first_name, hire_date
from employees
where '1989'=substring(hire_date,1,4);

-- lpad(오른쪽 정렬), rpad(왼쪽 정렬)
select lpad('1234',10,'-');
select rpad('1234',10,'-');

-- 예제 : 월급 오른쪽 정렬, 나머지 *로 채우기
select lpad(salary,10,' ') as salary
from salaries
where from_date like '2001-%';

-- trim, ltrim, rtrim
select concat('---',ltrim('   hello  '),'---' )as ltrim;
select concat('---',rtrim('   hello  '),'---' ) as rtrim; 
select concat('---',trim(both ' ' from '   hello   '),'---') as 'both';









