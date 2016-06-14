#!/bin/bash
# echo "OPTIND starts at $OPTIND"
# while getopts ":pq:" optname
#   do
#     case "$optname" in
#       "p")
#         echo "Option $optname is specified"
#         ;;
#       "q")
#         echo "Option $optname has value $OPTARG"
#         ;;
#       "?")
#         echo "Unknown option $OPTARG"
#         ;;
#       ":")
#         echo "No argument value for option $OPTARG"
#         ;;
#       *)
#       # Should not occur
#         echo "Unknown error while processing options"
#         ;;
#     esac
#     echo "OPTIND is now $OPTIND"
#   done

touch /etc/hosts
grep "rabbit" /etc/hosts
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

cd "$1"
docker-compose up -d
# 
# docker exec rabbit2_rabbit2_1 rabbitmqctl stop_app
# docker exec rabbit2_rabbit2_1 rabbitmqctl join_cluster rabbit@rabbit1
# docker exec rabbit2_rabbit2_1 rabbitmqctl start_app
