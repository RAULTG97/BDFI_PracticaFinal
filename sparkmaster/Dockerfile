#SPARK MASTER

FROM bitnami/spark:2.4.4

ENV SPARK_MODE=master

COPY ./practica_big_data_2019 /practica_big_data_2019

COPY ./flight_prediction.jar jars/

EXPOSE 8080 7077