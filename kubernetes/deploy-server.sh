#!/bin/bash

set -e

namespace=vtun

kubectl apply -f ns.yaml

kubectl -n "$namespace" create --dry-run=client -o yaml secret generic config \
   --from-file vtund-server.conf | kubectl apply -f -

kubectl apply -f server.yaml

echo OK
