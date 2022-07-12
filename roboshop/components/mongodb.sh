#!/bin/bash
set -e 
COMPONENT=mongodb  
LOGFILE="/tmp/$COMPONENT.log"

source components/common.sh 

curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo
# yum install -y mongodb-org
# systemctl enable mongod
# systemctl start mongod

1. Update Listen IP address from 127.0.0.1 to 0.0.0.0 in the config file, so that MongoDB can be accessed by other services.

Config file:   `# vim /etc/mongod.conf`

