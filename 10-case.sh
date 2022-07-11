#!/bin/bash 

# case $var in 
#     opt1)  commands ;; 
#     opt2)  commands ;; 

# esac 

ACTION=$1

case $ACTION in 
    start)  
        echo "XYZ Service Starting"
        ;;
    stop)  
        echo "XYZ Service Stopping"
        ;;
    *)
        echo "Valid options are start or stop only
esac


