-- 함수: 수학 함수

-- abs() 절대값
select abs(-1), abs(1);

-- mod() 나머지 값
select mod(40,3);

-- floor(x) x보다 크지 않은 가장 큰 정수를 반환
select floor(3.232233), floor(-1.123121) ;

-- ceil(x) x보다 큰 정수 중에 가장 작은 정수를 반환
select ceil(3.232233), ceil(-1.123121) ;

-- round(x) x 반올림
-- round(x,d) x값 중에서 소수점d자리에 가장 근접한 실수
select round(3.232233), round(-1.163121,1) ;

-- pow(x,y),power(x,y) x의 y승을 반환
select pow(2,10), power(10,3);

-- sign(x) x가 양수이면 1 음수면 -1 0이면 0
select sign(213), sign(-12323),sign(0);

-- greatest(x,y,....), least(x,y,.....)
select greatest(204,3,5,1), least(-2,23,6);


