#!/usr/bin/env bash

# Main driver to submit jobs 
# Author Yuzhen Yang <yangyz@ihep.ac.cn>
# Created [2018-01-23 Tue 20:36]


usage() {
    printf "NAME\n\tsubmit.sh - Main driver to submit jobs\n"
    printf "\nSYNOPSIS\n"
    printf "\n\t%-5s\n" "./submit.sh [OPTION]" 
    printf "\nOPTIONS\n" 
    printf "\n\t%-9s  %-40s"  "0.1"      "[run MC sample]" 
    printf "\n\t%-9s  %-40s"  "0.1.1"    "Split MC sample with each group 20G"
    printf "\n\t%-9s  %-40s"  "0.1.2"    "Submit Condor jobs on MC"
    printf "\n\t%-9s  %-40s"  "0.1.3"    "Check Condor jobs on MC."
    printf "\n\t%-9s  %-40s"  "0.1.4"    "Merge root file on MC."
    printf "\n\t%-9s  %-40s"  "0.1.5"   "Select events on MC."
    printf "\n\t%-9s  %-40s"  ""         ""
    printf "\n\t%-9s  %-40s"  "0.2"      "[run on data3650]"
    printf "\n\t%-9s  %-40s"  "0.2.1"    "Split con3650 data with each group 20G"
    printf "\n\t%-9s  %-40s"  "0.2.2"    "Submit Condor jobs on con3650 data"     
    printf "\n\t%-9s  %-40s"  "0.2.3"    "Check Condor jobs on con3650 data"     
    printf "\n\t%-9s  %-40s"  "0.2.4"    "Merge root file on con3650 data"     
    printf "\n\t%-9s  %-40s"  "0.2.5"    "Select events on con3650 data"     
    printf "\n\t%-9s  %-40s"  ""          ""
    printf "\n\t%-9s  %-40s"  "0.3"      "[run on signal MC of chic2gamgam]"
    printf "\n\t%-9s  %-40s"  "0.3.1"    "simulate 6k signal MC samples of chic2gamgam to rtraw file"
    printf "\n\t%-9s  %-40s"  "0.3.2"    "reconstruct the samples of chic2gamgam to dst file"
    printf "\n\t%-9s  %-40s"  "0.3.3"    "run the algorithm to root file"
    printf "\n\t%-9s  %-40s"  ""         ""
    printf "\n\t%-9s  %-40s"  "0.4"      "[run on signal MC of chic2gamnunu]"
    printf "\n\t%-9s  %-40s"  "0.4.1"    "simulate 6k signal MC samples of chic2gamnunu to rtraw file"
    printf "\n\t%-9s  %-40s"  "0.4.2"    "reconstruct the samples of chic2gamnunu to dst file"
    printf "\n\t%-9s  %-40s"  "0.4.3"    "run the algorithm to root file"
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
    #  0.1 MC  
    # --------------------------------------------------------------------------

    0.1) echo "Running on MC sample..."
	 ;;

    0.1.1) echo "Split MC sample with each group 20G ..."
	   ./python/get_samples.py  /bes3fs/offline/data/664p03/psip/12mc/dst run/samples/mc_664p03_psip_12mc.txt 20G
	   # made 394 groups 
	   ;;

    0.1.2) echo "Submit Condor jobs on MC..."
	   mkdir -p run/chic2invi/job_text/inclusiveMC
	   mkdir -p run/chic2invi/rootfile_inclusiveMC
	   cd run/chic2invi/gen_script
	   ./make_jobOption_file_inclusiveMC.sh
	   cd ../job_text/inclusiveMC
	   mv jobOptions_chic2invi_inclusive_psip_mc-394.txt jobOptions_chic2invi_inclusive_psip_mc-0.txt
	   boss.condor -g physics -n 394 jobOptions_chic2invi_inclusive_psip_mc-%{ProcId}.txt
	   ;;

    0.1.3) echo "Check Condor jobs on MC..."
	   ./python/chk_condorjobs.py run/chic2invi/rootfile_inclusiveMC 394
	   ;;
    
	0.1.4) echo "Merge root file on MC..."
	   ./python/mrg_rootfiles.py run/chic2invi/rootfile_inclusiveMC run/chic2invi/hist_inclusiveMC
	   ;;

    0.1.5) echo  "Select events on MC..."
	   mkdir -p  run/analysis
	   root analysis.cxx 
	   ;; 



    # --------------------------------------------------------------------------
    # 0.2 con3650 data
	# --------------------------------------------------------------------------
    0.2) echo "Running on data3650..."
	 ;;

    0.2.1) echo "Split con3650 data with each group 20G ..."
	    mkdir run/samples/data3650
	    ./python/get_samples.py  /bes3fs/offline/data/664-1/3650/dst run/samples/data3650/data_663p01_3650.txt 20G
	    # made 84 groups 
	    ;;

    0.2.2) echo "Submit Condor jobs on con3650 data..."
	    mkdir run/chic2invi/job_text/data3650
	    mkdir run/chic2invi/rootfile_data3650
		cd run/chic2invi/gen_script
		./make_jobOption_file_data3650.sh
		cd ../job_text/data3650
		mv jobOptions_chic2invi_data3650-84.txt jobOptions_chic2invi_data3650-0.txt
		boss.condor -g physics -n 84 jobOptions_chic2invi_data3650-%{ProcId}.txt
	    ;;

    0.2.3) echo "Check Condor jobs on con3650 data..."
	   ./python/chk_condorjobs.py run/chic2invi/rootfile_data3650  84 
	   ;;

	0.2.4) echo  "Merge root file on con3650 data..."
	   mkdir run/chic2invi/hist_data3650
	   ./python/mrg_rootfiles.py run/chic2invi/rootfile_data3650 run/chic2invi/hist_data3650 
	   ;;

    0.2.5) echo  "Select event on con3650 data..."
	   mkdir run/analysis
	   root analysis.cxx
	   ;; 



   # --------------------------------------------------------------------------
    # 0.3 signal MC of chic2gamgam
        # --------------------------------------------------------------------------
    0.3) echo "running on signal MC of chic2gamgam..."
         ;;

    0.3.1) echo "simulate 6k signal MC samples of chic2gamgam to rtraw file..."
           boss.exe run/gen_mc/chic0gamgam/run_gamgam/jobOptions_sim_gamgam.txt
        #  boss.condor -g physics run/gen_mc/chic0gamgam/run_gamgam/jobOptions_sim_gamgam.txt
            ;;

    0.3.2) echo "reconstruct the samples of chic2gamgam to dst file..."
	   boss.exe run/gen_mc/chic0gamgam/run_gamgam/jobOptions_rec_gamgam.txt
          #boss.condor -g physics run/gen_mc/chic0gamgam/run_gamgam/jobOptions_rec_gamgam.txt        
            ;;

    0.3.3) echo "run the algorithm to root file..."
           boss.exe run/gen_mc/chic0gamgam/run_gamgam/jobOptions_gamgam_gen_mc.txt
          #boss.condor -g physics run/gen_mc/chic0gamgam/run_gamgam/jobOptions_gamgam_gen_mc.txt
           ;;
  # --------------------------------------------------------------------------
    # 0.4 chic2gamnunu MC
        # --------------------------------------------------------------------------
    0.4) echo "running on signal MC of chic2gamnunu..."
         ;;

    0.4.1) echo "simulate 6k signal MC samples of chic2gamnunu to rtraw file..."
          boss.exe run/gen_mc/chic0gamnunu/run_gamnunu/jobOptions_sim_gamnunu.txt
        #  boss.condor -g physics run/gen_mc/chic0gamnunu/run_gamnunu/jobOptions_sim_gamnunu.txt
            ;;

    0.4.2) echo "reconstruct the samples of chic2gamnunu to dst file..."
          boss.exe run/gen_mc/chic0gamnunu/run_gamnunu/jobOptions_rec_gamnunu.txt
        #  boss.condor -g physics run/gen_mc/chic0gamnunu/run_gamnunu/jobOptions_rec_gamnunu.txt
            ;;

    0.4.3) echo "run the algorithm to root file..."
          boss.exe run/gen_mc/chic0gamnunu/run_gamnunu/jobOptions_gamnunu_gen_mc.txt
        #  boss.condor -g physics run/gen_mc/chic0gamnunu/run_gamnunu/jobOptions_gamnunu_gen_mc.txt
           ;;

esac

