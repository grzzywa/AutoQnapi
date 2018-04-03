FROM debian:9

RUN \
 apt-get update \
 && apt-get install qnapi file -y

COPY run.sh /run.sh
RUN chmod 700 /run.sh

VOLUME /data

CMD ["/run.sh"]
