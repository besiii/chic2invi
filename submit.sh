#!/usr/bin/env bash

# Main driver to submit jobs 
# Author XIAO Suyu <xiaosuyu@ihep.ac.cn>
# Created [2017-11-07 Tue 19:44]


usage() {
    printf "NAME\n\tsubmit.sh - Main driver to submit jobs\n"
    printf "\nSYNOPSIS\n"
    printf "\n\t%-5s\n" "./submit.sh [OPTION]" 
    printf "\nOPTIONS\n" 
    printf "\n\t%-9s  %-40s"  "0.1"      "[run data sample]" 
    printf "\n\t%-9s  %-40s"  "0.1.1"    "Run with a few samples" 
    printf "\n\n" 
}


if [[ $# -eq 0 ]]; then
    usage
    echo "Please enter your option: "
    read option
else
    option=$1    
fi

case $option in
    
    # --------------------------------------------------------------------------
    #  0.1 Data  
    # --------------------------------------------------------------------------

    0.1) echo "Running on data sample..."
	 ;;

    0.1.1) echo "Run with a few events ..."
	   boss.exe condor/jobOptions_jpsi2invi.txt
	   ;;
    

esac

