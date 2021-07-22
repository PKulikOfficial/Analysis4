#!/bin/bash
file="./test.dat"
okok=1
while IFS= read -r line
do
    va=`./test $line`
    echo ". $1 $line"
    eval ". $1 $line"
    echo "your script generates:  ${PS1@P}."
    echo "true answer is:         $va."
    if [[ "${PS1@P}" = "$va" || "${PS1@P}" = "$va " ]]
    then
        echo "Output Is Correct"
    else
        echo "Output Not Correct"
    	okok=0
    fi
    echo
done < "$file"

if [[ okok -eq 0 ]]; then
    echo -e "\n!!! There were incorrect outputs !!!\n"
else
    echo -e "\n!!! All outputs are OK !!!\n"
fi
