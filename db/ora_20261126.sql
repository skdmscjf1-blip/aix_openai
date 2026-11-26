--조인

select emp_name,department_id from employees;

select * from departments;

select * from board;

select * from stuscore;

-- 학년,학반,전화번호,주소,,보호자,담당교사,학교이름,성명,키,몸무게,특기
-- 학기,국어,영어,수학,합계,평균,등수

-- 조인의 필요성
-- 1. 중복된 데이터를 방지
-- 2. null값을 피하기 위해

-- cross join : 테이블 연결
select * from employees,departments;

-- equl join : 공통적으로 존재하는 컬럼을 일치시켜서 연결

select department_id from employees;
select department_id from departments;

select * from employees,departments
where employees.department_id = departments.department_id;
-- equl join
select emp_name,employees.department_id,departments.department_id,departments.department_name,salary from employees,departments
where employees.department_id = departments.department_id;

select emp_name,department_id,salary from employees;

select count(*) from employees;
select count(*) from departments;


select a.department_id,department_name
from employees a,departments b
where a.department_id = b.department_id
;

select job_id from employees;

select * from jobs;

-- equi join / employees, jobs
-- emp_name,salary,job_id,job_title,min_salary,max_salary,department_id
-- hire_date

select * from employees;
select * from jobs;

select emp_name,salary,a.job_id,
job_title,min_salary,max_salary,department_id,hire_date
from employees a,jobs b
where a.job_id = b.job_id;

select * from member;
select * from stuscore;


drop table board2; 
drop table member;
drop table students;
drop table stuscore;
drop table stuscore2;
drop table board;


create table board (
bno number(4) primary key,
id varchar2(100),
btitle varchar2(1000),
bcontent clob,
bgroup number(4),
bstep number(4) default 0,
bindent number(4) default 0,
bhit number(4) default 0,
bdate date default sysdate,
bfile varchar2(100)
);

create table member (
id varchar2(100) primary key,
pw varchar2(100),
name varchar2(100),
nickname varchar2(100),
tel char(13),
gender varchar2(100),
hobby varchar2(200),
mdate date default sysdate
);

create table students(
no number(4),
name varchar2(100) primary key,
major varchar2(100),
grade number(2),
age number(3),
gender varchar2(100),
hobby varchar2(200),
sdate date default sysdate
);

create table stuscore(
no number(4),
name varchar2(100),
school varchar2(100),
grade varchar2(2),
height number(4),
kor number(3),
eng number(3),
math number(3),
sw varchar2(100)
);

--외래키 등록

-- member primary key , board foreign key

alter table board add constraint board_member_fk_id foreign key(id)
references member(id) on delete set null;

select * from member;
select * from board;

select * from students;
select * from stuscore;
alter table stuscore add constraint stuscore_students_fk_name
foreign key(name)
references students(name) on delete CASCADE;


-- equi join name
select * from students;
select * from stuscore;

-- 성적을 출력하는데 , 성별,나이를 같이 출력하고 싶음
select a.no,a.name,gender,age,kor,eng,math from stuscore a , students b
where a.name = b.name
;

-- 
select * from board;
select * from member;

select a.id,nickname,btitle,bcontent,bgroup,bstep from board a, member b
where a.id = b.id;


select * from students;
update students set grade = 4 where name='Romonda';
commit;
select * from stuscore;

alter table stuscore drop column grade;
select * from stuscore;

select a.name,grade,kor,eng,math 
from students a , stuscore b
where a.name = b.name and lower(a.name) like '%a%';

-- employees,departments 
-- 사원명 , 부서번호,부서명, 입사일
-- 부서번호가 50번 이상만 출력하시오.

select * from employees;
select * from departments;

select emp_name,a.department_id,department_name,hire_date
from employees a, departments b
where a.department_id = b.department_id;

select emp_name,a.department_id,department_name,hire_date
from employees a, departments b
where a.department_id = b.department_id 
and a.department_id >=50;


-- job_id가 MAN인 사원의 job_id,job_title,salary,min_salary,hire_date
-- job_id가 MAN이면서 , 입사일이 02~03월 사원을 출력하시오.
select * from employees;
select * from jobs;
desc employees;

select emp_name,a.job_id,job_title,salary,min_salary,hire_date
from employees a , jobs b
where a.job_id = b.job_id
and lower(a.job_id) like '%man%' and substr((hire_date),4,2) in ('02','03','05')
;

select to_char(hire_date,'yyyy-mm-dd') from employees;
select to_char(hire_date,'mm') from employees;

-- 3개의 테이블을 가지고 equi-join
select a.department_id,department_name,a.job_id,job_title
from employees a, departments b, jobs c
where a.department_id = b.department_id and
a.job_id = c.job_id;

-- equi join : 두테이블 간, 같은컬럼을 가지고 검색
-- non-equl join : 두테이블 간, 같은 컬럼이 없이 검색. 

create table sturank (
srank varchar2(10),
low_score number(3),
high_score number(3)
);


-- VVIP , VIP, GOLD,SILVER,BRONZE 
insert into sturank values('VVIP',91,100);
insert into sturank values('VIP',81,90);
insert into sturank values('GOLD',71,80);
insert into sturank values('SILVER',61,70);
insert into sturank values('BRONZE',0,60);
commit;

