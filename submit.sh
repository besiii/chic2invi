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

    printf "\n\t%-9s  %-40s"  "0.3"      "[run on signal MC of chic0->gamgam and chic0->gamnunu,now is chic0->gamgam]"
    printf "\n\t%-9s  %-40s"  "0.3.1"    "chic0->gg:simulate 6000 signal MC samples--rtraw"
    printf "\n\t%-9s  %-40s"  "0.3.2"    "chic0->gg:reconstruct--dst"
    printf "\n\t%-9s  %-40s"  "0.3.3"    "chic0->gg:run algorithm--root"
    printf "\n\t%-9s  %-40s"  "0.3.4"    "chic0->gg:select event with ngam=3--root"
    printf "\n\t%-9s  %-40s"  "0.3.5"    "chic0->gg:plot the gamma energy"
    printf "\n\t%-9s  %-40s"  "0.3.6"    "[Now is signal MC of chic0->gamnunu]"
    printf "\n\t%-9s  %-40s"  "0.3.7"    "chic0->gamnunu:simulate 6000 signal MC samples--rtraw"
    printf "\n\t%-9s  %-40s"  "0.3.8"    "chic0->gamnunu:reconstruct--dst"
    printf "\n\t%-9s  %-40s"  "0.3.9"    "chic0->gamnunu:run algorithm--root"

    printf "\n\t%-9s  %-40s"  ""          ""
    printf "\n\t%-9s  %-40s"  "0.4"      "[run on signal MC sample]" 
    printf "\n\t%-9s  %-40s"  "0.4.1"    "Simulation -- generate signal MC sample"
    printf "\n\t%-9s  %-40s"  "0.4.2"    "Reconstruction -- generate signal MC sample"
    printf "\n\t%-9s  %-40s"  "0.4.3"    "Run on signal MC sample"
    printf "\n\t%-9s  %-40s"  "0.4.4"    "Select events on signal MC sample"
    printf "\n\t%-9s  %-40s"  "0.4.5"    "Generate plots of signal and inclusive MC samples"

    printf "\n\t%-9s  %-40s"  ""          ""
    printf "\n\t%-9s  %-40s"  "0.5"      "[run on data 2012]" 
    printf "\n\t%-9s  %-40s"  "0.5.1"    "Split data 2012 with each group 20G"
    printf "\n\t%-9s  %-40s"  "0.5.2"    "Generate Condor jobs on data 2012 ---- 1"
    printf "\n\t%-9s  %-40s"  "0.5.3"    "Test on data 2012"
    printf "\n\t%-9s  %-40s"  "0.5.4"    "Submit Condor jobs on data 2012 ---- 2"
    printf "\n\t%-9s  %-40s"  "0.5.5"    "Check Condor jobs on data 2012"
    printf "\n\t%-9s  %-40s"  "0.5.6"    "Test 1 job on data 2012 event"
    printf "\n\t%-9s  %-40s"  "0.5.7"    "Generate Condor jobs on data 2012 event ---- 1"
    printf "\n\t%-9s  %-40s"  "0.5.8"    "Submit Condor jobs on data 2012 event ---- 2"
    printf "\n\t%-9s  %-40s"  "0.5.9"    "Check Condor jobs on data 2012 event"
    printf "\n\t%-9s  %-40s"  "0.5.10"    "Merge rootfile on data 2012 event"

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
	   ./python/get_samples.py  /bes3fs/offline/data/664p03/psip/12mc/dst run/samples/inclusiveMC/mc_664p03_psip_12mc.txt 20G
	   # made 394 groups 
	   ;;

    0.1.2) echo "Submit Condor jobs on MC..."
	   mkdir -p run/chic2incl/job_text/inclusiveMC
	   mkdir -p run/chic2incl/rootfile_inclusiveMC
	   cd scripts/gen_script
	   ./make_jobOption_file_inclusiveMC.sh
	   cd ../job_text/inclusiveMC
	   mv jobOptions_chic2invi_inclusive_psip_mc-394.txt jobOptions_chic2invi_inclusive_psip_mc-0.txt
	   boss.condor -g physics -n 394 jobOptions_chic2invi_inclusive_psip_mc-%{ProcId}.txt
       cd $HOME/bes/chic2invi/v0.1	   
       ;;

    0.1.3) echo "Check Condor jobs on MC..."
	   ./python/chk_condorjobs.py run/chic2incl/rootfile_inclusiveMC 394
	   ;;
    
    0.1.6) echo "Test 1 job on MC event..."
        ./python/sel_events.py run/chic2incl/rootfile_inclusiveMC/chic2incl_psip_mc-1.root run/chic2incl/event_data/chic2incl_psip_mc_event-1.root                                                              
	   ;;

    0.1.7) echo "Generate Condor jobs on MC event..."
        mkdir -p run/chic2incl/job_text/inclusiveMC_event
        mkdir -p run/chic2incl/event_inclusiveMC
        cd scripts/gen_script
        rm ../../run/chic2incl/job_text/inclusiveMC_event/jobOptions_chic2incl_inclusive_mc_event-*
        ./make_jobOption_file_inclusiveMC_event.sh
        cd ../../run/chic2incl/job_text/inclusiveMC_event
        chmod 755 jobOptions_chic2incl_inclusive_mc_event-*
        mv jobOptions_chic2incl_inclusive_mc_event-394.sh jobOptions_chic2incl_inclusive_mc_event-0.sh
        cd $HOME/bes/chic2invi/v0.1	    
	   ;;

    0.1.8) echo "Submit Condor jobs on MC event..."
        cd run/chic2incl/job_text/inclusiveMC_event
        rm ../../event_inclusiveMC/chic2incl_psip_mc_event-*
        find . -name "*.out.*" | xargs rm
        find . -name "*.err.*" | xargs rm
        hep_sub -g physics -n 394 jobOptions_chic2incl_inclusive_mc_event-%{ProcId}.sh
        cd $HOME/bes/chic2invi/v0.1
        ;;

    0.1.9) echo "Check Condor jobs on MC event..."
	   ./python/chk_condorjobs.py run/chic2incl/event_inclusiveMC  394
	   ;;

	0.1.10) echo  "Merge rootfile on MC event..."
	   mkdir run/chic2incl/hist_inclusiveMC
	   ./python/mrg_rootfiles.py run/chic2incl/event_inclusiveMC run/chic2incl/hist_inclusiveMC
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
	    mkdir run/chic2incl/job_text/data3650
	    mkdir run/chic2incl/rootfile_data3650
		cd run/chic2incl/gen_script
		./make_jobOption_file_data3650.sh
		cd ../job_text/data3650
		mv jobOptions_chic2invi_data3650-84.txt jobOptions_chic2invi_data3650-0.txt
		boss.condor -g physics -n 84 jobOptions_chic2invi_data3650-%{ProcId}.txt
        cd $HOME/bes/chic2invi/v0.1	    
        ;;

    0.2.3) echo "Check Condor jobs on con3650 data..."
	   ./python/chk_condorjobs.py run/chic2incl/rootfile_data3650  84 
	   ;;

	0.2.4) echo  "Merge root file on con3650 data..."
	   mkdir run/chic2incl/hist_data3650
	   ./python/mrg_rootfiles.py run/chic2incl/rootfile_data3650 run/chic2incl/hist_data3650 
	   ;;

    0.2.5) echo  "Select event on con3650 data..."
	   mkdir run/analysis
	   root analysis.cxx
	   ;; 



   # --------------------------------------------------------------------------
   #    0.3  signal MC of chic0->gamgam and chic0->gamnunu
        # --------------------------------------------------------------------------
                 #---------now is chic0->gamgam------------
    0.3) echo "running on signal MC of chic0->gamgam..."
         ;;

    0.3.1) echo "chic0->gg:simulate 6000 signal MC samples--rtraw..."
           mkdir run/chic0gamgam_mc_rtraw
           #cd  gen_mc
           boss.exe run/gen_mc/jobOptions_sim_gamgam.txt          
           #boss.condor -g physics jobOptions_sim_gamgam.txt           
           cd ..
            ;;

    0.3.2) echo "chic0->gg:reconstruct--dst..."
           mkdir run/chic0gamgam_mc_dst
           cd gen_mc 
	   boss.exe jobOptions_rec_gamgam.txt
          # boss.condor -g physics jobOptions_rec_gamgam.txt
            ;;

    0.3.3) echo "chic0->gg:run algorithm--root..."
           mkdir run/chic0gamgam_mc_root
           cd gen_mc
          # boss.exe jobOptions_gamgam_gen_mc.txt
           boss.condor -g physics jobOptions_gamgam_gen_mc.txt
           ;;
    
    0.3.4) echo "chic0->gg:select event with ngam=3--root..."
           #mkdir run/chic0gamgam_mc_sel_ngam3
           ./python/sel_events_chic0gamgam.py
           ;;
    0.3.5) echo "chic0->gg:plot the gamma energy..."
           mkdir run/chic0gamgam_mc_plot
           ./python/plot
           ;;

                 #---------------Now is chic0->gamnunu-------------
    0.3.6) echo "Now is signal MC of chic0->gamnunu..."
         ;;

    0.3.7) echo "chic0->gamnunu:simulate 6000 signal MC samples--rtraw..."
          mkdir run/chic0gamnunu_mc_rtraw
          cd gen_mc
          boss.condor -g physics jobOptions_sim_gamnunu.txt 
         # boss.exe jobOptions_sim_gamnunu.txt
          cd ..
            ;;

    0.3.8) echo "chic0->gamnunu:reconstruct--dst..."
          mkdir run/chic0gamnunu_mc_dst
          cd gen_mc
       #   boss.condor -g physics jobOptions_rec_gamnunu.txt
          boss.exe jobOptions_rec_gamnunu.txt
            ;;

    0.3.9) echo "chic0->gamnunu:run algorithm--root..."
          mkdir run/chic0gamnunu_mc_root/
	  cd gen_mc
         # boss.exe jobOptions_gamnunu_gen_mc.txt
           boss.condor -g physics jobOptions_gamnunu_gen_mc.txt
           ;;

    0.4) echo "signal MC sample..."
	 ;;

    0.4.1) echo "simulation -- generate signal MC sample..."
	    cd scripts/chic0_invi/jobs_chic0
        boss.condor -g physics jobOptions_sim_chic0.txt
        cd ../../chic1_invi/jobs_chic1
        boss.condor -g physics jobOptions_sim_chic1.txt
        cd ../../chic2_invi/jobOptions_chic2
        boss.condor -g physics jobOptions_sim_chic2.txt
        cd $HOME/bes/chic2invi/v0.1
	    ;;

    0.4.2) echo "reconstruction -- generate signal MC sample..."
	    cd scripts/chic0_invi/jobs_chic0
        boss.condor -g physics jobOptions_rec_chic0.txt
        cd ../../chic1_invi/jobs_chic1
        boss.condor -g physics jobOptions_rec_chic1.txt
        cd ../../chic2_invi/jobOptions_chic2
        boss.condor -g physics jobOptions_rec_chic2.txt
        cd $HOME/bes/chic2invi/v0.1
	    ;;

    0.4.3) echo "run on signal MC sample..."
	    cd scripts/chic0_invi/jobs_chic0
        boss.condor -g physics jobOptions_chic0_gam2invi_gen_mc.txt
        cd ../../chic1_invi/jobs_chic1
        boss.condor -g physics jobOptions_chic1_gam2invi_gen_mc.txt
        cd ../../chic2_invi/jobOptions_chic2        
        boss.condor -g physics jobOptions_chic2_gam2invi_gen_mc.txt
        cd $HOME/bes/chic2invi/v0.1
	    ;;

     0.4.4) echo "select events on signal MC sample..."
        ./python/sel_events.py scripts/chic0_invi/rootfile_chic0/chic0_gam2invi_gen_mc.root scripts/chic0_invi/event_chic0/chic0_gam2invi_gen_mc_event.root
        ./python/sel_events.py scripts/chic1_invi/rootfile_chic1/chic1_gam2invi_gen_mc.root scripts/chic1_invi/event_chic1/chic1_gam2invi_gen_mc_event.root
        ./python/sel_events.py scripts/chic2_invi/rootfile_chic2/chic2_gam2invi_gen_mc.root scripts/chic2_invi/event_chic2/chic2_gam2invi_gen_mc_event.root
	    ;;

     0.4.5) echo "generate plots of signal and inclusive MC samples..."
        ./python/plot_4mc.py
        ./python/plot_same4mc.py
        ./python/plot_signal.py
        ./python/plot_stack3signal.py
        ./python/plot_veto.py
        ;;

    0.5) echo "run on data 2012..."
	 ;;

    0.5.1) echo "Split data 2012 with each group 20G ..."
	    mkdir run/samples/data
	    ./python/get_samples.py /bes3fs/offline/data/664p03/psip/dst run/samples/data/data_664p03_psip.txt 20G
	    # made 84 groups 
	    ;;

    0.5.2) echo "Generate Condor jobs on data 2012 ---- 1..."
	    mkdir run/chic2incl/job_text/data
	    mkdir run/chic2incl/rootfile_data
		cd scripts/gen_script
		./make_jobOption_file_data.sh
		cd ../../run/chic2incl/job_text/data
		mv jobOptions_chic2invi_data-633.txt jobOptions_chic2invi_data-0.txt
        cd $HOME/bes/chic2invi/v0.1	 
        ;;   

    0.5.3) echo "Test on data 2012..."
        echo "have you changed test number?(yes / NO)
        ./run/chic2incl/job_text/data/jobOptions_chic2invi_data-0.txt"
        read opt
        if [ $opt == "yes" ]
            then
            echo "now in yes"  
            cd run/chic2incl/job_text/data
            boss.exe jobOptions_inclusive_psip_data-0.txt
            cd $HOME/bes/chic2invi/v0.1
        else
            echo "Default value is 'NO', please change test number."
        fi
        ;;

    0.5.4) echo "Submit Condor jobs on data 2012 ---- 2..."
        cd run/chic2incl/job_text/data
        find . -name "*.out.*" | xargs rm
        find . -name "*.err.*" | xargs rm
		boss.condor -g physics -n 633 jobOptions_inclusive_psip_data-%{ProcId}.txt
        cd $HOME/bes/chic2invi/v0.1	    
        ;;

    0.5.5) echo "Check Condor jobs on data 2012..."
	   ./python/chk_condorjobs.py run/chic2incl/rootfile_data  633
	   ;;

    0.5.6) echo "Test 1 job on data 2012 event..."
        ./python/sel_events.py run/chic2incl/rootfile_data/chic2incl_psip_data-1.root run/chic2incl/event_data/chic2incl_psip_data_event-1.root                                                              
	   ;;

    0.5.7) echo "Generate Condor jobs on data 2012 event..."
        mkdir -p run/chic2incl/job_text/data_event
        mkdir -p run/chic2incl/event_data
        cd scripts/gen_script
        ./make_jobOption_file_data_event.sh
        cd ../../run/chic2incl/job_text/data_event
        chmod 755 jobOptions_chic2incl_data_event-*
        mv jobOptions_chic2incl_data_event-633.sh jobOptions_chic2incl_data_event-0.sh
        cd $HOME/bes/chic2invi/v0.1	    
	   ;;

    0.5.8) echo "Submit Condor jobs on data 2012 event..."
        cd run/chic2incl/job_text/data_event
        rm ../../event_data/chic2incl_psip_data_event-*
        find . -name "*.out.*" | xargs rm
        find . -name "*.err.*" | xargs rm
        hep_sub -g physics -n 633 jobOptions_chic2incl_data_event-%{ProcId}.sh
        cd $HOME/bes/chic2invi/v0.1
        ;;

    0.5.9) echo "Check Condor jobs on data 2012 event..."
	   ./python/chk_condorjobs.py run/chic2incl/event_data  633
	   ;;

	0.5.10) echo  "Merge rootfile on data 2012 event..."
	   mkdir run/chic2incl/hist_data
	   ./python/mrg_rootfiles.py run/chic2incl/event_data run/chic2incl/hist_data
	   ;;


esac
