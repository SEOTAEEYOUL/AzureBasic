#!/usr/bin/bash

. ./podman.env

echo "podman login $loginServer -u 00000000-0000-0000-0000-000000000000 -p $accessToken"
# echo "podman login $loginServer -u 00000000-0000-0000-0000-000000000000 -p \"$accessToken\""
podman login $loginServer -u '00000000-0000-0000-0000-000000000000' -p "${accessToken}"
