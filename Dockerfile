FROM ubuntu
ADD  elasticsearch/ /elasticsearch
ADD  docker-entrypoint.sh /docker-entrypoint.sh
USER root
RUN apt-get update \
    && apt-get install -y openjdk-8-jre \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*
RUN groupadd elasticsearch \
    && useradd elasticsearch -g elasticsearch -M \
    && chmod -R +x /elasticsearch \
    && chown -R elasticsearch:elasticsearch /elasticsearch \
    && chmod 777 /docker-entrypoint.sh
USER elasticsearch
EXPOSE 8200 8306 9300
ENTRYPOINT ["/docker-entrypoint.sh"]