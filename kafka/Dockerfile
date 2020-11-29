#KAFKA

FROM johnnypark/kafka-zookeeper:2.3.1

WORKDIR /opt/kafka_2.12-2.3.1/config

RUN ["rm", "server.properties"]

COPY ./server.properties .

WORKDIR /opt/kafka_2.12-2.3.1

COPY ./createTopic.sh .

RUN chmod +x createTopic.sh

RUN ["bin/kafka-server-start.sh", "config/server.properties"]