#!/bin/bash

JobText_SaveDir=../../run/chicNoTDC/job_text/inclusiveMC_event

for num in {1..394}
do
    jobOptions=jobOptions_chicNoTDC_inclusive_mc_event-${num}.sh
    echo   " #!/bin/bash                                                  " >> ${JobText_SaveDir}/${jobOptions}
    echo   "                                                              " >> ${JobText_SaveDir}/${jobOptions}
    echo   "cd \$HOME/bes/chic2invi/v0.1                                   " >> ${JobText_SaveDir}/${jobOptions}
    echo   "./python/sel_events.py run/chicNoTDC/rootfile_inclusiveMC/chicNoTDC_psip_mc-${num}.root run/chicNoTDC/event_inclusiveMC/chicNoTDC_psip_mc_event-${num}.root                                                              " >> ${JobText_SaveDir}/${jobOptions}
done

