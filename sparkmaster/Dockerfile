#SPARK MASTER

FROM bitnami/spark:2.4.4

ENV SPARK_MODE=master

EXPOSE 8080

VOLUME ./spark/models/:/job_data/models #Bind mount to mount models dir on each spark node