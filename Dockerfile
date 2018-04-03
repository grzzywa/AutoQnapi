FROM debian:9
MAINTAINER grzzywa

VOLUME /data

RUN \
 apt-get update \
 && apt-get install qnapi file -y

COPY run.sh /run.sh

ENTRYPOINT ["/bin/sh /run.sh"]
