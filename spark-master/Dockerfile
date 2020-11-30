#SPARK MASTER

#FROM bitnami/spark:2.4.4
FROM andreper/spark-master:2.4.4-hadoop-2.7

ENV SPARK_MODE=master
ENV SPARK_LOCAL_IP=spark-master

COPY ../practica_big_data_2019 ./practica_big_data_2019

EXPOSE 8080 7077