#!/bin/bash

set -e

readonly HOST_NAME="${HOST_NAME}"
readonly TARGET_SIZE=${TARGET_SIZE}

server_result=$( openstack server show ${HOST_NAME} -f json )

server_id=$( echo "${server_result}" | jq -r '.id' )
server_status=$( echo "${server_result}" | jq -r '.status' )
volume_id=$( echo "${server_result}" | jq -r '.volumes_attached' | sed -e 's/id=//g' | sed -e "s/'//g" )
current_size=$( openstack volume show ${volume_id} -f json | jq -r '.size' )

if [ ${current_size} -eq ${TARGET_SIZE} ]; then
  echo "target volume size is ${TARGET_SIZE}"
  exit 0
fi

if [ ${server_status} == "ACTIVE" ]; then
  openstack server stop "${server_id}"

  while :
  do
    status=$( openstack server show "${server_id}" -f json | jq -r .status )

    if [ ${status} == "SHUTOFF" ]; then
      break
    fi
  done
fi

cinder --os-volume-api-version 3.50 extend "${volume_id}" ${TARGET_SIZE}

openstack server start "${server_id}"

while :
do
  status=$( openstack server show "${server_id}" -f json | jq -r .status )

  if [ ${status} == "ACTIVE" ]; then
    break
  fi
done

echo "ok"
