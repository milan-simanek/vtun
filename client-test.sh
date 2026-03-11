#!/bin/bash
docker run --rm --privileged --network=host \
       milansimanek/vtun:v1 \
       -p -f /etc/vtund-client-example.conf example localhost
