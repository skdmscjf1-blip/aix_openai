import oracledb 
import os
from dotenv import load_dotenv

load_dotenv()
ora_conn = os.getenv('ora_conn')

# 오라클 DB접속
# localhost : ip주소
# 접속1
# conn = oracledb.connect(user='ora_user',password='1111',dsn='localhost:1521/XE')
# 접속2
# conn = oracledb.connect('ora_user/1111@localhost:1521/XE')
# 접속3 - .env에서 접속정보 가져오기
conn = oracledb.connect(ora_conn)


cursor = conn.cursor()
sql = 'select * from stuscore'
cursor.execute(sql)

rows = cursor.fetchall()

print(rows[0])

# for row in rows :
#     print('{},{},{},{},{},{},{},{},{},{},{}'.format(*row))
