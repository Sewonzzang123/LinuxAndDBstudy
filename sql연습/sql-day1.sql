show tables;
-- 주석
-- 테이블 가져오기
-- 파일있는 곳에서 #shtp webmaster@192.168.80.112 해서 접속 후 put pet.txt
-- #mysql -u root -D webdb -p
-- load data local infile '/home/webmaster/pet.txt' into table pet;
-- 테이블 삭제
drop table pet;

-- 테이블 만들기
-- char: 모든 칼럼이 다 똑같은 길이일 때 사용, 고정크기
-- varchar: 가변크기
create table pet(
	name	varchar(20),
    owner	varchar(20),
    species	varchar(20),
    gender	char(1),
    birth	date,
    death	date);
    
-- scheme 확인
desc pet;

-- 조회
select name, owner, species, gender,death from pet;

-- 생성(create)
insert into pet values('마루','장세원','개','w','2021-3-1',null);

-- 수정(update)
-- update pet set death = '2000-01-01' where name='Bowser';

-- 삭제
delete from pet where name='마루';

-- 조회 연습
-- 1990년 이후에 태어난 아이들은?
select name from pet where birth>'1990-12-31';

-- Gwen과 함께 사는 아이들은?
select name from pet where owner='Gwen';

-- null 다루기 1: 살아있는 애들은?
select * from pet where death is null;
-- null 다루기 2: 죽은 애들은?
select * from pet where death is not null;

-- like 검색(패턴매칭): 이름이 b로 시작하는 아이들은?
select * from pet where name like 'b%';
-- like 검색(패턴매칭): 이름이 b로 시작하는 아이들중에 이름이 6자인 애?
select * from pet where name like 'b_____';

-- 집계(통계) 함수
select count(*) from pet;

select count(death) from pet;
select count(*) from pet where death is not null;

-- 조회 연습 2: order by(정렬)
-- 어린순으로 정렬( 생일이 같으면 이름순으로 다시 정렬)
select name, birth
from pet
order by birth desc, name asc;



