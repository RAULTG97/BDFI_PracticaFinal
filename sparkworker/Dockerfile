#SPARK WORKER

FROM bitnami/spark:2.4.4

ENV SPARK_MODE=worker
ENV SPARK_WORKER_MEMORY=1G
ENV SPARK_WORKER_CORES=1
ENV SPARK_HOME=/spark

EXPOSE 8081

VOLUME ./spark/models/:/job_data/models  #Bind mount to mount models dir on each spark node

#DEBEMOS GENERAR DE NUEVO EL JAR [MODIFICAR]
COPY /flight_prediction_jar/flight_prediction.jar /spark/bin

CMD ["/spark/bin/spark-submit", "--class", "es.upm.dit.ging.predictor.MakePrediction", "--master", "spark://sparkmaster:7077","--packages","org.mongodb.spark:mongo-spark-connector_2.11:2.3.2,org.apache.spark:spark-sql-kafka-0-10_2.11:2.4.0","/spark/bin/flight_prediction.jar"]