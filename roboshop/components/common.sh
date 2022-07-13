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
    
}