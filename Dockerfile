FROM alpine:3.8

LABEL maintainer="Peter Dave Hello <hsu@peterdavehello.org>"
LABEL name="tor-socks-proxy"
LABEL version="latest"

RUN echo '@edge http://dl-cdn.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories && \
    apk -U upgrade && \
    apk -v add tor@edge curl && \
    rm -rf /var/cache/apk/*
RUN tor --version
COPY torrc /etc/tor/

HEALTHCHECK --timeout=10s --start-period=60s \
    CMD curl --fail --socks5-hostname localhost:9150 -I -L 'https://cdnjs.com/' || exit 1

EXPOSE 9150

CMD ["/usr/bin/tor", "-f", "/etc/tor/torrc"]
