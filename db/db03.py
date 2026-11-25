import oracledb
import os
from dotenv import load_dotenv

# oracle접속정보 - sql정보를 더블클릭
load_dotenv()
ora_conn = os.getenv('ora_conn')
conn = oracledb.connect(ora_conn)

cursor = conn.cursor()

no = 3
name = '홍길순'
school = '신림고'
height=190
kor = 90
eng = 90
math = 90
SPECIALTY = 'python'
total = 270
avg = 90
srank = ''

#-- 실행문 --- insert
# sql = "insert into stuscore2 (no,name,school) values(:no,:name,:school)"
# cursor.execute(sql,no=4,name='개똥이',school='신림고')
# print('저장완료')
# print(sql)
# print('*'*60)
# cursor.close()
# conn.commit()






# ----------------------------------------

#-- 실행문 --- update
sql = "update stuscore2 set height=:height,specialty=:specialty where no!=:no"
cursor.execute(sql,height=180,specialty='C',no=5)
print('저장완료')
print(sql)
print('*'*60)
cursor.close()

# ----------------------------------------

#------------------------------
# 실행문 --- delete
sql = "delete stuscore2 where no=:no"
cursor.execute(sql,no=2)
cursor.close()
#------------------------------

conn.commit()
conn.close()  



