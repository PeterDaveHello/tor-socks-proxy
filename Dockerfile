FROM golang:alpine AS go-build

# Install Go for building obfs4proxy.
RUN apk --no-cache --update add go git ca-certificates \
    && mkdir -p /go/src /go/bin \
    && chmod -R 644 /go 

ENV GOPATH /go
ENV PATH /go/bin:$PATH
WORKDIR /go

# Build /go/bin/obfs4proxy
RUN go install -v gitlab.com/yawning/obfs4.git/obfs4proxy@latest

# Copy the binaries to /usr/local/bin
RUN cp /go/bin/* /usr/local/bin/

FROM alpine:3.18

LABEL maintainer="Peter Dave Hello <hsu@peterdavehello.org>"
LABEL name="tor-socks-proxy"
LABEL version="latest"

RUN echo '@edge https://dl-cdn.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories && \
    echo '@edge https://dl-cdn.alpinelinux.org/alpine/edge/testing'   >> /etc/apk/repositories && \
    apk -v --no-cache --update add tor@edge curl && \
    chmod 700 /var/lib/tor && \
    mkdir -p /etc/tor/torrc.d && \
    tor --version
COPY --chown=tor:root torrc /etc/tor/

# Copy obfs4proxy & meek-server
COPY --from=go-build /usr/local/bin/ /usr/local/bin/

HEALTHCHECK --timeout=10s --start-period=60s \
    CMD curl --fail --socks5-hostname localhost:9150 -I -L 'https://www.facebookwkhpilnemxj7asaniu7vnjjbiltxjqhye3mhbshg7kx5tfyd.onion/' || exit 1

USER tor
EXPOSE 8853/udp 9150/tcp

CMD ["/usr/bin/tor", "-f", "/etc/tor/torrc"]
