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
# 국어,영어,수학 역순정렬로 정렬하시오
while True:
    kor = input('검색할 이름을 입력하세요.')
    if kor.strip() == '국어':
        kor = 'kor'
    elif kor.strip() =='영어':
        kor = 'eng'
    elif kor.strip() =='수학':
        kor = 'math'
    if kor == '': break
    sql = f"select kor,eng,math from stuscore order by {kor} desc "
    cursor.execute(sql)
    rows = cursor.fetchall()
    print(rows)
    print('전체인원 : ',len(rows))
    print('*'*60)
cursor.close()
print('프로그램종료')    
# for row in rows:
#     print(row)

# row 타입 ()
# row = cursor.fetchone()
# print(row)


