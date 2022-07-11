#!/bin/bash

ACTION=$1 


# Simple If
# if [ "$ACTION" = "start" ] ; then 
#     echo -e "Selection option is \e[32m start \e[0m"
# fi 


# If Else 
if [ "$ACTION" = "start" ] ; then 
    echo -e "Selection option is \e[32m start \e[0m"
else 
    echo -n " \e[33m Valid option is start \e[0m"
fi 