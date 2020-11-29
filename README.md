# BDFI_PracticaFinal
Repositorio de la práctica final de BDFI.
Sistema de predicción de retraso de vuelos
Objetivos conseguidos:
  - Ejecución en local
  - Job de Spark-Submit
  - Dockerizar los servicios
  - Despliegue con Docker Compose
  - http://localhost:5000/flights/delays/predict_kafka

![alt tag](https://github.com/RAULTG97/BDFI_PracticaFinal/blob/main/escenario.png)

# EJECUCIÓN

```sh
  $ git clone https://github.com/RAULTG97/BDFI_PracticaFinal.git
  $ cd BDFI_PracticaFinal
  $ sudo docker-compose up
  $ ver como manejar el lanzamiento del spark-submit
```
----------------------------
# PARTE 1 [5 PUNTOS]
# EJECUCIÓN EN LOCAL (4 puntos) + SPARK SUBMIT (1 punto)


Pasos seguidos:
1. Clonar repositorio
  ```sh
    $ git clone https://github.com/ging/practica_big_data_2019
  ```   
2. Descargar datos:
  ```sh
    $ cd practica_big_data_2019
    $ resources/download_data.sh
    $ sudo pip3.7 install -r requirements.txt
  ``` 

 3. Arrancar Zookeeper:
  ```sh
    $ export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64 
    $ bin/zookeeper-server-start.sh config/zookeeper.properties
  ```
  4. Arrancar Kafka:
  ```sh
    $ bin/kafka-server-start.sh config/server.properties
    $ bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic flight_delay_classification_request
  ```
  5. Arrancar MongoDB e importar datos:
  ```sh
    $ service mongod start
    $ ./resources/import_distances.sh
  ```  
  6. Entrenamiento del modelo
  ```sh
    $ export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64
    $ export SPARK_HOME=/opt/spark
    $ export PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin
    $ export PYSPARK_PYTHON=/usr/bin/python3.7
    $ python3.7 resources/train_spark_mllib_model.py .
  ```  
  7. Modificar la clase MakePrediction.scala para indicar la ruta en la que se encuentra nuestro proyecto. Ejemplo:
  ```sh
    $ val base_path = “/home/rtorres/raul/master/BDFI/practica_big_data_2019”
```
  8. Exportar la variable de entorno del proyecto. Ejemplo:
  ```sh
    $ export PROJECT_HOME=/home/rtorres/raul/master/BDFI/practica_big_data_2019
  ```
  9. Ejecutar servidor web Flask:
  ```sh
    $ cd practica_big_data_2019/resources/web
    $ python3.7 predict_flask.py
```
  10. Ejecutar job de Spark. Previamente se debe generar el fichero .jar desde IntelliJ o con la herramienta sbt (sbt package)
  ```sh
    $ cd /opt/spark
    $ ./bin/spark-submit --class es.upm.dit.ging.predictor.MakePrediction --master local --packages org.mongodb.spark:mongo-spark-connector_2.11:2.3.2,org.apache.spark:spark-sql-kafka-0-10_2.11:2.4.0 /home/rtorres/raul/master/BDFI/practica_big_data_2019/flight_prediction/out/artifacts/flight_prediction_jar/flight_prediction.jar
```
  11. Consulte sus predicciones de retraso de vuelos:
  ```sh
    http://localhost:5000/flights/delays/predict_kafka
  ```  

------------------

# PARTE 2 [7 PUNTOS]
# DESPLIEGUE EN DOCKER (1 punto) + DOCKER-COMPOSE (1 punto)

  1. Instalar Docker:
  ```sh
    $ sudo apt-get remove docker docker-engine docker.io containerd runc
    $ sudo apt-get update
    $ sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
    $ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    $ sudo apt-key fingerprint 0EBFCD88
    $ sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
    $ sudo apt-get update
    $ sudo apt-get install docker-ce docker-ce-cli containerd.io
 ```
  2. Instalar Docker-Compose:
  ```sh
    $ sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    $ sudo chmod +x /usr/local/bin/docker-compose
    $ sudo curl -L https://raw.githubusercontent.com/docker/compose/1.27.4/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose
   ``` 
  3. Creamos contenedores docker:
  - 3.1. MongoDB
       - 3.1.1. Imagen Utilizada: https://hub.docker.com/layers/mongo/library/mongo/4.4.2/images/sha256-8ac5e14d9badded42bcbad612a43bb28ae1bb7e411d2965588dfff83087c5aac?context=explore
      - 3.1.2. Consideraciones:
        - Le pasamos a la imagen el script import_distances al entrypoint, para que se ejecute al levantar el contenedor
        - Puerto 27027
- 3.2. Flask
    - 3.2.1. Imagen Utilizada: https://github.com/tiangolo/meinheld-gunicorn-flask-docker
    - 3.2.2. Consideraciones:
        - Le pasamos la carpeta /web renombŕándola a /app para que la imagen con la configuración que tiene, interprete que tiene que ejecutar el servidor web en esa carpeta. Además, predict_flask.py lo renombramos a main.py
        - Puerto 5000
        - Muy importante editar main.py para definir la conexión con Kafka y Mongo:
  ```sh
   CONNECTION_URI = "mongodb://mongodb:27017" # mongodb://mongodbHostName:27017
    client = MongoClient(CONNECTION_URI, connect=False)
    producer = KafkaProducer(bootstrap_servers=['kafka:9092'],api_version=(2,3,0))
   ```  
- 3.3. Zookeeper
    - 3.3.1. Imagen Utilizada: https://hub.docker.com/layers/zookeeper/library/zookeeper/3.4.13/images/sha256-e7dbb1ff2ec430b4d754e769e222809db95feb33e67927a9c80604ba4e0e63b9?context=explore
  - 3.3.2. Consideraciones:
       - Imagen oficial de Zookeeper que deja arrancado el servidor
        - Puerto 2181
        
- 3.4.- Kafka
    - 3.4.1. Imagen Utilizada: https://hub.docker.com/r/wurstmeister/kafka/dockerfile
    - 3.4.2. Consideraciones:
        - Con las ENV definimos la configuración de Kafka, indicando el topic a crear y su conexión con Zookeeper
        - Puerto 9092

- 3.5. Spark-Master
     - 3.5.1. Imagen Utilizada: https://hub.docker.com/layers/bitnami/spark/2.4.4/images/sha256-8a848671c4f673602267b21ccfc848229ef092da3f248b35a048c9933f152187?context=explore
    - 3.5.2. Consideraciones:
        - Se define que es SPARK_MODE=master para que al levantar el contenedor arranque el nodo en modo MASTER
        - Puertos: 8080, 7077
        
        
- 3.6. Spark-Worker
     - 3.6.1. Imagen Utilizada: https://hub.docker.com/layers/bitnami/spark/2.4.4/images/sha256-8a848671c4f673602267b21ccfc848229ef092da3f248b35a048c9933f152187?context=explore
     - 3.6.2. Consideraciones:
        - Se define que es SPARK_MODE=worker para que al levantar el contenedor arranque el nodo en modo worker
        - Se define la conexión con el MASTER --> ENV SPARK_MASTER_URL=spark://spark-master:7077
        - Ejecuta el spark-submit
        - Puertos: 8081
        - [MakePrediction.scala] Muy importante que recompilemos el jar que pasamos al contenedor con las rutas correctas. base_path en este caso apuntará al proyecto en su ubicación en el interior del contenedor. Además, debemos editar las conexiones con Kakfa y Mongo:
  ```sh
    val base_path= "/opt/bitnami/spark/practica_big_data_2019"
    .option("kafka.bootstrap.servers", "kafka:9092")
    val writeConfig = WriteConfig(Map("uri" -> "mongodb://mongodb:27017/agile_data_science.flight_delay_classification_response"))
   ``` 

    
4. Definimos docker-compose.yaml
    
5. Ejecutamos escenario:
```sh
     $ sudo docker-compose up
``` 
