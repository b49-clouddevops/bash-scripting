#!/bin/bash
set -e 
COMPONENT=redis 
LOGFILE="/tmp/$COMPONENT.log"
APPUSER="roboshop"

source components/common.sh

echo -n "Configuring $COMPONENT repo: "
curl -L https://raw.githubusercontent.com/stans-robot-project/$COMPONENT/main/$COMPONENT.repo -o /etc/yum.repos.d/$COMPONENT.repo &>> $LOGFILE 
stat $?

echo -n "Installing $COMPONENT: "
yum install redis-6.2.7 -y &>> $LOGFILE 
stat $?

echo -n "Updating the $COMPONENT listenting address: "
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf  /etc/redis/redis.conf

# 2. Update the BindIP from `127.0.0.1` to `0.0.0.0` in config file `/etc/redis.conf` & `/etc/redis/redis.conf`

# # vim /etc/redis.conf
# # vim /etc/redis/redis.conf

# # systemctl enable redis
# # systemctl start redis
# # systemctl status redis -l