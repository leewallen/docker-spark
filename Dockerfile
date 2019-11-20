FROM openjdk:8-alpine

RUN apk --update add wget tar bash
RUN wget http://apache.mirror.anlx.net/spark/spark-2.4.4/spark-2.4.4-bin-hadoop2.7.tgz
RUN tar -xzf spark-2.4.4-bin-hadoop2.7.tgz && \
    mv spark-2.4.4-bin-hadoop2.7 /spark && \
    rm spark-2.4.4-bin-hadoop2.7.tgz

COPY ./scripts/start.sh /start.sh

RUN chmod +x /start.sh

EXPOSE 8080
EXPOSE 7077

CMD ["/bin/bash", "./start.sh"]
