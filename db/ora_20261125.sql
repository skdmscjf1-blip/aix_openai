select * from stuscore;

-- oracle if절 조건에 따라 실행할수 있는 형태
-- decode : 정확히 일치할때
-- case :  크거나 ,작거나, 정확히 일치할떄 실행

select emp_name,department_id,
decode(department_id,10,'10번입니다.',
20,'20번입니다',30,'30번입니다') as did from employees;

select * from stuscore;

-- 10 - 월급 1.2
-- 20 - 월급 1.0
-- 30 - 월급 2.0
-- 40 - 월급 2.5
-- 50 - 월급 1.8
select department_id,salary,
decode(department_id,10,salary*1.2,
20,salary*1.0,
30,salary*2.0,
40,salary*2.5,
50,salary*1.8) as nwe_salary
from employees;

-- case

select department_id,salary,
case 
when department_id<=50 then '근무장소이동 : A동'
when department_id>50 then '근무장소이동 : B동'
end as move_department
from employees;

select department_id,salary,
case 
when department_id<=50 then salary*1.5
when department_id>50 then salary*2.5
end as new_salary
from employees;

select * from stuscore;

-- (kor+eng+math)/3 
-- 90점이상 A, 80점이상 B, 70 C, 60 D, F

select name,kor,eng,math,round((kor+eng+math)/3,2),
case
when (kor+eng+math)/3 >=90 then 'A' 
when (kor+eng+math)/3 >=80 then 'B'
when (kor+eng+math)/3 >=70 then 'C'
when (kor+eng+math)/3 >=60 then 'D'
when (kor+eng+math)/3 <60 then 'F'
end as score_rank
from stuscore;

select * from stuscore;

update stuscore set srank = (
case
when (kor+eng+math)/3 >=90 then 'A'
when (kor+eng+math)/3 >=80 then 'B'
when (kor+eng+math)/3 >=70 then 'C'
when (kor+eng+math)/3 >=60 then 'D'
else 'F'
end 
);

desc stuscore;

alter table stuscore modify srank varchar2(2);

update stuscore set srank = (
case
when (kor+eng+math)/3 >=90 then 'A'
when (kor+eng+math)/3 >=80 then 'B'
when (kor+eng+math)/3 >=70 then 'C'
when (kor+eng+math)/3 >=60 then 'D'
else 'F'
end 
);

select * from stuscore;

update stuscore set total = (kor+eng+math);
update stuscore set avg = total/3;
select * from stuscore;

commit;


create table stuscore2 as select * from stuscore;

delete stuscore2;

commit;

select * from stuscore2;

insert into stuscore2 values(
1,'홍길동','신림고',178,100,100,99,'C',100+100+99,(100+100+99)/3,''
);

-- employees에서 연봉 5000이하는 20%증가 , 8000이하 10% 증가 
-- 8000초과 5%증가

select salary, 
case
when salary>8000 then salary*1.05
when salary<=8000 then salary*1.1
when salary<=5000 then salary*1.2
end as salaryup
from employees;


-- 1~17 : 1반
-- 18~50 : 2반
-- 51~77 : 3반
-- 그외 : 4반
select no,name,
case
when no>=1 and no<=17 then '1반'
when no>=18 and no<=50 then '2반'
when no between 51 and 77 then '3반'
else '4반'
end as grade
from stuscore;

-- count,sum , avg , min , max, studev , variance : 분산
select count(*) from employees;

-- employees 월급의 총합,평균
-- 평균보다 낮은 사원을 출력하시오.

select sum(salary),avg(salary) from employees;

select * from employees where (select avg(salary) from employees) > salary;

-- commission_pct 를 커미션을 받는 사원수를 출력하시오

select count(*),count(commission_pct) from employees;
select count(*),count(manager_id) from employees;


select count(*) from employees
where commission_pct is not null;

-- department_id 가 없는 커미션 받는 사원수를 출력하시오.
select count(commission_pct) from employees
where department_id is null;

-- 그룹함수
-- 부서별 월급합계를 출력하시오.

select department_id,sum(salary) from employees
group by department_id order by department_id
;

-- 그룹함수컬럼과 일반컬럼은 동시에 사용이 안됨.
-- group by 에 일반컬럼을 넣으면 일반컬럼도 출력이 가능함.
select emp_name,job_id,count(commission_pct) from employees
where department_id is null
group by emp_name,job_id;


-- 지역별 region 금액 합계를 출력하시오
select * from kor_loan_status;
select region,sum(loan_jan_amt) from kor_loan_status
group by region;
;


-- 년도별 금액함계를 출력하시오.
select period,substr(period,1,4),substr(period,5,2),sum(loan_jan_amt) from kor_loan_status
group by period;

select substr(period,1,4) year,sum(loan_jan_amt) from kor_loan_status
group by substr(period,1,4);

-- 월별 급액합계를 출력하시오.

select substr(period,5,2) year,sum(loan_jan_amt) from kor_loan_status
group by substr(period,5,2);

-- 그룹함수컬럼의 제약조건 having 
-- 일반컬럼의 제약조건은 where
select department_id,sum(salary) from employees
where department_id >=50 
group by department_id
having sum(salary)>50000;

-- 부서별 평균 급여를 출력하시오
-- 5000 이하인 부서를 출력하시오
select department_id,round(avg(salary),2) from employees
group by department_id
having avg(salary)<=5000;

-- kor_loan_status 테이블에서 
-- 2012년 이상의 년도별 총합 금액을 출력하시오.
-- 총합 현재단위가 십만원 원단위로 출력하고 , 천단위 표시를 하시오. *100000

select * from kor_loan_status;
desc kor_loan_status;
select substr(period,1,4),
to_char(sum(loan_jan_amt)*100000,'L999,999,999,999,999') from kor_loan_status
where substr(period,1,4)>=2012
group by substr(period,1,4);

select * from kor_loan_status;

-- 지역별 그룹핑을 한후 주택담보대출이 최대인 지역을 출력하시오.
-- 검색된 것중에 1번째 것을 출력
select region,sum(loan_jan_amt) as amt from kor_loan_status
where gubun = '주택담보대출'
group by region
order by sum(loan_jan_amt) desc
fetch first 1 row only
;
 -- 이중쿼리

select * from stuscore;
select * from (select * from stuscore where total>150)
where school = '신림고'
order by total desc;

select * from stuscore 
where total>150 and school = '신림고';

create table students1(
no number(4) primary key,
name varchar2(50),
school varchar2(20),
grade number(2),
height number(5,2),
kor number(3),
eng number(3),
math number(3),
sw varchar2(20)
);

select * from students1;
-- 학년별 합계 최고 성적을 출력하시오.
select grade,max(kor+eng+math) as total from students1
group by grade;

-- 학교별 , 반별 최고성적을 출력하시오.
select school,grade,max(kor+eng+math) as total from students1
group by school,grade
order by school;

select school,grade,max(kor+eng+math) as total from students1
group by school,grade
order by school;

select * from stuscore where lower(name) like '%a%';

select * from stuscore order by kor desc ;

select * from stuscore2;

insert into stuscore2 values(
2,'홍길동','디지털고',190,90,90,90,'python',270,90,''
);

select * from stuscore2;
desc stuscore2;

update stuscore2 set height = 180 , specialty = 'c'
where no!=1;

select * from kor_loan_status;
select region,sum(loan_jan_amt) from kor_loan_status
where gubun = '주택담보대출'
group by region
order by sum(loan_jan_amt) desc
;
