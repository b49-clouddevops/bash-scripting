#!/bin/bash 

#Functions helps you in avoiding the same set of code multiple times.
# Declare it as a function and call it whenever or whereever you want.

# We are declaring a funciton fa
fa () 
{ 
    echo "I am the first line in the function f";
    echo "Todays date is $(date +%F)";
    echo "Number of opened sessiosn are $(who |wc -l)"
    echo "Function f completed ..... BYE "
}


echo "Showing you how to call a function"
fa
sleep 5 

fa 

sleed 5 
fa
