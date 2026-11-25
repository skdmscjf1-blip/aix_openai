import os
from pathlib import Path
from dotenv import load_dotenv
import openai
from openai import OpenAI


# open ai api - key 출력
# 같은 폴더에서 load할때는 위치를 포함하지 않아도 됨.
# BASE_DIR = Path(__file__).resolve().parent.parent
# print(BASE_DIR)

# ENV_FILE = 'BASE_DIR/.env'
# load_dotenv(ENV_FILE)
# print(os.getenv('open_ai_key'))

# 1. open ai key 불러오기
load_dotenv()

# 2. open ai 클라이언트 생성
api_key = os.getenv('open_ai_key')
client = OpenAI(api_key = api_key)

# 3. 검색어 입력
message1 = input('초등학교 수업자료 설명.')

# 4. open ai 모델에 요청
try :
    response = client.responses.create(
        model = 'gpt-5.6',
        instructions = '당신은 초등학교 교사입니다.\
            [학습목표],[학습내용],[학습정리],[퀴즈] 순서로 알려주세요.',
        input = message1,
    )
except openai.APIConnectionError as error:
    print(error) # 인터넷 연결,프록시,방화벽 문제 등 확인
except openai.RateLimitError as error:
    print(error) #짧은 시간의 요청량 또는 프로젝트 사용한도 확인
except openai.APIError as error:
    print(error) # 인증,권한,잘못된 요청 등 그밖 API 오류확인.

# 5. 출력

result = response.output_text.strip()
# print(response) # 멀티턴
print('[응답]')
print(result)

