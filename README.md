
# OpenVPN options
This is taken from the base image:
https://github.com/haugene/docker-transmission-openvpn

Docker container which runs Transmission torrent client with WebUI while connecting to OpenVPN.
It bundles certificates and configurations for the following VPN providers:

| Provider Name                | Config Value |
|:-----------------------------|:-------------|
| Anonine | `ANONINE` |
| BTGuard | `BTGUARD` |
| Cryptostorm | `CRYPTOSTORM` |
| FrootVPN | `FROOT` |
| FrostVPN | `FROSTVPN` |
| Giganews | `GIGANEWS` |
| HideMe | `HIDEME` |
| HideMyAss | `HIDEMYASS` |
| IntegrityVPN | `INTEGRITYVPN` |
| IPVanish | `IPVANISH` |
| Ivacy | `IVACY` |
| IVPN | `IVPN` |
| Newshosting | `NEWSHOSTING` |
| NordVPN | `NORDVPN` |
| OVPN | `OVPN` |
| Private Internet Access | `PIA` |
| PrivateVPN | `PRIVATEVPN` |
| PureVPN | `PUREVPN` |
| RA4W VPN | `RA4W` |
| SlickVPN | `SLICKVPN` |
| SmartVPN | `SMARTVPN` |
| TigerVPN | `TIGER` |
| TorGuard | `TORGUARD` |
| UsenetServerVPN | `USENETSERVER` |
| Windscribe | `WINDSCRIBE` |
| VPN.ht | `VPNHT` |
| VPNBook.com | `VPNBOOK` |
| VyprVpn | `VYPRVPN` |
When using PIA as provider it will update Transmission hourly with assigned open port. Please read the instructions below.

## Run container from Docker registry
The container is available from the Docker registry and this is the simplest way to get it.
To run the container use this command:

```
$ docker run --privileged  -d \
              -v /your/storage/path/:/data \
              -v /etc/localtime:/etc/localtime:ro \
              -e "OPENVPN_PROVIDER=PIA" \
              -e "OPENVPN_CONFIG=Netherlands" \
              -e "OPENVPN_USERNAME=user" \
              -e "OPENVPN_PASSWORD=pass" \
              -p 9091:9091 \
              sol23/transmission-openvpn-rss
```

You must set the environment variables `OPENVPN_PROVIDER`, `OPENVPN_USERNAME` and `OPENVPN_PASSWORD` to provide basic connection details.

The `OPENVPN_CONFIG` is an optional variable. If no config is given, a default config will be selected for the provider you have chosen.
Find available OpenVPN configurations by looking in the openvpn folder of the GitHub repository.

As you can see, the container also expects a data volume to be mounted.
This is where Transmission will store your downloads, incomplete downloads and look for a watch directory for new .torrent files.
By default a folder named transmission-home will also be created under /data, this is where Transmission stores its state.


### Required environment options
| Variable | Function | Example |
|----------|----------|-------|
|`OPENVPN_PROVIDER` | Sets the OpenVPN provider to use. | `OPENVPN_PROVIDER=provider`. Supported providers and their config values are listed in the table above. |
|`OPENVPN_USERNAME`|Your OpenVPN username |`OPENVPN_USERNAME=asdf`|
|`OPENVPN_PASSWORD`|Your OpenVPN password |`OPENVPN_PASSWORD=asdf`|

### Network configuration options
| Variable | Function | Example |
|----------|----------|-------|
|`OPENVPN_CONFIG` | Sets the OpenVPN endpoint to connect to. | `OPENVPN_CONFIG=UK Southampton`|
|`OPENVPN_OPTS` | Will be passed to OpenVPN on startup | See [OpenVPN doc](https://openvpn.net/index.php/open-source/documentation/manuals/65-openvpn-20x-manpage.html) |
|`LOCAL_NETWORK` | Sets the local network that should have access. | `LOCAL_NETWORK=192.168.0.0/24`|

### Transmission configuration options

You may override transmission options by setting the appropriate environment variable.

The environment variables are the same name as used in the transmission settings.json file
and follow the format given in these examples:

| Transmission variable name | Environment variable name |
|----------------------------|---------------------------|
| `speed-limit-up` | `TRANSMISSION_SPEED_LIMIT_UP` |
| `speed-limit-up-enabled` | `TRANSMISSION_SPEED_LIMIT_UP_ENABLED` |
| `ratio-limit` | `TRANSMISSION_RATIO_LIMIT` |
| `ratio-limit-enabled` | `TRANSMISSION_RATIO_LIMIT_ENABLED` |

As you can see the variables are prefixed with `TRANSMISSION_`, the variable is capitalized, and `-` is converted to `_`.

PS: `TRANSMISSION_BIND_ADDRESS_IPV4` will be overridden to the IP assigned to your OpenVPN tunnel interface.
This is to prevent leaking the host IP.

### User configuration options

By default everything will run as the root user. However, it is possible to change who runs the transmission process. 
You may set the following parameters to customize the user id that runs transmission.

| Variable | Function | Example |
|----------|----------|-------|
|`PUID` | Sets the user id who will run transmission | `PUID=1003`|
|`PGID` | Sets the group id for the transmission user | `PGID=1003` |

# RSS options
The following configuration file example contains every existing option
It uses the transmission RSS tool: https://github.com/nning/transmission-rss

The config.yml file needs to be located at `/data/transmission-rss/config.yml`

    feeds:
      - url: http://example.com/feed1
      - url: http://example.com/feed2
      - url: http://example.com/feed3
        regexp: match1
      - url: http://example.com/feed4
        regexp: (match1|match2)
      - url: http://example.com/feed4
        download_path: /home/user/Downloads
      - url: http://example.com/feed4
        seed_ratio_limit: 1
      - url: http://example.com/feed4
        regexp:
          - match1
          - match2
      - url: http://example.com/feed5
        regexp:
          - matcher: match1
            download_path: /home/user/match1
          - matcher: match2
            download_path: /home/user/match2

    update_interval: 600

    add_paused: false