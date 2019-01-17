#!/usr/bin/env bash

# Main driver to build programs
# Author XIAO Suyu <xiaosuyu@ihep.ac.cn>
# Created [2017-11-07 Tue 10:34]


usage() {
    printf "NAME\n\tbuild.sh - Main driver to build programs\n"
    printf "\nSYNOPSIS\n"
    printf "\n\t%-5s\n" "./build.sh [OPTION]" 
    printf "\nOPTIONS\n" 
    printf "\n\t%-5s  %-40s\n"  "1"  "build Chic2invi analyzer" 
    printf "\n\t%-5s  %-40s\n"  "2"  "build ChicNoTDC analyzer"
#    printf "\n\t%-5s  %-40s\n"  "3"  "build Jpsi2pnpi analyzer"
#    printf "\n\t%-5s  %-40s\n"  "4"  "build Jpsi2lplm analyzer"
    printf "\n\t%-5s  %-40s\n"  "5"  "build Chic02ee analyzer"
    printf "\n\t%-5s  %-40s\n"  "6"  "building Chi2gll module.."
    printf "\n\t%-5s  %5-40s\n" "7"  "building Chic02ll module.."
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
    1) echo "Building Chic2invi module..."
       cd Analysis/Physics/Chic2invi/Chic2invi/Chic2invi-00-00-01/cmt 
       gmake  
       ;;
    2) echo "Building ChicNoTDC module..."
       cd Analysis/Physics/Chic2invi/ChicNoTDC/ChicNoTDC-00-00-01/cmt 
       gmake  
       ;;
#    3) echo "Building Jpsi2pnpi module..."
#       cd Analysis/Physics/PsiPrime/Jpsi2pnpi/Jpsi2pnpi-00-00-01/cmt 
#       gmake 
#       ;; 
#    4) echo "Building Jpsi2lplm module..."
#       cd Analysis/Physics/PsiPrime/Jpsi2lplm/Jpsi2lplm-00-00-01/cmt
#       gmake
#       ;;
     5) echo "Building Chic02ee module..."
       cd Analysis/Physics/Chic2invi/Chic02ee/Chic02ee-00-00-01/cmt
       gmake
       ;;
     6) echo "Building Chi2gll module ..."
	   cd Chi2gll/Chi2gll-00-00-00/cmt
	   gmake
	   ;;
     7) echo "Building Chic02ll module ..."
       cd Analysis/Physics/Chic2invi/Chic02ll/Chic02ll-00-00-01/cmt
       gmake
       ;; 

esac

