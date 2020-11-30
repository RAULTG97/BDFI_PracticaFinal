#SPARK WORKER

FROM andreper/spark-worker:2.4.4-hadoop-2.7

ENV SPARK_WORKER_CORES=1
ENV SPARK_WORKER_MEMORY=512m

ENV SPARK_MODE=worker
ENV SPARK_MASTER_URL=spark://spark-master:7077

EXPOSE 8081

COPY ./practica_big_data_2019 ./practica_big_data_2019