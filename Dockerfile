FROM debian:9

RUN \
 apt-get update \
 && apt-get install qnapi file -y

COPY run.sh /run.sh

VOLUME /data

ENTRYPOINT ["/bin/sh /run.sh"]
