-- ora_user / c## 붙이지 않아도 됨.
alter session set "_ORACLE_SCRIPT"=true;
-- user 생성
create user ora_user3 identified by 1111;
-- 권한 부여
grant connect, resource, dba to ora_user3;