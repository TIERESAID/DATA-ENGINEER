import requests

nickname = 'Nick'
cohort = "1" # укажите номер когорты

generate_report_response = requests.post(
    "https://d5dg1j9kt695d30blp03.apigw.yandexcloud.net/generate_report", # точка входа
    headers={
    "X-API-KEY": "5f55e6c0-e9e5-4a9c-b313-63c01fc31460", # ключ API
    "X-Nickname": nickname, # авторизационные данные
    "X-Cohort": cohort # авторизационные данные
    }
).json()
task_id = generate_report_response["task_id"] 

get_report_response = requests.get(
    f"https://d5dg1j9kt695d30blp03.apigw.yandexcloud.net/get_report?task_id={task_id}", 
    headers={
    "X-API-KEY": "5f55e6c0-e9e5-4a9c-b313-63c01fc31460",
    "X-Nickname": nickname,
    "X-Cohort": cohort
    }
).json()

print(get_report_response)