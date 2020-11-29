#!/bin/bash
echo "Import topic flight_delay_classification_request..."

bin/kafka-topics.sh --create --if-not-exists --zookeeper zookeeper:2181 --replication-factor 1 --partitions 1 --topic flight_delay_classification_request
#bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic flight_delay_classification_request