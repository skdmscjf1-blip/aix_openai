import os
import oracledb
from dotenv import load_dotenv


# 1. 불러오기
load_dotenv()
ora_conn = os.getenv('ora_conn')
# print(ora_conn)

# 2. db연결
conn = oracledb.connect(ora_conn)
# print(conn)
cursor = conn.cursor()
# print(cursor)

# 3.쿼리작성실행
# employees,salrank non-equi join를 사용해서 월급의 등급을 출력하시오.
# emp_name,salary,srank,low_salary,high_salary,hire_date

# 디장고 -> html key,value 전달됨 (딕셔너리타입 변환)
sql = 'select name,kor+eng+math total,sw from stuscore'
cursor.execute(sql)

# 컬럼명을 추출
columns = [col[0] for col in cursor.description]
# print(columns)

# # 4. 데이터정보전달
rows = cursor.fetchall()

## 4-2 딕셔너리 형태로 변환
rows = [dict(zip(columns,row))for row in rows]
print(rows)
# context = {}

# # # 5. 데이터 출력
# for row in rows : 
#     print(row)

# 5-2 . insert,update,delete 할 경우
# inset - board
# inset - file1
# inset - file2
# inset - file3
# conn.commit()
# conn.rollback()

# 6. db정보 닫기
cursor.close()
conn.close()