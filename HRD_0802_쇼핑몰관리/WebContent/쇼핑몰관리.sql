drop table member; -- 혹시 생성된것 있을 수 있으니 삭제

create table member (
memno char(4) not null primary key,
name varchar2 (30) not null,
address varchar2(100) not null,
hiredate date,
gender char(1),
tel1 char(3),
tel2 char(4),
tel3 char(4)
);

desc member; -- Run Sql~

----------------select.jsp----------------
select memno, name, address, 
to_char(hiredate, 'yyyy.mm.dd') as hiredate, 
decode(gender, 'M', '남', 'F', '여') as gender, 
tel1, tel2, tel3
from member;

--------------성별바꾸기 다른방법--------------
select memno, name, address, 
to_char(hiredate, 'yyyy.mm.dd') as hiredate, 
--case gender when 'M' then '남' when 'F' then '여' end as gender, 
case gender when 'M' then '남' else '여' end as gender, 
tel1, tel2, tel3
from member;

--------------가장 빠른 방법--------------
select memno, name, address, 
to_char(hiredate, 'yyyy.mm.dd'), 
decode(gender, 'M', '남', 'F', '여')
--case gender when 'M' then '남' else '여' end, 
tel1, tel2, tel3
from member; -- 별칭사용 안하고 getString(출력순서번호)을 사용

------------------------------------------

----------------update.jsp----------------
select name, address, 
to_char(hiredate, 'yyyy-mm-dd') as hiredate, 
decode(gender, 'M', '남', 'F', '여') as gender, 
tel1, tel2, tel3
from member
where memno = '';

--------------가장 빠른 방법--------------
select name, address, 
to_char(hiredate, 'yyyy.mm.dd'),  
decode(gender, 'M', '남', 'F', '여'), 
tel1, tel2, tel3
from member
where memno = ''; -- 별칭사용 안하고 getString(출력순서번호)을 사용

--------------------------------------------------------------
--------------문제에 sequence 생성 하여 값을 넣어야한다면?--------------
create sequence member_seq
start with 1001
increment by 1
minvalue 1001;

--insert into member values (member_seq.nextval, '김고객', '경북 경산시 중방동', '02/01/01', 'F', '010', '1234', '1001');
---------------------------------------------------------------
insert into member values ('1001', '김고객', '경북 경산시 중방동', '02/01/01', 'F', '010', '1234', '1001');
insert into member values ('1002', '이고객', '경북 경산시 삼북동', '02/02/01', 'M', '010', '1234', '1002');
insert into member values ('1003', '박고객', '경북 경산시 옥산동', '02/03/01', 'M', '010', '1234', '1003');
insert into member values ('1004', '조고객', '대구 광역시 달서구', '02/04/01', 'M', '010', '1234', '1004');
insert into member values ('1005', '유고객', '대구 광역시 유성구', '02/05/01', 'M', '010', '1234', '1005');
insert into member values ('1006', '여고객', '대구 광역시 수성구', '02/06/01', 'M', '010', '1234', '1006');
insert into member values ('1007', '남고객', '충남 금산군 중도리', '02/07/01', 'F', '010', '1234', '1007');
insert into member values ('1008', '황고객', '서울 특별시 관악구', '02/08/01', 'F', '010', '1234', '1008');
insert into member values ('1009', '전고객', '서울 특별시 강서구', '02/09/01', 'F', '010', '1234', '1009');

select * from member;

create table grade (
memgrade number(1) not null,
loprice number(30) not null,
hiprice number(30) not null
);

desc grade; -- Run Sql~

insert into grade values ('1', '150001', '500000');
insert into grade values ('2', '100001', '150000');
insert into grade values ('3', '50001', '100000');
insert into grade values ('4', '1', '50000');

select * from grade;

create table buy (
memno char(4) not null,
prodno char(4) not null,
product varchar2(20) not null,
price number(30),
bno number(30),
primary key(memno, prodno)
); -- primary key가 두개일 경우 테이블레벨로 넣어준다.
-- 컬럼옆에 두개적을 시 오류, references로 memno를 참조키로 받을 경우 밑에 insert문 중복 안됨
-- 문제지에 참조키일 경우에만 references사용

desc buy -- Run Sql~

insert into buy values ('1009', '0001', '긴 바지', 30000, 4);
insert into buy values ('1009', '0002', '점퍼', 100000, 1);
insert into buy values ('1006', '0004', '긴팔 셔츠', 25000, 1);
insert into buy values ('1006', '0002', '점퍼', 100000, 1);
insert into buy values ('1005', '0003', '반팔 셔츠', 20000, 3);
insert into buy values ('1002', '0003', '반팔 셔츠', 20000, 2);
insert into buy values ('1002', '0004', '긴팔 셔츠', 25000, 1);
insert into buy values ('1001', '0004', '긴팔 셔츠', 25000, 1);
insert into buy values ('1001', '0005', '긴팔 후드티', 23000, 2);

select * from buy;
----------------select2.jsp----------------
--[1] 등가조인
select memno, name, price*bno as totalprice
from member natural join buy; -- 각 구입항목별 회원번호, 이름, 총구입액

--[2] 등가조인
select memno, name, sum(price*bno) as totalprice
from member natural join buy
group by memno, name; -- 각 항목의 회원번호와 회원이름이 같은사람의 구입액 더함

--[3] 방법-1. 비등가조인(join~on) 검색조건 between사용
select decode(memgrade, '1', 'VIP', '2', 'GOLD', '3', 'SILVER', '4', 'NORMAL', '거지') as memgrade,
memno, name, totalprice
from grade join (select memno, name, sum(price*bno) as totalprice
				from member natural join buy
				group by memno, name)
on (totalprice between loprice and hiprice)
order by totalprice desc; -- 구입액 순으로 정렬

--[3] 방법-2. 비등가조인(join~on) 검색조건 and사용
select decode(memgrade, '1', 'VIP', '2', 'GOLD', '3', 'SILVER', '4', 'NORMAL', '거지') as memgrade,
memno, name, totalprice
from grade join (select memno, name, sum(price*bno) as totalprice
				from member natural join buy
				group by memno, name)
on (totalprice >= loprice and totalprice <= hiprice)
order by totalprice desc; -- 구입액 순으로 정렬
===========================================================
--[3] 방법-3. 비등가조인(, ~where) 검색조건 between사용
select decode(memgrade, '1', 'VIP', '2', 'GOLD', '3', 'SILVER', '4', 'NORMAL', '거지') as memgrade,
memno, name, totalprice
from grade, (select memno, name, sum(price*bno) as totalprice
				from member natural join buy
				group by memno, name)
where (totalprice between loprice and hiprice)
order by totalprice desc; -- 구입액 순으로 정렬

--[3] 방법-4. 비등가조인(, ~where) 검색조건 and사용
select decode(memgrade, '1', 'VIP', '2', 'GOLD', '3', 'SILVER', '4', 'NORMAL', '거지') as memgrade,
memno, name, totalprice
from grade, (select memno, name, sum(price*bno) as totalprice
				from member natural join buy
				group by memno, name)
where (totalprice >= loprice and totalprice <= hiprice)
order by totalprice desc; -- 구입액 순으로 정렬
------------------------------------------