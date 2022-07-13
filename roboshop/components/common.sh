#!/bin/bash 

USER_ID=$(id -u)
if [ $USER_ID -ne 0  ] ; then  
    echo -e "\e[31m You need to run it as a root user only \e[0m"
    exit 1
fi 

stat() {
    if [ $1 -eq 0 ] ; then 
        echo -e " \e[32m SUCCESS \e[0m"
    else 
        echo -e " \e[31m FAILURE \e[0m"
    fi 
}


NODEJS() {
    echo -n "Configuring NodeJS Repo: "
    curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>> $LOGFILE
    stat $? 

    echo -n "Installing NodeJS: "
    yum install nodejs -y &>> $LOGFILE 
    stat $? 
    
    #Calling user creation function
    CREATE_USER

    # Calling Function 
    DOWNLOAD_AND_EXTRACT

    echo -n "Installing $COMPONENT: "
    npm install  &>> $LOGFILE
    stat $? 

    CONFIG_SERVICE

}

CREATE_USER() {
    echo -n "Creating the roboshop user: "
    id roboshop &>> $LOGFILE || useradd roboshop 
    stat $? 
}

DOWNLOAD_AND_EXTRACT() {
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
}

CONFIG_SERVICE() {
    echo -n "Configuring $COMPONENT service: "
    sed -i -e 's/MONGO_DNSNAME/mongodb.roboshop.internal/' systemd.service
    mv /home/$APPUSER/$COMPONENT/systemd.service  /etc/systemd/system/catalogue.service
    stat $? 
}