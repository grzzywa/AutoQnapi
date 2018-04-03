# FROM alpine:3.5
#
# # ENTRYPOINT ["/bin/sh"]
# RUN   apk update \
#  &&   apk add ca-certificates wget curl\
#  &&   update-ca-certificates
#
# RUN apk add g++ make p7zip
#
#
# RUN wget https://github.com/QNapi/qnapi/releases/download/0.2.3/qnapi-0.2.3.tar.
# gz \
#  && tar -xvzf qnapi-0.2.3.tar.gz \
#  && cd qnapi-0.2.3



FROM debian:9

RUN \
 apt-get update \
 && apt-get install qnapi file -y

COPY run.sh /run.sh

VOLUME /data

ENTRYPOINT ["/bin/sh /run.sh"]
