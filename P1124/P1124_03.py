import os
from pathlib import Path
from dotenv import load_dotenv
import openai
from openai import OpenAI
#-----------------------------------------------------------------------------
# key 가져오기
BASE_DIR = Path(__file__).resolve().parent.parent
envFile = BASE_DIR/'.env'
# print(BASE_DIR)
# print(envFile)
load_dotenv(envFile)
api_key = os.getenv('open_ai_key')
# print(api_key)
#-----------------------------------------------------------------------------
# 검색어 입력부분

while True : 
    txt_input = input('가고 싶은 여행지를 입력하세요.').strip()
    if txt_input : break
    print('여행지를 입력하셔야 검색이 가능합니다. 여행지를 다시 입력해주세요.')
    print()
#-----------------------------------------------------------------------------
# OpenAI client 연결부분 - 글자생성,이미지생성,음성생성,동영상생성 
client = OpenAI(api_key=api_key)

try :
    response = client.responses.create(
        model = 'gpt-5.6',
        instructions = ('당신은 여행설계 전문가입니다.'
                        '여행 일정을 1박2일 코스 설계해주세요.'
                        '[기차여행],[버스여행] 등으로 세부적으로 적어서 알려주세요.'
                        '여행자가 이해하기 쉽고 간략하게 답해주세요.'
                        ),
        input = f'{txt_input}를 가지고 [1박2일코스]-버스여행,여행지,숙소,식사 등을 제안해주세요.',
        max_output_tokens = 1000,
    )
except openai.APIConnectionError as error :
    print(f'인터넷연결,방화벽 문제 등을 확인해주세요. : {error}')
except openai.RateLimitError as error : 
    print(f'요청량 또는 프로젝트 사용한도를 확인해주세요. : {error}')
except openai.APIError as error : 
    print(f'인증,권한 등 api 오류를 확인해주세요. : {error}')

#------------------------------------------------------------------------------------------------------------
# 결과확인
result = response.output_text.strip()
if not result : 
    raise RuntimeError('응답결과 내용이 없습니다.')
print(f'[ {txt_input} 여행정보 ]')
print(result)
print('완료')
