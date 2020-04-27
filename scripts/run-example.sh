#!/bin/bash

docker-compose exec --index=1 spark-worker /spark/bin/spark-submit --master spark://spark-master:7077  --class app.SimpleApp ./jars/example-spark.jar ./jars/test.txt

