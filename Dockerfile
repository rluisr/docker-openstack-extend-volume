FROM jmcvea/openstack-client

MAINTAINER rluisr <detteiu.x14th@gmail.com>

LABEL Description="Openstack extend volume" Version="1.0"

RUN apk add --update \
  jq \
  && rm -rf /var/cache/apk/*

COPY . /
ENTRYPOINT ["sh", "/openstack-extend-volume.sh"]
