#!/bin/bash
docker exec "$1_$1_1" touch /etc/hosts
docker exec "$1_$1_1" grep "rabbit1" /etc/hosts
if [ $? -ne 0 ]; then
  echo "hosts not exist"
  chmod 777 /etc/hosts
  echo "139.59.240.247 rabbit1" >> /etc/hosts
  echo "139.59.240.230 rabbit2" >> /etc/hosts
  echo "188.166.183.42 rabbit3" >> /etc/hosts
  sync
else
  echo "hosts exist"
fi
