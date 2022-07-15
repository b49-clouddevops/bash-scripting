#!/bin/bash
set -e 
COMPONENT=mysql  
LOGFILE="/tmp/$COMPONENT.log"
source components/common.sh 
REPO_URL="https://raw.githubusercontent.com/stans-robot-project/$COMPONENT/main/mysql.repo"

echo -n "Configuring the $COMPONENT Repo:  "
curl -s -L -o /etc/yum.repos.d/mysql.repo $REPO_URL 
stat $? 

echo -n "Installing $COMPONENT Community Edition: "
yum install mysql-community-server -y &>> $LOGFILE
stat $? 

echo -n "Starting the $COMPONENT: "
systemctl enable mysqld &>> $LOGFILE  && systemctl start mysqld &>> $LOGFILE 
stat $? 

echo -n "Changing the default root password: "

# grep temp /var/log/mysqld.log
# ( Copy that password )
# mysql_secure_installation
```bash
# yum install mysql-community-server -y
```
```bash
# yum install mysql-community-server -y
```
# Load the schema
# To download schema, Use the following command
# curl -s -L -o /tmp/mysql.zip "https://github.com/stans-robot-project/mysql/archive/main.zip"
# cd /tmp
# unzip mysql.zip
# cd mysql-main
# mysql -u root -pRoboShop@1 <shipping.sql
