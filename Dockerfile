FROM ubuntu:14.04

ENV DEBIAN_FRONTEND=noninteractive

# Install Java
RUN apt-get update
RUN apt-get install -y python-software-properties
RUN apt-get install -y software-properties-common

RUN add-apt-repository ppa:webupd8team/java
RUN apt-get update
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get install -y oracle-java8-installer
RUN apt-get install -y oracle-java8-set-default

# Install Elasticsearch.
ENV ES_PKG_NAME elasticsearch-2.4.1

RUN groupadd -g 1000 elasticsearch && useradd elasticsearch -u 1000 -g 1000

RUN \
  cd / && \
  wget https://download.elasticsearch.org/elasticsearch/elasticsearch/$ES_PKG_NAME.tar.gz && \
  tar xvzf $ES_PKG_NAME.tar.gz && \
  rm -f $ES_PKG_NAME.tar.gz && \
  mv /$ES_PKG_NAME /elasticsearch

# Mount elasticsearch.yml config
ADD elasticsearch.yml /elasticsearch/config/elasticsearch.yml

RUN mkdir -p /elasticsearch/logs
RUN mkdir -p /elasticsearch/config
RUN mkdir -p /elasticsearch/data
RUN chown -R elasticsearch:elasticsearch /elasticsearch

USER elasticsearch

# Define default command.
CMD ["/elasticsearch/bin/elasticsearch"]

# Expose ports.
#   - 9200: HTTP
#   - 9300: transport
EXPOSE 9200
EXPOSE 9300