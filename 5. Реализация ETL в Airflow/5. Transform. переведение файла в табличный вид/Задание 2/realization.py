from airflow import DAG
from airflow.providers.http.operators.http import SimpleHttpOperator
from airflow.hooks.base import BaseHook
from airflow.operators.python import PythonOperator

import datetime
import requests
import pandas as pd
import os
import psycopg2, psycopg2.extras

dag = DAG(
    dag_id='552_postgresql_export_fuction',
    schedule_interval='0 0 * * *',
    start_date=datetime.datetime(2021, 1, 1),
    catchup=False,
    dagrun_timeout=datetime.timedelta(minutes=60),
    tags=['example', 'example2'],
    params={"example_key": "example_value"},
)
business_dt = {'dt':'2022-05-06'}




def load_file_to_pg(*ваш код здесь*):

    df = pd.read_csv(f"/lessons/5. Реализация ETL в Airflow/4. Extract как подключиться к хранилищу, чтобы получить файл/Задание 2/{*ваш код здесь*}" )


    cols = ','.join(list(f.columns))
    insert_stmt = f"INSERT INTO stage.{*ваш код здесь*} ({*ваш код здесь*}) VALUES %s"

    pg_conn = psycopg2.connect(*ваш код здесь*)
    cur = pg_conn.cursor()

    psycopg2.extras.execute_values(cur, insert_stmt, f.values)
    pg_conn.commit()

    cur.close()
    pg_conn.close()