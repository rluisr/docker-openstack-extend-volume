docker-openstack-extend-volume
==============================

extend boot volume.

Usage
-----

```
$ docker run --rm \
  -e OS_AUTH_URL= \
  -e OS_PROJECT_NAME= \
  -e OS_PROJECT_ID= \
  -e OS_USER_DOMAIN_NAME= \
  -e OS_USERNAME= \
  -e OS_PASSWORD= \
  -e OS_REGION_NAME=RegionOne \
  -e OS_INTERFACE=public \
  -e OS_IDENTITY_API_VERSION=3 \
  -e HOST_NAME= \
  -e TARGET_SIZE= \
  -i rluisr/openstack-extend-volume:1.0
```

| Environment | Comment                                                                   |
|:-----------:| ------------------------------------------------------------------------- |
| TARGET_SIZE | target volume size                                                        |
