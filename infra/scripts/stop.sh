#!/bin/bash
set -e
k3d cluster delete --config /etc/k3dconfig.yml
echo "Server is shut down"