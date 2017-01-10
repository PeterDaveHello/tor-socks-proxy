tor-socks-proxy
=======

![license](https://img.shields.io/badge/license-GPLv3.0-brightgreen.svg?style=flat) ![](https://img.shields.io/docker/pulls/peterdavehello/tor-socks-proxy.svg) ![](https://images.microbadger.com/badges/image/peterdavehello/tor-socks-proxy.svg) ![](https://images.microbadger.com/badges/version/peterdavehello/tor-socks-proxy.svg)

The super easy way to setup a tor SOCKS5 proxy server without relay/exit feature.

## How to use?

1. Setup the proxy server at the **first time**
    ```sh
    $ docker run -d --name tor_socks_proxy -p 127.0.0.1:9150:9150 peterdavehello/tor-socks-proxy:latest
    ```

    If you already setup the instance before*(not the first time)*, just start it:
    ```
    $ docker start tor_socks_proxy
    ```

2. Make sure it's running
    ```
    $ docker logs tor_socks_proxy
    .
    .
    .
    Jan 10 01:06:59.000 [notice] Bootstrapped 85%: Finishing handshake with first hop
    Jan 10 01:07:00.000 [notice] Bootstrapped 90%: Establishing a Tor circuit
    Jan 10 01:07:02.000 [notice] Tor has successfully opened a circuit. Looks like client functionality is working.
    Jan 10 01:07:02.000 [notice] Bootstrapped 100%: Done
    ```

3. Configure your client to use it, target on `127.0.0.1` port `9150`

4. After using it, you can turn it off
    ```sh
    $ docker stop tor_socks_proxy
    ```