select * from sturank;
select * from stuscore;

-- non-equi join : 같은 컬럼이 없지만 2개의 테이블을 가지고 검색
select no,name,school,round((kor+eng+math)/3,2),srank
from stuscore,sturank
where (kor+eng+math)/3 between low_score and high_score
order by no;

select srank
from stuscore,sturank
where (kor+eng+math)/3 between low_score and high_score
order by no;

select * from stuscore;
alter table stuscore add rank varchar2(20);

select * from sturank;

update stuscore a set rank = (
select srank
from sturank b
where a.avg between b.low_score and b.high_score)
;

update stuscore set rank = (
select srank
from sturank
where avg between low_score and high_score)
;


select * from stuscore;

alter table stuscore add avg number(5,2);

update stuscore set avg =(kor+eng+math)/3;

--
select salary from employees
order by salary desc;

-- 0-3999 E등급
-- 4000-6999 D등급
-- 7000-9999 C등급
-- 10000-11999 B등급
-- 12000-30000 A등급

create table salrank (
srank varchar2(10),
low_sal number(10),
high_sal number(10)
);


insert into salrank values('A',12000,30000);
insert into salrank values('B',10000,11999);
insert into salrank values('C',7000,9999);
insert into salrank values('D',4000,6999);
insert into salrank values('E',0,3999);
commit;

-- non-equi 조인
select * from employees;
select salary,srank from employees,salrank
where salary between low_sal and high_sal;


-- case when then
select salary,
case
when salary between 12000 and 30000 then 'A' 
when salary between 10000 and 11999 then 'B' 
when salary between 7000 and 9999 then 'C' 
when salary between 4000 and 6999 then 'D' 
when salary between 0 and 3999 then 'E' 
end as salrank from employees;

-- bfile 분리 filegroup 테이블 생성
create table filegroup (
bno number(4),
bfile varchar2(100), 
constraint board_filegroup_fk_bno foreign key (bno) 
references board (bno) on delete cascade
);

select * from board;
-- 컬럼삭제 
alter table board drop column bfile;

insert into filegroup values(2,'1111.jpg');
insert into filegroup values(2,'2222.jpg');
insert into filegroup values(3,'333.jpg');
insert into filegroup values(9,'9.jpg');

commit;

select * from filegroup;


select a.bno,btitle,bfile from board a,filegroup b
where a.bno = b.bno;

select * from board where bno=1;
select * from filegroup where bno=1;

create table event(
eno number(4) primary key,
etitle varchar2(1000),
econtent clob,
efile varchar2(100)
);

insert into event values(
event_seq.nextval,'이벤트제목','내용입니다','1.jpg'
);

select * from event;

commit;

select * from employees;
select * from salrank;


select salary,srank from employees,salrank
where salary between low_sal and high_sal;


select emp_name,a.department_id,department_name
from employees a,departments b
where a.department_id = b.department_id;

-- equi-join : 같은 컬럼을 가지고 2개의 테이블에서 검색
-- non-equi-join : 같은컬럼이 없지만 2개의 테이블에서 검색
-- self join : 자신의 테이블 2번 호출해서 검색

-- null값이 있는 것은 출력에서 제외
select a.employee_id,a.emp_name,a.job_id,a.salary,a.manager_id,b.emp_name
from employees a , employees b
where a.manager_id = b.employee_id
order by employee_id;

select * from employees;

-- 그룹함수 null 값을 제외
select count(*),count(manager_id) from employees;

-- inner join 
-- out join

select a.employee_id,a.emp_name,a.manager_id,b.emp_name
from employees a, employees b
where a.manager_id = b.employee_id(+);

select emp_name,manager_id from employees
where manager_id is null;

-- departments, employees 테이블에서 
-- employees테이블에서 없는 부서번호,부서명도 출력하시오.
-- equi join department_id , department_name

select * from departments;
select * from employees;

select emp_name,a.department_id,department_name
from departments a , employees b
where a.department_id = b.department_id(+)
and emp_name is null;

select * from depart;

select emp_name,a.department_id from employees a, departments b
where a.department_id = b.department_id;


-- ansi join
select emp_name,department_id
from employees inner join departments
using (department_id);




-- ansi outer join (left)
select a.emp_name,a.manager_id,b.employee_id
from employees a left outer join employees b
on a.manager_id = b.employee_id ;

-- equi join : outer join
select emp_name,a.department_id,department_name
from employees a, departments b
where a.department_id = b.department_id(+);
-- ansi left join
select emp_name,a.department_id,department_name
from employees a left outer join departments b
on a.department_id = b.department_id;



-- equi join : outer join
select emp_name,a.department_id,department_name
from employees a, departments b
where a.department_id(+) = b.department_id(+);
-- ansi right join
select emp_name,a.department_id,department_name
from employees a full outer join departments b
on a.department_id = b.department_id;

select * from employees;
create or replace view view_employees as select employee_id,emp_name,phone_number from employees;

select * from view_employees;

select * from stuscore;
select * from students;

create or replace view v_stu(
name,school,grade,kor,eng,math,total,avg
)as
select a.name,school,grade,kor,eng,math,kor+eng+math total,avg 
from stuscore a , students b
where a.name = b.name;

select * from v_stu;








