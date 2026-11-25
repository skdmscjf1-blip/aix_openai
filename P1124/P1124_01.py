import os
from dotenv import load_dotenv


# .env 파일을 불러오기
load_dotenv()
print('api key : ',os.getenv('open_ai_key'))
print('naver id : ',os.getenv('naver_id'))

