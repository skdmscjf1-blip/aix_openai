from django.shortcuts import render
import oracledb
from dotenv import load_dotenv
from pathlib import Path
import os
from board.models import Board

BASE_DIR = Path(__file__).resolve().parent.parent.parent.parent
env_file = BASE_DIR/'.env'
load_dotenv(env_file)
ora_conn = os.getenv('ora_conn')



def blist(request):
    conn = oracledb.connect(ora_conn)
    cursor = conn.cursor()
    sql = 'select bno,nickname,btitle,bcontent,BGROUP,BSTEP,BINDENT,BHIT,BDATE from member a , board b where a.id = b.id order by bno desc'
    cursor.execute(sql)
    columns = [col[0] for col in cursor.description]
    rows = cursor.fetchall()
    print(columns)
    # print(rows)
    rows_list = []
    for row in rows:
        data = dict(zip(columns,row))
        if data['BCONTENT'] is not None: 
            data['BCONTENT'] = data['BCONTENT'].read()
            rows_list.append(data)
    cursor.close
    conn.close
    context = {'blist':rows_list}
    return render(request,'blist.html',context)


def blist2(request):
    qs = Board.objects.all().order_by('-bno')
    context = {'blist':qs}
    return render(request,'blist2.html',context)