#!/usr/bin/env bash

# Main driver to submit jobs 
# Author XIAO Suyu <xiaosuyu@ihep.ac.cn>
# Created [2017-11-24 Fri 20:44]


usage() {
    printf "NAME\n\tsubmit.sh - Main driver to submit jobs\n"
    printf "\nSYNOPSIS\n"
    printf "\n\t%-5s\n" "./submit.sh [OPTION]" 
    printf "\nOPTIONS\n" 
    printf "\n\t%-9s  %-40s"  "0.1"      "[run MC sample]" 
    printf "\n\t%-9s  %-40s"  "0.1.1"    "Run with a few samples" 
    printf "\n\t%-9s  %-40s"  "0.1.2"    "Split MC sample with each group 20G"
    printf "\n\t%-9s  %-40s"  "0.1.3"    "Submit Condor jobs on MC"
    printf "\n\t%-9s  %-40s"  "0.1.4"    "Check Condor jobs on MC."
	printf "\n\t%-9s  %-40s"  "0.1.5"    "Merge root file on MC."
    printf "\n\t%-9s  %-40s"  "0.1.6"    "Select events."
    printf "\n\t%-9s  %-40s"  "0.1.7"    "Check events jobs on MC."
    printf "\n\t%-9s  %-40s"  "0.1.8"    "Merge events files." 
    printf "\n\t%-9s  %-40s"  "0.1.9"    "Plot summary with MC."
    printf "\n\t%-9s  %-40s"  "0.1.10"   "Split con3650 MC sample with each group 20G"
    printf "\n\t%-9s  %-40s"  "0.1.11"   "Submit Condor jobs on con3650 MC"
    printf "\n\t%-9s  %-40s"  "0.1.12"   "Check Condor jobs on con3650 MC"
    printf "\n\t%-9s  %-40s"  "0.1.13"   "Select events on con3650 MC"
    printf "\n\t%-9s  %-40s"  "0.1.14"   "Merge events on con3650 MC"
    printf "\n\t%-9s  %-40s"  "0.1.15"   "Plot summary with MC and con3650"
    printf "\n\t%-9s  %-40s"  "0.1.16"   "Split MC09 sample with each group 20G"
    printf "\n\t%-9s  %-40s"  "0.1.17"   "Submit Condor jobs on 09 MC sample"
    printf "\n\t%-9s  %-40s"  "0.1.18"   "Check Condor PBS jobs on 09 MC sample"
    printf "\n\t%-9s  %-40s"  "0.1.19"   "Event selecion on 09 MC"
    printf "\n\t%-9s  %-40s"  "0.1.20"   "PBS jobs for event selecion on 09 MC"
    printf "\n\t%-9s  %-40s"  "0.1.21"   "Check Condor jobs for event selecion on 09 MC"
    printf "\n\t%-9s  %-40s"  "0.1.22"   "Merge event file on 09 MC"
    printf "\n\t%-9s  %-40s"  "0.1.23"   "Plot summary on 09 MC"
    printf "\n\t%-9s  %-40s"  "0.1.24"   "Run with Jpsi2incl on a few 09 MC events "
    printf "\n\t%-9s  %-40s"  "0.1.25"   "Submit Jpsi2incl Condor jobs on MC09"
    printf "\n\t%-9s  %-40s"  "0.1.26"   "Check Jpsi2incl Condor jobs on MC09"
    printf "\n\t%-9s  %-40s"  "0.1.27"   "Select Jpsi2incl events on MC09"
    printf "\n\t%-9s  %-40s"  ""         ""
    printf "\n\t%-9s  %-40s"  "0.2"      "[run on MC sample]"
    printf "\n\t%-9s  %-40s"  "0.2.1"    "Run with a few samples"
    printf "\n\t%-9s  %-40s"  "0.2.2"    "Split psi(2S) MC sample with each group 20G"
    printf "\n\t%-9s  %-40s"  "0.2.3"    "Submit PBS jobs on psi(2S) MC sample"     
    printf "\n\t%-9s  %-40s"  "0.2.4"    "Check PBS jobs on psi(2S) MC sample"     
    printf "\n\t%-9s  %-40s"  "0.2.5"    "Select events on psi(2S) MC sample"     
    printf "\n\t%-9s  %-40s"  "0.2.6"    "Submit PBS jobs to select events on psi(2S) MC sample"     
    printf "\n\t%-9s  %-40s"  "0.2.7"    "Check events selection jobs on psi(2S) MC"
    printf "\n\t%-9s  %-40s"  "0.2.8"    "Merge events files on psi(2S) MC"
    printf "\n\t%-9s  %-40s"  "0.2.9"    "Plot summary with MC and psi(2S) MC"
    printf "\n\t%-9s  %-40s"  "0.2.10"   "Run a few events on 09 psi(2S) MC"
    printf "\n\t%-9s  %-40s"  "0.2.11"   "Split 09 psi(2S) MC sample with each group 20G"
    printf "\n\t%-9s  %-40s"  "0.2.12"   "Submit PBS jobs on 09 psi(2S) MC sample"         
    printf "\n\t%-9s  %-40s"  "0.2.13"   "Check PBS jobs on 09 psi(2S) MC sample"         
    printf "\n\t%-9s  %-40s"  "0.2.14"   "Select events on 09 psi(2S) MC sample"         
    printf "\n\t%-9s  %-40s"  "0.2.15"   "Submit PBS jobs to select events on 09 psi(2S) MC sample"         
    printf "\n\t%-9s  %-40s"  "0.2.16"   "Check PBS jobs to select events on 09 psi(2S) MC sample"         
    printf "\n\t%-9s  %-40s"  "0.2.17"   "Merge events file on 09 psi(2S) MC sample"         
    printf "\n\t%-9s  %-40s"  "0.2.18"   "Plot summary with 09 MC and 09 psi(2S) MC sample"         
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
	   mkdir -p run/chic2invi/rootfile
	   cd run/chic2invi/gen_script
	   ./make_jobOption_file_inclusiveMC.sh
	   cd ../job_text/inclusiveMC
	   mv jobOptions_chic2invi_inclusiveMC_psip_mc-394.txt jobOptions_chic2invi_inclusiveMC_psip_mc-0.txt
	   boss.condor -g physics -n 394 jobOptions_chic2invi_inclusiveMC_psip_mc-%{ProcId}.txt
	   ;;

    0.1.3) echo "Check Condor jobs on MC..."
	   ./python/chk_condorjobs.py run/chic2invi/inclusiveMC 394
	   ;;
    
	0.1.4) echo "Merge root file on MC..."
	   ./python/mrg_rootfiles.py run/chic2invi/inlusiveMC run/chic2invi/hist_inclusiveMC
	   ;;

    0.1.5) echo  "Select events on MC..."
	   mkdir -p  run/analysis
	   root analysis.cxx 
	   ;; 



    # --------------------------------------------------------------------------
    # 0.2 con3650 data
	# --------------------------------------------------------------------------
    0.2.1) echo "Split con3650 data with each group 20G ..."
	    ./python/get_samples.py  /bes3fs/offline/data/663p01/3650/dst run/samples/data_663p01_3650.txt 20G
	    # made 11 groups 
	    ;;

    0.2.2) echo "Submit Condor jobs on con3650 data..."
	    mkdir run/chic2invi/job_text/data3650
	    mkdir run/chic2invi/rootfile_data3650
		cd run/chic2invi/gen_script
		./make_jobOption_file_data3650.sh
		cd ../job_text/data3650
		mv jobOptions_chic2invi_data3650-11.txt jobOptions_chic2invi_data3650-0.txt
		boss.condor -g physics -n 11 jobOptions_chic2invi_data3650-%{ProcId}.txt
	    ;;

    0.2.3) echo "Check Condor jobs on con3650 data..."
	   ./python/chk_condorjobs.py run/chic2invi/rootfile_data3650  11 
	   ;;

    0.2.4) echo  "Select event on con3650 data..."
	   mkdir run/analysis
	   root analysis.cxx
	   ;; 

	0.2.) echo  "Merge root file on con3650 data..."
	   ./python/mrg_rootfiles.py run/events/con3650 run/hist/con3650 
	   ;;

    0.1.16) echo "Split MC09 sample with each group 20G ..."
	   ./python/get_samples.py /bes3fs/offline/MC/664-1/psip/dst $HOME/bes/chic2invi/v0.1/run/samples/MC_664-1_psip.txt 20G
	   # made 314 groups 
	   ;;
    0.1.17) echo "Submit Condor jobs on 09 MC..."
	    mkdir run/MC09
	    mkdir -p run/log/MC09  
	    qsub pbs/qsub_chic2invi_MC09.sh  
	    ;;

    0.1.18) echo "Check Condor jobs on 09 MC..."
	   ./python/chk_pbsjobs.py run/MC09  314 
	   ;;

    0.1.19) echo  "Event selection on 09 MC..."
	   mkdir run/events/MC09 
	   ./python/sel_events.py  run/MC09/chic2invi_MC09-1.root  run/events/MC09/chic2invi_MC09-1.root 
	   ;; 

    0.1.20) echo "Condor jobs for event selection on 09 MC..."
	   mkdir run/events/MC09
	   mkdir run/log/events/MC09   
	   qsub pbs/qsub_chic2invi_events_MC09.sh  
	   ;;

    0.1.21) echo "Check Condor jobs of event selection on 09 MC..."
	   ./python/chk_pbsjobs.py run/events/MC09  314
	   ;;

    0.1.22) echo  "Merge event files on 09 MC..."
	   mkdir run/hist/MC09
	   ./python/mrg_rootfiles.py  run/events/MC09 run/hist/MC09 
	   ;; 

    0.1.23) echo  "Plot summary with 09 MC..."
	    ./python/plt_summary.py MC09  
	    ;; 

    0.1.24) echo "Run with Jpsi2incl on a few MC09 events ..."
	   boss.exe pbs/jobOptions_chic2incl.txt
	   ;;

    0.1.25) echo "Submit Jpsi2incl Condor jobs on MC09..."
	   mkdir -p run/chic2incl/MC09
	   mkdir -p run/chic2incl/log/MC09
	   qsub pbs/qsub_chic2incl_MC09.sh  
	   ;;

    0.1.26) echo "Check Jpsi2incl Condor jobs on 09 MC..."
	   ./python/chk_pbsjobs.py run/chic2incl/MC09  314 
	   ;;
    
    0.1.27) echo "Select Jpsi2incl events on MC09"
	    mkdir -p run/chic2incl/events/MC09 
	    ./python/sel_events.py  run/chic2incl/MC09/chic2incl_MC09-1.root  run/chic2incl/events/MC09/chic2incl_MC09-1.root 
	   ;; 

    # --------------------------------------------------------------------------
    #  0.2 MC Sample 
    # --------------------------------------------------------------------------
    
    0.2) echo "Running on MC sample..."
	 ;;

    0.2.1) echo "Run with a few events ..."
	   boss.exe pbs/jobOptions_chic2invi.txt
	   ;;
    0.2.2) echo "Split psi(2S) MC sample with each group 20G ..."
	   ./python/get_samples.py  /bes3fs/offline/MC/664p03/psip/12mc/dst $HOME/bes/chic2invi/v0.1/run/samples/mc_664p03_psip_12mc.txt 20G
	   # made 394 groups 
	   ;;

    0.2.3) echo "Submit Condor jobs on psi(2S) MC sample..."
	   mkdir -p run/chic2invi/job_text/mc12
	   mkdir -p run/chic2invi/rootfile_mc12
	   cd run/chic2invi/gen_script
	   ./make_jobOption_file_mc12_chic2invi.sh
	   cd ../job_text/mc12
	   mv jobOptions_chic2invi_psip_mc12-394.txt jobOptions_chic2invi_psip_mc12-0.txt
	   boss.condor -g physics -n 394 jobOptions_chic2invi_psip_mc12-%{ProcId}.txt 
	   cd 
	   cd bes/chic2invi/v0.1
	   ;;

    0.2.4) echo "Check Condor jobs on psi(2S) MC sample..."
	   ./python/chk_condorjobs.py $HOME/bes/chic2invi/v0.1/run/chic2invi/rootfile_mc12  394 
	   ;;

    0.2.5) echo  "Select events on psi(2S) MC sample..."
	   mkdir run/chic2invi/event_mc12 
	   ./python/sel_events.py  run/chic2invi/rootfile_mc12/chic2invi_psip_mc12-1.root  run/chic2invi/event_mc12/chic2invi_psip_mc12-1.root 
	   ;; 

    0.2.6) echo "Submit selection PBS jobs on psi(2S) sample..."
	   mkdir run/chic2invi/event_mc12
	   mkdir run/chic2invi/job_text/mc12_event  
	   cd run/chic2invi/gen_script
	   ./make_jobOption_file_mc12_event.sh
	   cd ../job_text/mc12_event
	   mv jobOptions_chic2invi_psip_mc12_event-394.sh jobOptions_chic2invi_psip_mc12_event-0.sh
	   chmod 755 jobOptions_chic2invi_psip_mc12_event-*
	   hep_sub -g physics -n 394 jobOptions_chic2invi_psip_mc12_event-%{ProcId}.sh
	   ;;

    0.2.7) echo "Check events selection jobs on psi(2S) MC sample..."
	   ./python/chk_condorjobs.py run/chic2invi/event_mc12  394 
	   ;;

    0.2.8) echo  "Merge events files..."
	   mkdir run/chic2invi/hist_mc12
	   ./python/mrg_rootfiles.py  run/chic2invi/event_mc12 run/chic2invi/hist_mc12
	   ;; 

    0.2.9) echo  "Plot summary with MC and psip(2S) MC ..."
	   ./python/plt_summary.py hist_mc12
	   ;; 

    0.2.10) echo "Run with a few events on 09 MC ..." 
	   boss.exe pbs/jobOptions_chic2invi.txt 
	   ;;

    0.2.11) echo "Split 09 psi(2S) MC sample with each group 20G ..."
	   ./python/get_samples.py  /bes3fs/offline/MC/664p01/psip/mc/09dst $HOME/bes/chic2invi/v0.1/run/samples/mc_664p01_psip_09mc.txt 20G
	   # made 106 groups 
	   ;;

    0.2.12) echo "Submit PBS jobs on 09 psi(2S) MC sample..."
	    mkdir run/mc_psip09
	    mkdir run/log/mc_psip09
	    qsub pbs/qsub_chic2invi_mc_psip09.sh  
	    ;;

    0.2.13) echo "Check PBS jobs on 09 psi(2S) MC sample..."
	   ./python/chk_pbsjobs.py $HOME/bes/chic2invi/v0.1/run/mc_psip09  106
	   ;;

    0.2.14) echo  "Event selection on 09 psi(2S) MC sample..."
	    mkdir run/events/mc_psip09 
	    ./python/sel_events.py  run/mc_psip09/chic2invi_mc_psip_09mc-1.root  run/events/mc_psip09/chic2invi_mc_psip_09mc-1.root 
	    ;; 

    0.2.15) echo "Submit selection PBS jobs on 09 psi(2S) sample..."
	   mkdir run/events/mc_psip09
	   mkdir run/log/events/mc_psip09
	   qsub pbs/qsub_chic2invi_events_mc_psip09.sh  
	   ;;
    0.2.16) echo "Check selection jobs on 09 psi(2S) MC sample..."
	   ./python/chk_pbsjobs.py run/events/mc_psip09  106 
	   ;;
    0.2.17) echo  "Merge events files of 09 psi(2S) MC sample..."
	   mkdir run/hist/mc_psip09
	   ./python/mrg_rootfiles.py  run/events/mc_psip09 run/hist/mc_psip09 
	   ;; 
    0.2.18) echo  "Plot summary with 09 MC and 09 psip(2S) MC ..."
	   ./python/plt_summary.py MC09 mc_psip09
	   ;; 

esac

