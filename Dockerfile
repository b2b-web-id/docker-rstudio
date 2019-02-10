FROM rocker/rstudio:latest
MAINTAINER B2B.Web.ID Data Analytics Platform Labs
ADD root/ /root
RUN apt-get update && \
 apt-get install -y \
  unixodbc unixodbc-dev \
  git \
  libpq-dev libmariadb-client-dev && \
  libsasl2-modules-gssapi-mit && \
 apt-get install -y \
  openjdk-7-jdk && \
 dpkg -i /root/clouderaimpalaodbc_2.6.0.1000-2_amd64.deb && \
 rm /root/clouderaimpalaodbc_2.6.0.1000-2_amd64.deb && \
 apt-get autoremove -y && \
 apt-get clean && \
 Rscript --verbose /root/installpackages.R
ENV SPARK_URL=https://www-eu.apache.org/dist/spark/spark-2.4.0
ENV SPARK_BIN=spark-2.4.0-bin-without-hadoop.tgz
ENV SPARK_R=SparkR_2.4.0.tar.gz
RUN cp /root/odbc.sh /etc/profile.d/ && \
    cp /root/odbcinst.ini /etc/ && \
    cd /opt && \
    wget $SPARK_URL/$SPARK_BIN && tar -xvzf $SPARK_URL/$SPARK_BIN && \
    wget $SPARK_URL/$SPARK_R && tar -xvzf $SPARK_URL/$SPARK_R && \
    rm $SPARK_BIN $SPARK_R
EXPOSE 8787
EXPOSE 7077
VOLUME /home/rstudio
CMD ["/init"]
