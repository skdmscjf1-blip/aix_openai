from django.shortcuts import render
import oracledb
from dotenv import load_dotenv
from pathlib import Path
import os
from board.models import Board


# 전역변수
BASE_DIR = Path(__file__).resolve().parent.parent.parent.parent
env_file = BASE_DIR/'.env'
load_dotenv(env_file)
ora_conn = os.getenv('ora_conn')
print('확인',BASE_DIR)



def blist(request):
    # db접속
    conn = oracledb.connect(ora_conn)
    cursor = conn.cursor()
    sql = '''select bno,nickname,btitle,bcontent,bgroup,bstep,bindent,bhit,bdate
            from board a,member b where a.id = b.id'''
    cursor.execute(sql)
    # 컬럼정보 - 대문자
#     columns = [col[0].lower() for col in cursor.description]
    columns = [col[0] for col in cursor.description]
    rows = cursor.fetchall()
    print('확인 : ',columns)
#   rows_list = [dict(zip(columns,row)) for row in rows]
    rows_list = []
    for row in rows:
        data = dict(zip(columns, row))
        # bcontent가 clob일때
        if data['BCONTENT'] is not None:
                data['BCONTENT'] = data['BCONTENT'].read()
        rows_list.append(data)
    cursor.close()
    conn.close()
    context={'blist':rows_list}
    return render (request,'blist.html',context)


# sqlLite
def blist2(request):
    qs = Board.objects.all().order_by('-bno')
    print('확인',qs)
    context = {'blist':qs}

    return render(request,'blist2.html',context)