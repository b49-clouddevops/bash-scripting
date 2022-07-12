#!/bin/bash
set -e 
COMPONENT=mongodb  
LOGFILE="/tmp/$COMPONENT.log"

source components/common.sh 

curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo
