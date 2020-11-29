#!/bin/bash

sudo docker-compose up zookeeper kafka
sleep 25
sudo docker exec -it "kafka"/bin/bash -c "sh /opt/kafka_2.12-2.3.1/createTopic.sh" 
sleep 15
sudo docker compose up mongo flask
sudo docker-compose up sparkmaster sparkworker