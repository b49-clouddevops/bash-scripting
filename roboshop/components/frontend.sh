#!/bin/bash
set -e 
COMPONENT=frontend 
LOGFILE="/tmp/$COMPONENT.log"

source components/common.sh

stat() {
    if [ $1 -eq 0 ] ; then 
        echo -e " \e[32m SUCCESS \e[0m"
    else 
        echo -e " \e[31m FAILURE \e[0m"
    fi 
}

echo -n "Installing Nginx: "
yum install nginx -y &>> $LOGFILE
stat $?


systemctl enable nginx &>> $LOGFILE 

echo -n "Starting Nginx: "
systemctl start nginx
stat $?

echo -n "Downloading $COMPONENT: "
curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip"
stat $? 

echo -n "Clearing the old content: "
cd /usr/share/nginx/html
rm -rf *
stat $? 

echo -n "Extracting the "
unzip /tmp/frontend.zip
stat $? 

mv frontend-main/* .
mv static/* .
rm -rf frontend-main README.md
mv localhost.conf /etc/nginx/default.d/roboshop.conf
