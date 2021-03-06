FROM docker.io/anapsix/docker-oracle-java8

MAINTAINER Zak Hassan zak.hassan1010@gmail.com
RUN wget http://apache.mirror.vexxhost.com/cassandra/3.7/apache-cassandra-3.7-bin.tar.gz && tar xvzf apache-cassandra-3.7-bin.tar.gz -C /usr/local/  && rm apache-cassandra-3.7-bin.tar.gz
# /usr/bin/curl -s  | tar -xz

#RUN groupadd hadoop
RUN adduser hadoop --disabled-password

RUN cd /usr/local &&  mv /usr/local/apache-cassandra-3.7  /usr/local/cassandra && chown -Rv hadoop /usr/local/cassandra

USER hadoop

ENV CASSANDRA_HOME /usr/local/cassandra

#COPY ./conf/cassandra.yaml  /usr/local/cassandra/conf/
#COPY ./conf/cassandra-env.sh  /usr/local/cassandra/conf/

COPY entrypoint.sh /etc/entrypoint.sh

ENV PATH $PATH:$CASSANDRA_HOME/bin

EXPOSE 7199 7000 7001 9160 9042 22 8012 61621

ENTRYPOINT ["/etc/entrypoint.sh"]
