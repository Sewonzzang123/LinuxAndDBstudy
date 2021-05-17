-- 함수: 날짜 함수

-- CURDATE(), CURRENT_DATE
select curdate(), current_date;

-- CURTIME(), CURRENT_TIME
select curtime(), current_time;

-- now() vs sysdate()
select now(), sysdate();
select now(), sleep(2), now();
select sysdate(), sleep(2), sysdate();

-- date_format(date, format)
select date_format(now(),'%Y년 %m월 %d일 %h시 %i분 %s초'); 
select date_format(now(),'%Y년 %c월 %d일 %h시 %i분 %s초'); 

-- period_diff 사이 기간(YYMM, YYYYMM)
-- 근무 개월수를 출력
select period_diff(date_format(curdate(),'%Y%m'),
	date_format(hire_date,'%Y%m'))
from employees;

-- date_add(adddate), date_sub(subdate)
-- 날짜 date에 type(day, month, year) 형식으로 expr값을 더하거나 뺀다.
-- 예) 각 사원들의 근무 년수가 5년이 되는 날은?

select first_name,
		hire_date,
		date_add(hire_date,interval 5 year)
from employees;

-- cast x as y 
select cast('2021-05-17' as date);
select cast('12345' as int) + 10;
select now(), cast(now() as date);
select cast(cast(1-2 as unsigned) as signed);

-- mysql type
-- VARCHAR, CHAR, text
-- signed(unsigned) int(integer), medium, big int
-- float, double
-- time, date, datetime
-- lob(large object): blob, clob

