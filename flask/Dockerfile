#FLASK

FROM tiangolo/meinheld-gunicorn-flask:python3.7

COPY ./web /app

COPY ./requirements.txt /app/.

RUN pip3 install -r /app/requirements.txt