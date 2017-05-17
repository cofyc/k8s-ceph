FROM ubuntu:16.04

RUN apt-get update \
 && apt-get install -y fio \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

Add jobfiles /jobfiles
