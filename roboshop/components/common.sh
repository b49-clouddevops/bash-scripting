#!/bin/bash 

USER_ID=$(id -u)
if [ $USER_ID -ne 0  ] ; then  
    echo -e "\e[31m You need to run it as a root user only \e[0m"
    exit 1
fi 