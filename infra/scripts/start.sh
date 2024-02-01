#!/bin/bash
set -e
k3d cluster create --config /etc/k3dconfig.yml
sed -i -E 's/server:(.*):\d+/server: \1:6443/g' ~/.kube/config
echo "Everything is good to go!"