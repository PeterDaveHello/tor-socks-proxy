FROM alpine:3.7

MAINTAINER Peter Dave Hello <hsu@peterdavehello.org>

RUN echo '@edge http://dl-cdn.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories && \
    apk -U upgrade && \
    apk -v add tor@edge && \
    rm -rf /var/cache/apk/*
RUN tor --version
ADD torrc /etc/tor/

EXPOSE 9150

CMD /usr/bin/tor -f /etc/tor/torrc
