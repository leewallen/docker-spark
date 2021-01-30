FROM openjdk:11.0-jdk-slim-buster


RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y wget
RUN apt-get install -y tar
RUN apt-get install -y bash
RUN apt-get install -y curl

RUN curl -OL https://mirrors.sonic.net/apache/spark/spark-3.0.1/spark-3.0.1-bin-hadoop3.2.tgz
RUN tar -xzf spark-3.0.1-bin-hadoop3.2.tgz && \
    mv spark-3.0.1-bin-hadoop3.2 /spark && \
    rm spark-3.0.1-bin-hadoop3.2.tgz

EXPOSE 8080
EXPOSE 7077

CMD ["/bin/bash", "./start.sh"]
