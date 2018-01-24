#!/bin/bash

JobText_SaveDir=../job_text/inclusiveMC_event

for num in {1..394}
do
    jobOptions=jobOptions_chic2incl_inclusive_mc_event-${num}.sh
    echo   " #!/bin/bash                                                  " >> ${JobText_SaveDir}/${jobOptions}
    echo   "                                                              " >> ${JobText_SaveDir}/${jobOptions}
    echo   "cd \$HOME/bes/chic2invi/v0.1                                   " >> ${JobText_SaveDir}/${jobOptions}
    echo   "./python/sel_events_inclusive.py run/chic2invi/rootfile_inclusiveMC/chic2invi_psip_mc-${num}.root run/chic2invi/event_inclusiveMC/chic2incl_psip_mc_event-${num}.root                                                              " >> ${JobText_SaveDir}/${jobOptions}
done

