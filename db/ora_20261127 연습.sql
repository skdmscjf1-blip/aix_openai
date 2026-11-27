create table member(
id varchar2(100) primary key,
pw varchar2(20),
name varchar2(100),
nickname varchar2(100),
tel varchar2(100),
gender varchar2(50),
hobby varchar2(100),
mdate date default sysdate
);

create table board(
bno number(10) primary key,
id varchar2(100) references member(id) on delete set null,
btitle varchar2(1000),
bcontent clob,
bgroup number(10),
bstep number(10),
bindent number(10),
bhit number(10),
bdate date default sysdate,
bfile varchar2(100)
);


drop table member;

select * from member;
select * from board;


select bno,nickname,btitle,bcontent,BGROUP,BSTEP,BINDENT,BHIT,BDATE,BFILE from member a , board b
where a.id = b.id
order by bno desc;

desc board;