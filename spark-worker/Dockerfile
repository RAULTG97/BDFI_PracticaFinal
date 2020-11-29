#SPARK WORKER

FROM bitnami/spark:2.4.4

ENV SPARK_MODE=worker
ENV SPARK_WORKER_MEMORY=1G
ENV SPARK_WORKER_CORES=1
ENV SPARK_MASTER_URL=spark://spark-master:7077

ENV SPARK_HOME=/opt/bitnami/spark
ENV PATH="$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin"

EXPOSE 8081

COPY ./practica_big_data_2019 ./practica_big_data_2019

COPY ./flight_prediction.jar jars/.

COPY ./flight_prediction_2.11-0.1.jar jars/

#CMD ["bin/spark-submit", "--class", "es.upm.dit.ging.predictor.MakePrediction", "--master", "spark://spark-master:7077","--packages","org.mongodb.spark:mongo-spark-connector_2.11:2.3.2,org.apache.spark:spark-sql-kafka-0-10_2.11:2.4.0","jars/flight_prediction.jar"]

bin/spark-submit --class es.upm.dit.ging.predictor.MakePrediction --master spark://spark-master:7077 --packages org.mongodb.spark:mongo-spark-connector_2.11:2.4.1,org.apache.spark:spark-sql-kafka-0-10_2.11:2.4.0 practica_big_data_2019/flight_prediction/out/artifacts/flight_prediction_jar/flight_prediction.jar
