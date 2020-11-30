#SPARK MASTER

#FROM bitnami/spark:2.4.4
FROM andreper/spark-master:2.4.4-hadoop-2.7

ENV SPARK_MODE=master
ENV SPARK_LOCAL_IP=spark-master

COPY ./practica_big_data_2019 ./practica_big_data_2019

COPY ./flight_prediction.jar ./

COPY ./flight_prediction_2.11-0.1.jar ./

EXPOSE 8080 7077