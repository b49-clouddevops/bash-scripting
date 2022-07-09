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
sleep 5 

fa 

sleep 5 
fa


# Creating another function stat 
stat() {
    echo "Load Averate"
}