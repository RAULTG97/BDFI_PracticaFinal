#!/bin/bash
bin/spark-class org.apache.spark.deploy.worker.Worker spark://${SPARK_MASTER_HOST}:${SPARK_MASTER_PORT} >> logs/spark-worker.out &
sleep 10 &&
bin/spark-submit --class es.upm.dit.ging.predictor.MakePrediction --master spark://spark-master:7077 --packages org.mongodb.spark:mongo-spark-connector_2.11:2.4.1,org.apache.spark:spark-sql-kafka-0-10_2.11:2.4.0 practica_big_data_2019/flight_prediction/target/scala-2.11/flight_prediction_2.11-0.1.jar