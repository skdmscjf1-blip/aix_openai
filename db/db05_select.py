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

sql = 'select * from event'
cursor.execute(sql)

# 4. 데이터정보전달
rows = cursor.fetchall()

# 5. 데이터 출력
for row in rows : 
    print(row[0],row[1],row[2],row[3])

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