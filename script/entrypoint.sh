#!/bin/bash
set -e
export PATH="$PATH:/home/airflow/.local/bin"
if [ -e "/opt/airflow/requirements.txt" ]; then
  $(command -v pip) install --user -r requirements.txt
  
fi
if [ ! -f "/opt/airflow/airflow.db" ]; then
  airflow db init && \
  airflow users create --username admin --firstname admin --lastname admin --role Admin --email admin@example.com --password admin
fi
airflow db upgrade
exec airflow webserver