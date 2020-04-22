# docker-spark

The docker-spark repo can be used for running spark locally for general purpose spark jobs, but is best used for integration / performance testing in a controlled environment before sending the spark job to a cluster.

## Usage

### Build the Docker Image

Build the image running the [build-image.sh](./build-images.sh) script:

```shell
./build-image.sh
```

### Start the Cluster

Run a local spark cluster using the provided [docker-compose.yml file](./docker-compose.yml). Here is an example of how you would start a cluster with one master node and two worker nodes:

```shell
docker-compose up --scale spark-worker=2
```

### Verify spark-master is Running

Verify spark-master is running by viewing the [Spark Master WebUI](http://localhost:8080).

### Copy the Spark Job's Jar

Run a spark job on your local spark cluster by submitting a job on a spark-worker node. As a convenience, the spark-worker nodes will volume mount a directory in the docker-compose.yml's current path named `jars`. Copy you Spark job's jar file into the `jars` directory:

```shell
cp ~/some-path/to/your/jar/myspark.jar ./jars/
```

### Submit the Spark Job to the Cluster

```shell
docker-compose exec --detach \
    --index=1 spark-worker \
    /spark/bin/spark-submit --master spark://spark-master:7077 \
    --class your.jobs.package.path.to.Main \
    ./jars/myspark.jar \
    <any arguments that your job requires>
```

