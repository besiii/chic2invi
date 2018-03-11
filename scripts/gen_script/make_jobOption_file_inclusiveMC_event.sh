#!/bin/bash

JobText_SaveDir=../../run/chic2incl/job_text/inclusiveMC_event

for num in {1..394}
do
    jobOptions=jobOptions_chic2incl_inclusive_mc_event-${num}.sh
    echo   " #!/bin/bash                                                  " >> ${JobText_SaveDir}/${jobOptions}
    echo   "                                                              " >> ${JobText_SaveDir}/${jobOptions}
    echo   "cd \$HOME/bes/chic2invi/v0.1                                   " >> ${JobText_SaveDir}/${jobOptions}
    echo   "./python/sel_events.py run/chic2incl/rootfile_inclusiveMC/chic2invi_psip_mc-${num}.root run/chic2incl/event_inclusiveMC/chic2incl_psip_mc_event-${num}.root                                                              " >> ${JobText_SaveDir}/${jobOptions}
done

