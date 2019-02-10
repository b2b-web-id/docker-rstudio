FROM rocker/rstudio:latest
MAINTAINER B2B.Web.ID Data Analytics Platform Labs
ADD root/ /root
ENV RISET_HOST=http://riset.b2b.web.id
ENV IMPALA_PKG=clouderaimpalaodbc_2.6.0.1000-2_amd64.deb
RUN apt-get update && \
 apt-get install -y git \
  unixodbc unixodbc-dev \
  libpq-dev libmariadb-client-dev && \
  libsasl2-modules-gssapi-mit && \
 apt-get install -y \
  openjdk-7-jdk && \
 wget $RISET_HOST/$IMPALA_PKG -O /root/$IMPALA_PKG && \
 dpkg -i /root/$IMPALA_PKG && rm /root/$IMPALA_PKG && \
 apt-get autoremove -y && \
 apt-get clean && \
 Rscript --verbose /root/installpackages.R
RUN cp /root/odbc.sh /etc/profile.d/ && \
    cp /root/odbcinst.ini /etc/ && \
EXPOSE 8787
VOLUME /home/rstudio
CMD ["/init"]
