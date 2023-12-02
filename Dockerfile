# Dockerfile for Tor Relay Server with obfs4proxy (Multi-Stage build)
FROM golang:alpine AS go-build


# Install Go for building obfs4proxy.
RUN apk --no-cache add --update go git  ca-certificates
RUN mkdir -p /go/src /go/bin
RUN chmod -R 644 /go
ENV GOPATH /go
ENV PATH /go/bin:$PATH
WORKDIR /go
# Build /go/bin/obfs4proxy & /go/bin/meek-server
RUN go install -v gitlab.com/yawning/obfs4.git/obfs4proxy@latest \
    && go install -v git.torproject.org/pluggable-transports/meek.git/meek-server@latest 

# Copy the binaries to /usr/local/bin
RUN cp /go/bin/* /usr/local/bin/

FROM alpine:3.18

LABEL maintainer="Peter Dave Hello <hsu@peterdavehello.org>"
LABEL name="tor-socks-proxy"
LABEL version="latest"

RUN echo '@edge https://dl-cdn.alpinelinux.org/alpine/edge/community' >> /etc/apk/repositories && \
    echo '@edge https://dl-cdn.alpinelinux.org/alpine/edge/testing'   >> /etc/apk/repositories && \
    apk -U upgrade && \
    apk -v add tor@edge curl && \
    chmod 700 /var/lib/tor && \
    rm -rf /var/cache/apk/* && \
    tor --version
COPY --chown=tor:root torrc /etc/tor/

# Copy obfs4proxy & meek-server
COPY --from=go-build /usr/local/bin/ /usr/local/bin/

HEALTHCHECK --timeout=10s --start-period=60s \
    CMD curl --fail --socks5-hostname localhost:9150 -I -L 'https://www.facebookwkhpilnemxj7asaniu7vnjjbiltxjqhye3mhbshg7kx5tfyd.onion/' || exit 1

USER tor
EXPOSE 8853/udp 9150/tcp

CMD ["/usr/bin/tor", "-f", "/etc/tor/torrc"]
