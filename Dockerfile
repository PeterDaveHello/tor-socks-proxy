FROM alpine:3.6

MAINTAINER Peter Dave Hello <hsu@peterdavehello.org>

RUN apk -U upgrade && \
    apk -v add tor && \
    rm -rf /var/cache/apk/*
RUN tor --version
ADD torrc /etc/tor/

EXPOSE 9150

CMD /usr/bin/tor -f /etc/tor/torrc
