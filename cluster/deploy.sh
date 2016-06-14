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
#   
# 获取当前目录路径
cd `dirname $0`
path=$PWD

#进入相应的目录
cd "$path/$1"
docker-compose up -d
#
# docker exec rabbit2_rabbit2_1 rabbitmqctl stop_app
# docker exec rabbit2_rabbit2_1 rabbitmqctl join_cluster rabbit@rabbit1
# docker exec rabbit2_rabbit2_1 rabbitmqctl start_app
