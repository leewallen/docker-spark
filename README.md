# docker-spark

The docker-spark repo can be used for running spark locally for general purpose spark jobs, but is best used for integration / performance testing in a controlled environment before sending the spark job to a cluster.


Usage
=====
- [docker-spark](#docker-spark)
- [Usage](#usage)
- [Build the Docker Image](#build-the-docker-image)
- [Start the Cluster](#start-the-cluster)
- [Verify spark-master is Running](#verify-spark-master-is-running)
- [Copy the Jar](#copy-the-jar)
- [Submit the Spark Job](#submit-the-spark-job)
- [Examples](#examples)
  - [Letter Count](#letter-count)


Build the Docker Image
======================

The [Dockerfile](./Dockerfile) is a generic image that contains the Apache Spark files, and is used as the basis for both the master and worker nodes.

Build the image running the [build-image.sh](./build-image.sh) script:

```shell
./build-image.sh
```

Start the Cluster
=================

Run a local spark cluster using the provided [docker-compose.yml file](./docker-compose.yml). Here is an example of how you would start a cluster with one master node and two worker nodes:

```shell
docker-compose up --scale spark-worker=2
```


Verify spark-master is Running
==============================

Verify spark-master is running by viewing the [Spark Master WebUI](http://localhost:8080).


Copy the Jar
============

Run a spark job on your local spark cluster by submitting a job on a spark-worker node. As a convenience, the spark-worker nodes will volume mount a directory in the docker-compose.yml's current path named `jars`. Copy you Spark job's jar file into the `jars` directory:

```shell
cp ~/some-path/to/your/jar/myspark.jar ./jars/
```

Submit the Spark Job
====================

```shell
docker-compose exec --detach \
    --index=1 spark-worker \
    /spark/bin/spark-submit --master spark://spark-master:7077 \
    --class your.jobs.package.path.to.Main \
    ./jars/myspark.jar \
    <any arguments that your job requires>
```

Examples
========

Letter Count
------------

[examples/count-letters.tgz](./examples/count-letters.tgz)

The letter count example is from the [Apache Spark Quickstart](https://spark.apache.org/docs/latest/quick-start.html#self-contained-applications). 

Run the `./examples/copy-count-letters.sh` script to extract the count-letters example and copy the script, data file, and jar to the volume mount locations.

Run the `./scripts/run-example.sh` after extracting the example files.
