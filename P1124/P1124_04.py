import os
from pathlib import Path
from dotenv import load_dotenv
import openai
from openai import OpenAI

BASE_DIR = Path(__file__).resolve().parent.parent
envfile = BASE_DIR/'.env'
# print(envfile)
load_dotenv(envfile)
api_key = os.getenv('open_ai_key')
print(api_key)

while True : 
    txt_input = input('2027년 예측하고싶은 주식 종목을입력하세요. ')
    if txt_input : break
    print('예측하고싶은 주식 종목을 입력해야 검색이 가능합니다. 다시 입력해주세요.')

client = OpenAI(api_key=api_key)

try : 
    response = client.responses.create(
        model = 'gpt-5.6',
        instructions = (
            '당신은 근속년수 30년이상된 헤지펀트 매니저로 주식관련된 정보에 전문가야. '
            '2027년 주식시세가 어떻게 될지 생각하고 검증해서 알려주세요'
            '현재 주가 , 2027년 주가 등으로 세부적으로 적어서 알려줘'
            '고객이 이해하기 쉽고 간략하게 설명도 추가해줘'
            '2027년도에 각광받거나 또는 트랜드에 중심이 될 주식,주식종목도 추천해주고 이유도 쉽고 간략하게 설명추가해줘'

        ),
        input =f'{txt_input}를 가지고 2027년도 주식시세가 어떻게 될지 제안해주세요. ',
         max_output_tokens = 5000,
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

#경제전문가입니다.
#2027년도 주식시세가 어떻게 될지 알려주는 프로그램을 구현하시오.
#반도체주, 전력시설주 , 우주항공주
#500자 이내로 알려줘
