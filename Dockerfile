FROM haugene/transmission-openvpn:3.2

RUN apk add --update make ruby ruby-dev build-base supervisor

RUN gem install transmission-rss

RUN apk del build-base

ENV XDG_CONFIG_HOME=/data/

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY transmission-rss.conf /etc/transmission-rss.conf
COPY init.sh /

CMD ["/usr/bin/supervisord"]
