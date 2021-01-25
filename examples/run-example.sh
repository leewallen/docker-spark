#!/bin/bash

docker-compose up --detach
echo -e "Sleeping for 10 seconds to give the containers time to start."
sleep 20
docker ps -a

# docker-compose exec --index=1 spark-worker /spark/bin/spark-submit --master spark://spark-master:7077  --class app.SimpleApp ./jars/example-spark.jar ./jars/test.txt

