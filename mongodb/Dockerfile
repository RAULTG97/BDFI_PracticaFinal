#MONGO

FROM mongo:4.2.0

ENV MONGO_HOST=mongo
ENV MONGO_PORT=27017

COPY ./data /data
#COPY data /usr/src/flight_prediction/.

COPY import_distances.sh /docker-entrypoint-initdb.d/