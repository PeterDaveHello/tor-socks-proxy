FROM alpine:3.7

MAINTAINER Peter Dave Hello <hsu@peterdavehello.org>

RUN echo '@edge http://dl-cdn.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories && \
    apk -U upgrade && \
    apk -v add shadow tor@edge curl && \
    rm -rf /var/cache/apk/*
RUN tor --version && mkdir /tor && chown -Rh tor. /tor && chmod -R 700 /tor
ADD torrc /etc/tor/
ADD launch.sh /
RUN chmod u+x launch.sh

HEALTHCHECK --timeout=10s --start-period=60s \
    CMD curl --fail --socks5-hostname localhost:9150 -I -L 'https://cdnjs.com/' || exit 1

EXPOSE 9150

VOLUME ["/tor"]

CMD /launch.sh
