#!/bin/bash
set -e 
COMPONENT=catalogue 
LOGFILE="/tmp/$COMPONENT.log"
APPUSER="roboshop"

source components/common.sh

# curl -L https://raw.githubusercontent.com/stans-robot-project/redis/main/redis.repo -o /etc/yum.repos.d/redis.repo
# yum install redis-6.2.7 -y