#!/bin/bash

docker run --rm --privileged --network=host \
           milansimanek/vtun:v1 \
           -s -f /etc/vtund-server-example.conf
