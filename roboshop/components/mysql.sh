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


# We need to handle this only for the first time
echo "show databases" | mysql -uroot -pRoboShop@1 &>> $LOGFILE 
if []
echo -n "Changing the default $COMPONENT root password: "
echo "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('RoboShop@1');" > /tmp/rootpassword_change.sql
DEFAULT_ROOT_PASSWORD=$(sudo grep "temporary password" /var/log/mysqld.log | awk '{print $NF}')
mysql  --connect-expired-password -uroot -p"$DEFAULT_ROOT_PASSWORD"  < /tmp/rootpassword_change.sql
stat $? 


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
