#!/bin/bash

JobText_SaveDir=../../run/chic2incl/job_text/data09_event

for num in {1..314}
do
    jobOptions=jobOptions_chic2incl_data09_event-${num}.sh
    echo   " #!/bin/bash                                                  " >> ${JobText_SaveDir}/${jobOptions}
    echo   "                                                              " >> ${JobText_SaveDir}/${jobOptions}
    echo   "cd \$HOME/bes/chic2invi/v0.1                                   " >> ${JobText_SaveDir}/${jobOptions}
    echo   "./python/sel_events.py run/chic2incl/rootfile_data09/chic2incl_psip_data09-${num}.root run/chic2incl/event_data09/chic2incl_psip_data09_event-${num}.root                                                              " >> ${JobText_SaveDir}/${jobOptions}
done

