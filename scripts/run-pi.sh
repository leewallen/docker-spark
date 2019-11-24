#!/bin/bash

docker-compose exec --detach --index=1 spark-worker /spark/bin/spark-submit --master spark://spark-master:7077 --class org.apache.spark.examples.SparkPi ./jars/spark-examples_2.11-2.4.4.jar 1000


