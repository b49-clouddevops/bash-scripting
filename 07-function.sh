#!/bin/bash 

#Functions helps you in avoiding the same set of code multiple times.
# Declare it as a function and call it whenever or whereever you want.

# We are declaring a funciton fa

sam() {
    echo "I am a Command from SAM"
}


fa () 
{ 
    echo "I am the first line in the function f";
    echo "Todays date is $(date +%F)";
    echo "Number of opened sessiosn are $(who |wc -l)"
    echo "calling SAM Function"
    sam 
    echo "Function f completed ..... BYE "
}


echo "Showing you how to call a function"
fa

# Creating another function stat 
stat() {
    echo "Load Average from last 1 min is $(uptime | awk -F : '{print $NF}' | awk -F , '{print $1}')"
    echo "Number of opened sessions are $(who |wc -l )"
    echo "Todays date is $(date +%F)"
}

echo "Calling stat function
stat 