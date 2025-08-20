FROM b2bwebid/r-quant:2025.2
LABEL MAINTAINER="B2B.Web.ID Data Analytics Platform Labs"
ENV RSTUDIO="2025.05.1-513"
RUN apt update && apt upgrade -y && \
    apt install -y locales apt-utils wget libprotobuf-dev protobuf-compiler apache2 apache2-dev ssl-cert libapparmor-dev libcurl4-openssl-dev libssl-dev \
     libxml2-dev libssh2-1-dev libcairo2-dev xvfb xfonts-base debhelper zlib1g-dev gdebi-core git sudo && \
    apt clean && \
    localedef -i en_US -f UTF-8 en_US.UTF-8
RUN wget --quiet https://download2.rstudio.org/server/jammy/amd64/rstudio-server-${RSTUDIO}-amd64.deb && \
  gdebi --non-interactive rstudio-server-${RSTUDIO}-amd64.deb && \
  rm -f rstudio-server-${RSTUDIO}-amd64.deb && \
  echo "server-app-armor-enabled=0" >> /etc/rstudio/rserver.conf && \
  apt install -f && apt clean
RUN Rscript --verbose -e 'update.packages(ask=F, repo="https://cran.rstudio.com")'
RUN Rscript --verbose -e 'install.packages(c("purrr","vctrs","dplyr","dbplyr","openssl","rvest","gargle","vroom","googlesheets4","readxl","reprex","tidyverse"))'
EXPOSE 8787
VOLUME /home/rstudio
CMD ["/init"]
