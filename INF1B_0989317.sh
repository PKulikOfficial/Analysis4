#!/bin/bash

# Summative Assignment for OP4 analysis
# Patryk Kulik INF1B
# 0989317

######################## Combining and Checking Input ########################
#This functions checks if the user has inputed something and
#sends the variables to the positionChecker function.
function argConnector {
    for input in $1 $4 $7 ${10}
    do
        if [ $input != "" ]; then
            if [ $input == $1 ] && [[ $2 != "" ]] && [[ $3 != "" ]]; then
                positionChecker "$1" "$2" "$3"
            elif [ $input == $4 ] && [[ $5 != "" ]] && [[ $6 != "" ]]; then
                positionChecker "$4" "$5" "$6"
            elif [ $input == $7 ] && [[ $8 != "" ]] && [[ $9 != "" ]]; then
                positionChecker "$7" "$8" "$9"
            elif [ $input == ${10} ] && [[ $11 != "" ]] && [[ ${12} != "" ]]; then
                positionChecker "${10}" "${11}" "${12}"
            fi
        fi
    done
}
######################## Combining and Checking Input ########################



######################## Checking Position ########################
#This function checks which position should be updated and
#sends the right variables to typeChecker function.
function positionChecker {
    # $1 == position | $2 == type | $3 == output
    if [ $1 -eq 0 ]; then
        position0=$(typeChecker "$2" "$3") 
    elif [ $1 -eq 1 ]; then
        position1="$(typeChecker "$2" "$3")"
        #typeChecker $position1 $2 $3
    elif [ $1 -eq 2 ]; then
        position2="$(typeChecker "$2" "$3")"
        #typeChecker $position2 $2 $3
    elif [ $1 -eq 3 ]; then
        position3="$(typeChecker "$2" "$3")"
    fi
}
######################## Checking Position ########################



######################## Checking Type ########################
#This function check which type the user has selected for his input and
#sends the input to the correct output function or executes the command
#if it is an command.
function typeChecker {
    # $1 == type | $2 == output
    if [ $1 -eq 1 ]; then
        echo $(stringOutput "$2")
    elif [ $1 -eq 2 ]; then
        eval $2
    elif [ $1 -eq 3 ]; then
        echo $(csvOutput "$2")
    fi
}
######################## Checking Type ########################



######################## Functions for Output ########################
#This function ouputs the inputed string or
#null if null has been selected.
function stringOutput {
    # $1 == output
    if [ "$1" == "null" ]; then
        echo ""
    else
        echo "$1"
    fi
}

#This function returns the value of the computed column
#that was calculated in the updatedata function.
function csvOutput {
    # $1 == output
    if [ "$1" == "Total_reported" ]; then
        echo "$total_Reported"
    elif [ "$1" == "Hospital_admission" ]; then
        echo "$total_Hospital"
    elif [ "$1" == "Deceased" ]; then
        echo "$total_Deceased"
    fi
}
######################## Functions for Output ######################## 


######################## CSV Data Updater ########################
#This function calculates the columns "Total_reported", "Hospital_admission" and
#"Deceased" in the data.csv file.
function updatedata {
    total_Reported=`awk 'BEGIN {FS=OFS=";"} ; {sum+=$5} END {print sum}' data.csv`
    total_Hospital=`awk 'BEGIN {FS=OFS=";"} ; {sum+=$6} END {print sum}' data.csv`
    total_Deceased=`awk 'BEGIN {FS=OFS=";"} ; {sum+=$7} END {print sum}' data.csv`
}
######################## CSV Data Updater ########################



######################## User Input ########################
updatedata
argConnector "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8" "$9" "${10}" "${11}" "${12}"
PS1=["$position0"]["$position1"]["$position2"]["$position3"]$
######################## User Input ######################## 
