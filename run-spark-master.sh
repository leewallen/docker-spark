#!/bin/bash


docker run -d --name spark-master --hostname spark-master -v `pwd`/scripts/start.sh:/start.sh -p 7077:7077 -p 8080:8080 --rm spark-for-solr/spark:latest
