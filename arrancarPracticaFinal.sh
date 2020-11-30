#!/bin/bash
echo "Empezando la configuracion..."
sudo docker-compose up --build
echo "Espere hasta que se configure..."
sleep 25
echo "Ejecutando spark-submit..."
sudo docker exec -it spark-worker /bin/bash -c "bin/spark-submit --class es.upm.dit.ging.predictor.MakePrediction --master spark://spark-master:7077 --packages org.mongodb.spark:mongo-spark-connector_2.11:2.4.1,org.apache.spark:spark-sql-kafka-0-10_2.11:2.4.0 practica_big_data_2019/flight_prediction/target/scala-2.11/flight_prediction_2.11-0.1.jar"
echo "Haga sus predicciones de retraso de vuelo en http://localhost:5000/flights/delays/predict_kafka"