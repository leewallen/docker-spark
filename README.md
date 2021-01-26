# docker-spark

The docker-spark repo can be used for running spark locally for general purpose spark jobs, but is best used for integration / performance testing in a controlled environment before sending the spark job to a cluster.

- [docker-spark](#docker-spark)
  - [Usage](#usage)
    - [Build the Docker Image](#build-the-docker-image)
    - [Start Cluster](#start-cluster)
    - [Verify spark-master is Running](#verify-spark-master-is-running)
    - [Submit the Spark Job](#submit-the-spark-job)
  - [Letter Count Example](#letter-count-example)
## Usage




### Build the Docker Image

The [Dockerfile](./Dockerfile) is a generic image that contains the Apache Spark files, and is used as the basis for both the master and worker nodes.

Build the image running the [build-image.sh](./build-image.sh) script:

```shell
./build-image.sh
```

### Start Cluster

Run a local spark cluster using the provided [docker-compose.yml file](./docker-compose.yml). Here is an example of how you would start a cluster with one master node and two worker nodes:

**Run with one Task Worker**
```shell
docker-compose up --detach
```

**Run with two Task Workers**
```shell
docker-compose up --scale spark-worker=2 --detach
```

As a convenience, the docker-compose.yml has the following volume mount points defined:

* ./jars
* ./data
* ./scripts-master
* ./scripts-worker

### Verify spark-master is Running

Verify spark-master is running by viewing the [Spark Master WebUI](http://localhost:8080).


### Submit the Spark Job

You can run a spark job on your local spark cluster by submitting a job. 

If you don't want to create a `jars` directory from the directory where the docker-compose.yml resides, then update the docker-compose.yml's `spark-worker` service volume mapping to point to wherever you want your local job's jar file to be found.

**Current:**
```yaml
volumes:
      - ./data:/data
      - ./scripts-worker/start-worker.sh:/scripts/start.sh
      - ./jars:/jars
```

**Updated:**
```yaml
volumes:
      - ./data:/data
      - ./scripts-worker/start-worker.sh:/scripts/start.sh
      - ./your/directory/with/your/jar/somesparkjob.jar:/jars/yoursparkjob.jar
```

```shell
docker-compose exec --detach \
    --index=1 spark-worker \
    /spark/bin/spark-submit --master spark://spark-master:7077 \
    --class your.jobs.package.path.to.Main \
    ./jars/yoursparkjob.jar \
    <any arguments that your job requires>
```

## Letter Count Example


The letter count example is based on the example from the [Apache Spark Quick Start](https://spark.apache.org/docs/latest/quick-start.html#self-contained-applications). 

From within the `./examples` directory, run the example app:

```shell
examples # ./run-example.sh
```

The shell script will build the jar file, run `docker-compose up`, and submit the spark job. The example assumes you have OpenJDK Java 11 and maven installed.
