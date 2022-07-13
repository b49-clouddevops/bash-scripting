#!/bin/bash
set -e 
COMPONENT=catalogue 
LOGFILE="/tmp/$COMPONENT.log"

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
cd /home/roboship/ && rm -rf ${COMPONENT} 


cd /home/roboshop
unzip -o /tmp/${COMPONENT}.zip  &>> $LOGFILE 
mv ${COMPONENT}-main ${COMPONENT}
cd /home/roboshop/${COMPONENT}

echo -n "Installing $COMPONENT: "
npm install  &>> $LOGFILE
stat $? 

# 1. Update SystemD file with correct IP addresses
    
#     Update `MONGO_DNSNAME` with MongoDB Server IP
    
#     ```sql
#     $ vim systemd.servce
#     ```

# # mv /home/roboshop/catalogue/systemd.service /etc/systemd/system/catalogue.service
# # systemctl daemon-reload
# # systemctl start catalogue
# # systemctl enable catalogue
# # systemctl status catalogue -l

# NOTE: You should see the log saying `connected to MongoDB`, then only your catalogue
# will work and can fetch the items from MongoDB

# Ref Log:
# {"level":"info","time":1656660782066,"pid":12217,"hostname":"ip-172-31-13-123.ec2.internal","msg":"MongoDB connected","v":1}

# 1. Now, you would still see **`CATEGORIES`** on the frontend page as empty. 
# 2. That’s because your `frontend` doesn't know who the `CATALOGUE` is when someone clicks the `CATEGORIES` option. So, we need to update the Nginx Reverse Proxy on the frontend. If not, you’d still see the frontend without categories.