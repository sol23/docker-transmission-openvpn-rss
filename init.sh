#!/bin/sh
mkdir /data/transmission-rss
mkdir /data/transmission-home 
[ ! -f /data/transmission-rss/seen ] && echo > /data/transmission-rss/seen
[ ! -f /data/transmission-rss/transmission-rss.log ] && echo > /data/transmission-rss/transmission-rss.log