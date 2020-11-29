#SPARK MASTER

FROM bitnami/spark:2.4.4

ENV SPARK_MODE=master
ENV SPARK_LOCAL_IP=spark-master

COPY ./practica_big_data_2019 ./practica_big_data_2019

COPY ./flight_prediction.jar jars/.

COPY ./flight_prediction_2.11-0.1.jar jars/

EXPOSE 8080 7077