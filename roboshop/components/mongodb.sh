#!/bin/bash
set -e 
COMPONENT=mongodb  
LOGFILE="/tmp/$COMPONENT.log"
MONGODB_REPO_URL="https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo"

source components/common.sh 

echo -n "Downloading the MongoDB Repo:  "
curl -s -o /etc/yum.repos.d/mongodb.repo $MONGODB_REPO_URL
stat $? 

echo -n "Installing MongoDB: "
yum install -y mongodb-org &>> $LOGFILE
systemctl enable mongod  &>> $LOGFILE
systemctl start mongod &>> $LOGFILE

1. Update Listen IP address from 127.0.0.1 to 0.0.0.0 in the config file, so that MongoDB can be accessed by other services.

Config file:   `# vim /etc/mongod.conf`

 systemctl restart mongod

 # curl -s -L -o /tmp/mongodb.zip "https://github.com/stans-robot-project/mongodb/archive/main.zip"

# cd /tmp
# unzip mongodb.zip
# cd mongodb-main
# mongo < catalogue.js
# mongo < users.js