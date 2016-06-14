#!/bin/bash
#
echo "hosting"
touch /etc/hosts
grep "rabbit1" /etc/hosts
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

if [ -z "$CLUSTERED" ]; then
	# if not clustered then start it normally as if it is a single server
	/usr/sbin/rabbitmq-server
else
	if [ -z "$CLUSTER_WITH" ]; then
		# If clustered, but cluster with is not specified then again start normally, could be the first server in the
		# cluster
		/usr/sbin/rabbitmq-server
	else
		/usr/sbin/rabbitmq-server -detached
		rabbitmqctl stop_app
		if [ -z "$RAM_NODE" ]; then
			rabbitmqctl join_cluster rabbit@$CLUSTER_WITH
		else
			rabbitmqctl join_cluster --ram rabbit@$CLUSTER_WITH
		fi
		rabbitmqctl start_app

		# Tail to keep the a foreground process active..
		tail -f /var/log/rabbitmq/rabbit\@$HOSTNAME.log
	fi
fi
