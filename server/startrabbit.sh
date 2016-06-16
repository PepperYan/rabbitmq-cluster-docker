#!/bin/bash

if [ -z "$CLUSTERED" ]; then
	# if not clustered then start it normally as if it is a single server
	( sleep 10 ; \

	if [ -z "$RABBITMQ_ADMIN" ]; then
		echo "not set any admin"
	else
		rabbitmqctl add_user $RABBITMQ_ADMIN $RABBITMQ_ADMIN_PWD 2>/dev/null
		rabbitmqctl set_user_tags $RABBITMQ_ADMIN administrator
		rabbitmqctl set_permissions -p / $RABBITMQ_ADMIN ".*" ".*" ".*"
	fi
	) &
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

		#setting admin acount
		if [ -z "$RABBITMQ_ADMIN" ]; then
			echo "not set any admin"
		else
			rabbitmqctl add_user $RABBITMQ_ADMIN $RABBITMQ_ADMIN_PWD 2>/dev/null
			rabbitmqctl set_user_tags $RABBITMQ_ADMIN administrator
			rabbitmqctl set_permissions -p / $RABBITMQ_ADMIN ".*" ".*" ".*"
		fi

		# Tail to keep the a foreground process active..
		tail -f /var/log/rabbitmq/rabbit\@$HOSTNAME.log
	fi
fi
