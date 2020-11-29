#MONGO

FROM mongo:4.4.2


COPY ./data /data
#COPY data /usr/src/flight_prediction/.

COPY import_distances.sh /docker-entrypoint-initdb.d/