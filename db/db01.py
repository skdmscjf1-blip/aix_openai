import oracledb
import os
from dotenv import load_dotenv

# oracle접속정보 - sql정보를 더블클릭
load_dotenv()
ora_conn = os.getenv('ora_conn')
conn = oracledb.connect(ora_conn)

# print(conn.version)

# 커서연결 - sql명령어 창 연결
cursor = conn.cursor()

# 실행문
# sql = 'select * from students1 where no=1'
sql = '''select * from '''
cursor.execute(sql)

# 데이터 연결
# rows 타입은 [()]
rows = cursor.fetchall()
print(rows)
cursor.close()
# for row in rows:
#     print(row)

# row 타입 ()
# row = cursor.fetchone()
# print(row)


