#!/bin/bash
set -e 
COMPONENT=catalogue 
LOGFILE="/tmp/$COMPONENT.log"
APPUSER="roboshop"

source components/common.sh


echo -n "Configuring NodeJS Repo: "
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>> $LOGFILE
stat $? 

echo -n "Installing NodeJS: "
yum install nodejs -y &>> $LOGFILE 
stat $? 

echo -n "Creating the roboshop user: "
id roboshop &>> $LOGFILE || useradd roboshop 
stat $? 

echo -n "Downloading $COMPONENT repo: "
curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/stans-robot-project/${COMPONENT}/archive/main.zip"
stat $? 

echo -n "Performing cleanup: "
cd /home/roboshop/ && rm -rf ${COMPONENT}  &>> $LOGFILE 
stat $?

echo -n "Extracting $COMPONENT: "
cd /home/roboshop
unzip -o /tmp/${COMPONENT}.zip  &>> $LOGFILE 
mv ${COMPONENT}-main ${COMPONENT}  &&  chown -R $APPUSER:$APPUSER $COMPONENT 
cd ${COMPONENT}
stat $?

echo -n "Installing $COMPONENT: "
npm install  &>> $LOGFILE
stat $? 

echo -n "Configuring $COMPONENT service: "
sed -i -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/' systemd.service
mv /home/$APPUSER/$COMPONENT/systemd.service  /etc/systemd/system/catalogue.service
stat $? 

echo -n "Starting $COMPONENT service: "
systemctl daemon-reload 
systemctl restart catalogue 
systemctl enable catalogue  &>> $LOGFILE  
systemctl status catalogue -l &>> $LOGFILE 
stat $? 

