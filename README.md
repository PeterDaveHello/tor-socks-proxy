<p align="center">
  <img width="300px" src="https://upload.wikimedia.org/wikipedia/commons/8/8f/Tor_project_logo_hq.png">
</p>

# Tor-socks-proxy

![license](https://img.shields.io/badge/license-GPLv3.0-brightgreen.svg?style=flat)
[![Build Status](https://app.travis-ci.com/PeterDaveHello/tor-socks-proxy.svg?branch=master)](https://app.travis-ci.com/PeterDaveHello/tor-socks-proxy)
[![Docker Hub pulls](https://img.shields.io/docker/pulls/peterdavehello/tor-socks-proxy.svg)](https://hub.docker.com/r/peterdavehello/tor-socks-proxy/)

[![Docker Hub badge](http://dockeri.co/image/peterdavehello/tor-socks-proxy)](https://hub.docker.com/r/peterdavehello/tor-socks-proxy/)

The super easy way to set up a [Tor](https://www.torproject.org) [SOCKS5](https://en.wikipedia.org/wiki/SOCKS#SOCKS5) [proxy server](https://en.wikipedia.org/wiki/Proxy_server) inside a [Docker](https://en.wikipedia.org/wiki/Docker_(software)) [container](https://en.wikipedia.org/wiki/Container_(virtualization)), without Tor relay/exit node function enabled.

## Docker image Repository

We push the built image to Docker Hub and GitHub Container Registry:

- GitHub Container Registry:
  - `ghcr.io/peterdavehello/tor-socks-proxy`
  - <https://github.com/PeterDaveHello/tor-socks-proxy/pkgs/container/tor-socks-proxy>
- Docker Hub:
  - `peterdavehello/tor-socks-proxy`
  - <https://hub.docker.com/r/peterdavehello/tor-socks-proxy/>

Use the prefix `ghcr.io/` if you prefer to use GitHub Container Registry.

## Usage

### First-Time Setup

```sh
docker run -d --restart=always --name tor-socks-proxy -p 127.0.0.1:9150:9150/tcp peterdavehello/tor-socks-proxy:latest
```

- `--restart=always`: This ensures the container automatically restarts whenever the system reboots.
- `-p 127.0.0.1:9150:9150/tcp`: This binds the container to localhost, and you should not change this IP unless you want to expose the proxy to a local network or the Internet.
  - You can change the first `9150` to any available port. Please note that ports `9050`/`9150` may be occupied if you are running another Tor client like TorBrowser.

### Start or stop an existing Instance manually

```sh
docker start tor-socks-proxy
```

```sh
docker stop tor-socks-proxy
```

### Checking the Proxy Status and logs

```sh
docker logs tor-socks-proxy
```

### Configuring a Client to Use the Proxy

```sh
curl --socks5-hostname 127.0.0.1:9150 https://ipinfo.tw/ip
```

### Stopping the Proxy

```sh
docker stop tor-socks-proxy
```

## IP Renewal

By default, Tor automatically changes IPs every 10 minutes. You can manually renew the IP by restarting the container:

```sh
docker restart tor-socks-proxy
```

## DNS over Tor

Publish DNS port during setup to query DNS requests over Tor:

```sh
docker run -d --restart=always --name tor-socks-proxy -p 127.0.0.1:9150:9150/tcp -p 127.0.0.1:53:8853/udp peterdavehello/tor-socks-proxy:latest
```

## Support Tor Project

Support the Tor project by [setting up Tor bridge/exit nodes](https://trac.torproject.org/projects/tor/wiki/TorRelayGuide) and [donating](https://donate.torproject.org/).
