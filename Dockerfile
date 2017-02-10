FROM rocker/rstudio:latest
MAINTAINER B2B.Web.ID Data Analytics Platform Labs
COPY root/clouderaimpalaodbc_2.5.32.1002-2_amd64.deb /root
COPY root/installpackages.R /root
RUN apt-get update && \
 apt-get install -y \
  unixodbc unixodbc-dev \
  git \
  libsasl2-modules-gssapi-mit && \
 apt-get install -y \
  openjdk-7-jdk && \
 dpkg -i /root/clouderaimpalaodbc_2.5.32.1002-2_amd64.deb && \
 rm /root/clouderaimpalaodbc_2.5.32.1002-2_amd64.deb && \
 apt-get autoremove -y && \
 apt-get clean && \
 Rscript --verbose /root/installpackages.R
COPY root/odbc.sh /etc/profile.d/
COPY root/odbcinst.ini /etc/
RUN cd /opt && \
    wget http://d3kbcqa49mib13.cloudfront.net/spark-2.0.1-bin-hadoop2.7.tgz && \
    tar -xvzf spark-2.0.1-bin-hadoop2.7.tgz && \
rm spark-2.0.1-bin-hadoop2.7.tgz
EXPOSE 8787
EXPOSE 7077
VOLUME /home/rstudio
CMD ["/init"]
