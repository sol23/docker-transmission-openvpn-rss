
### RSS options
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

    server:
      host: localhost
      port: 9091
      rpc_path: /transmission/rpc

    login:
      username: transmission
      password: transmission

    log_target: /var/log/transmissiond-rss.log

    privileges:
      user: nobody
      group: nobody

    fork: false

    pid_file: false

    seen_file: ~/.config/transmission/seen