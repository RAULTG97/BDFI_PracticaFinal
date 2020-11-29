#!/bin/bash

echo "Empezando la configuracion..."
sudo docker-compose up zookeeper kafka
echo "Espere hasta que se configure Kafka..."
#sleep 25
#echo "Arrancando el resto de contenedores..."
#sudo docker-compose up -d mongo flask
#sudo docker-compose up -d spark-master spark-worker