#!/bin/bash

sudo docker-compose up kafka zookeeper
sleep 30


sudo chmod +x createTopic.sh
sudo docker exec -it "kafka"/bin/bash -c "sh /path/al/creador/de/topics.sh" 
