# docker-spark

This can be use for running spark locally for general purposes.

Build the image running the build-image.sh script:
```shell
./build-image.sh
```

Run a local spark cluster using docker-compose. Here is an example of running a cluster with one master node and two worker nodes:
```shell
./docker-compose up --scale spark-worker=2
```

Verify spark-master is running by viewing the [Spark Master WebUI](http://localhost:8080).

Run a spark job on your local spark cluster by submitting a job on a spark-worker node. As a convenience, the spark-worker nodes will volume mount a directory in your current path named `jars`. Copy a jar file containing your spark job into the `jars` directory prior to running `docker-compose up`:
```shell

# First, copy your jar file
cp ~/some-path/to/your/jar/myspark.jar ./jars/

# Now run docker-compose up
docker-compose up --scale spark-worker=2

# And then submit the job in detached mode to the first spark-worker
docker-compose exec --detach --index=1 spark-worker /spark/bin/spark-submit --master spark://spark-master:7077 --class your.jobs.package.path.to.Main ./jars/myspark.jar <any arguments that your job requires>
```

