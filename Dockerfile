FROM rocker/rstudio:latest
MAINTAINER B2B.Web.ID Data Analytics Platform Labs
COPY root/installpackages.R /root
RUN apt-get update && \
 apt-get install -y \
  unixodbc unixodbc-dev \
  git \
  libsasl2-modules-gssapi-mit && \
 apt-get autoremove -y && \
 apt-get clean && \
 Rscript --verbose /root/installpackages.R
RUN wget https://downloads.cloudera.com/connectors/impala_odbc_2.5.35.1006/Debian/clouderaimpalaodbc_2.5.35.1006-2_amd64.deb && \
 dpkg -i clouderaimpalaodbc_2.5.35.1006-2_amd64.deb && \
 rm clouderaimpalaodbc_2.5.35.1006-2_amd64.deb && \
COPY root/odbc.sh /etc/profile.d/
COPY root/odbcinst.ini /etc/
EXPOSE 8787
VOLUME /home/rstudio
CMD ["/init"]
