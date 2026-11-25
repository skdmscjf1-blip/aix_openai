import oracledb
import os
from dotenv import load_dotenv

# oracle접속정보 - sql정보를 더블클릭
load_dotenv()
ora_conn = os.getenv('ora_conn')
conn = oracledb.connect(ora_conn)

# 검색
# kor_loan_status 테이블에서
# 지역별로 그룹핑 후 , 주택담보대출을 출력하시오.

cursor = conn.cursor()

sql = f"select region,sum(loan_jan_amt) from kor_loan_status where gubun='주택담보대출' group by region order by sum(loan_jan_amt) desc"

cursor.execute(sql)
rows = cursor.fetchall()
for row in rows :
    print('{}\t{}'.format(*row))
cursor.close()