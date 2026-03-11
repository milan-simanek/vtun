#!/bin/bash

[ -z "$1" ] && echo "This script requires IP address of the server as a parameter" && exit
SERVERIP="$1"
if ! ping -c1 "$SERVERIP" &>/dev/null 
then
  echo "ping to $SERVERIP failed."
  exit 2
fi

set -e

namespace=vtun

kubectl apply -f ns.yaml

kubectl -n "$namespace" create --dry-run=client -o yaml secret generic config \
   --from-file vtund-client.conf | kubectl apply -f -

cat client.yaml | sed "s/SERVERIP/$SERVERIP/g" | kubectl apply -f -

echo OK
