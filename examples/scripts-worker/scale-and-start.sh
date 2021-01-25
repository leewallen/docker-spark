#!/bin/bash

SCALE_SIZE=1
if [ -z "$1" ]; then
  echo "Defaulting to one spark-worker."
else
  SCALE_SIZE="$1"
  echo "Using a scale value of ${SCALE_SIZE} for spark-worker."
fi

docker-compose up --scale spark-worker=${SCALE_SIZE} --detach

