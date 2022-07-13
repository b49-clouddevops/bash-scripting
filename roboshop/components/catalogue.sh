#!/bin/bash
set -e 
COMPONENT=catalogue 
LOGFILE="/tmp/$COMPONENT.log"
APPUSER="roboshop"

source components/common.sh

# Calling NodeJS Function
NODEJS 




echo -n "Starting $COMPONENT service: "
systemctl daemon-reload 
systemctl restart catalogue 
systemctl enable catalogue  &>> $LOGFILE  
systemctl status catalogue -l &>> $LOGFILE 
stat $? 

