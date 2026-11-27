select * from board;


-- bno 1~10까지 가져오기
select * from board
where bno between 1 and 10;

-- 3,7,11,20,22,23,26,35,36,38,49,54
delete board where bno=3;
delete board where bno=4;
delete board where bno=5;
delete board where bno=6;
delete board where bno=7;
delete board where bno=11;
delete board where bno=20;
delete board where bno=22;
delete board where bno=23;
delete board where bno=26;
delete board where bno=35;
delete board where bno=36;
delete board where bno=38;
delete board where bno=49;
delete board where bno=54;

commit;
-- 1~ 10개
select * from board
where bno between 1 and 10;

-- rownum 

select rownum,a.* from board a;

select rownum,a.* from departments a
where rownum>=1 and rownum<=10;

select rownum,a.* from board a
where rownum>=1 and rownum<=10;

select * from (select rownum rnum,a.* from board a)
where rnum>=11 and rnum<=20;

select rownum rnum,b.* from (select * from board a order by id desc) b;
select * from board a order by id desc;

select * from (select rownum rnum,b.* from(select * from board a order by id desc) b)
where rnum>=11 and rnum<=20;

-- 합계점수가 가장 높은 학생 11~20위를 앞에 번호를 부여해서 출력하시오.

select * from stuscore;

select (kor+eng+math) total from stuscore
order by total desc;


select * from ( select rownum rnum, b.* from
( select a.*,(kor+eng+math) total from stuscore a
order by total desc ) b) where rnum>=11 and rnum<=20
;

-- row_number() over () : 정렬을 먼저 한후 번호부여
-- rownum : 번호를 먼저 부여한 후 정렬
select * from (
select row_number() over (order by (kor+eng+math) desc) rnum,a.*
from stuscore a)
where rnum>= 11 and rnum<=20
;

-- rank순위
-- rank() 동일점수가 있을때 중복순위 개수만큼 다음 순위가 증가됨.
-- dense_rank() :  중복순위가 존재해도 다음순위 표시

select rank() over(order by (kor+eng+math) desc),kor+eng+math from stuscore a;
select dense_rank() over(order by (kor+eng+math) desc),kor+eng+math from stuscore a;

select * from stuscore;
alter table stuscore add total number(10);

--update

update stuscore set total = kor+eng+math;
select * from stuscore;

update stuscore set rank = null;
commit;

alter table stuscore modify rank number(10);
desc stuscore;

-- rank() over() 사용해서 rank 컬럼 등수를 입력
select name,total,rank() over(order by total desc) ranks,rank
from stuscore;

-- 합계점수를 update사용해서 입력
update stuscore set total = kor+eng+math;
select name,total,rank() over(order by total desc) ranks from stuscore;
select rank() over(order by total desc) ranks from stuscore;

update stuscore set rank=(select rank() over(order by total desc) ranks from stuscore);

update stuscore a set rank = (
select ranks from (
select ranks from(
select name,rank() over(order by total desc) ranks from stuscore
)b
where a.name = b.name

);

select no,name,rank from stuscore a;
select no,name,rank() over(order by total desc) ranks from stuscore b;

update stuscore a set rank = (
select ranks from (
select name,rank() over(order by total desc) ranks from stuscore) b
where a.name = b.name
);

select * from stuscore
order by rank;

create table employees2 as select * from employees;

select * from employees2;

-- 월급이 높은순으로 rank를 입력하시오.
-- rank 생성하고
alter table employees2 add rank number(10);
select * from employees2;
update employees2 a set rank =(
select ranks from(
select emp_name,rank() over(order by salary desc) ranks from employees2) b
where a.emp_name = b.emp_name
);

select * from employees2;
desc employees2;

select * from students;
select * from stuscore;

-- member 테이블 rank 생성하고 
-- board bhit가 높은 순으로 순위를 부여해서
-- member테이블의 rank에 입력하시오

select * from member;
select * from board;

alter table member add rank number(10);

select * from member;
select * from board;
select id,bhit,rank() over(order by bhit desc) ranks from board; 

alter table board add rank number(10);
select * from board;

update board a set rank = (
select ranks from(
select id,rank() over(order by bhit desc) ranks from board) b
where a.id=b.id);

select id,bhit,rank() over(order by bhit desc) ranks from board;

select * from board;

update member a set rank = (
select ranks from(
select id,rank() over(order by rank desc) ranks from board) b
where a.id=b.id);

select * from member;

select * from stuscore;

select id,count(bhit) from board
group by id;

select school,count(school) cnt from stuscore
group by school
order by school desc;

-- rownum

select * from(
select school,count(school) cnt from stuscore
group by school
order by school
);
select rownum,a.* from(
select school,count(school) cnt from stuscore
group by school
order by school
)a;

-- 그룹별 등수 가능
select * from stuscore;
select school,total,rank() over(
partition by school
order by total desc)
ranks
from stuscore;

-- kor 50점 이상을 출력하시오.
select * from stuscore
where kor>=50;

-- eng 80점 이상을 출력하시오.
select * from stuscore
where eng>=80;

-- kor 50점이상, eng 80점이상을 출력하시오.

select * from(
select * from stuscore
where kor>=50
);

select * from member;

select * from board;
desc board;

select bno,a.id,nickname,btitle,bcontent,bgroup,bstep,bindent,BHIT,BDATE
from member a ,board b
where a.id = b.id
Order by bno desc;

select * from member a,board b
where a.id=b.id;

--employees , departments
-- 사원명,월급,부서번호,부서이름 출력하시오.

desc employees;
desc departments;

select emp_name,salary,a.department_ID,DEPARTMENT_NAME from employees a, departments b
where a.department_id = b.department_id;

select * from board;

desc board;

