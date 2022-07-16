#!/bin/bash

COMPONENT=rabbitmq  
LOGFILE="/tmp/$COMPONENT.log"
source components/common.sh 
APPUSER=roboshop


echo -n "Configuring repo: "
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash &>> $LOGFILE
stat $? 

echo -n "Installing $PAYMENT Depenency Package Erlang"
yum install https://github.com/rabbitmq/erlang-rpm/releases/download/v23.2.6/erlang-23.2.6-1.el7.x86_64.rpm -y &>> $LOGFILE
stat $? 

echo -n "Installng $COMPONENT: "
yum install rabbitmq-server -y &>> $LOGFILE
stat $? 

echo -n "Starting $COMPONENT: "
systemctl enable rabbitmq-server &>> $LOGFILE 
systemctl start rabbitmq-server &>> $LOGFILE
stat $? 

systemctl status rabbitmq-server -l &>> $LOGFILE
stat $?

echo -n "Creating $APPUSER user for rabbitmq: "
rabbitmqctl add_user $APPUSER roboshop123 &>> $LOGFILE
stat $? 

# rabbitmqctl set_user_tags $APPUSER administrator
# rabbitmqctl set_permissions -p / $APPUSER ".*" ".*" ".*"

# #We are good with rabbitmq.Next component is PAYMENT