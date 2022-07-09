#!/bin/bash 


### Special Variables 
# $0  : This will print the script name that you are running 
# $?  : This will show your the status code of the last execution
# $0 to $n , $* , $@ , $# , $$

echo "Script we are executing is $0"

# Through command line you can pass up to 9 variables 

echo "The value of X is $1"
echo "Name of the Trainer is $2"

# sh script.sh 10  20  30 
#              $1 $2  $3
