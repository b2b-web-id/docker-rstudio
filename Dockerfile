FROM rocker/rstudio:latest
MAINTAINER B2B.Web.ID Data Analytics Platform Labs
RUN apt update && apt install -y zlib1g-dev && apt clean
RUN Rscript --verbose -e 'update.packages(ask=F, repo="https://cran.rstudio.com")'
RUN Rscript --verbose -e 'install.packages(c("purrr","vctrs","dplyr","dbplyr","openssl","rvest","gargle","vroom","googlesheets4","readxl","reprex","tidyverse"))'
EXPOSE 8787
VOLUME /home/rstudio
CMD ["/init"]
