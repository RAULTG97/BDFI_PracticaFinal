#SPARK WORKER

#FROM bitnami/spark:2.4.4
FROM andreper/spark-worker:2.4.4-hadoop-2.7

ENV SPARK_WORKER_CORES=1
ENV SPARK_WORKER_MEMORY=512m

ENV SPARK_MODE=worker
ENV SPARK_MASTER_URL=spark://spark-master:7077
#ENV SPARK_WORKER_MEMORY=1G
#ENV SPARK_WORKER_CORES=1


#ENV SPARK_HOME=/opt/bitnami/spark
#ENV PATH="$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin"

EXPOSE 8081

COPY ./practica_big_data_2019 ./practica_big_data_2019

COPY ./flight_prediction.jar jars/.

COPY ./flight_prediction_2.11-0.1.jar jars/
