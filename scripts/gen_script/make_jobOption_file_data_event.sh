#!/bin/bash

JobText_SaveDir=../../run/chic2incl/job_text/data_event

for num in {1..633}
do
    jobOptions=jobOptions_chic2incl_data_event-${num}.sh
    echo   " #!/bin/bash                                                  " >> ${JobText_SaveDir}/${jobOptions}
    echo   "                                                              " >> ${JobText_SaveDir}/${jobOptions}
    echo   "cd \$HOME/bes/chic2invi/v0.1                                   " >> ${JobText_SaveDir}/${jobOptions}
    echo   "./python/sel_events_inclusive.py run/chic2incl/rootfile_data/chic2incl_psip_data-${num}.root run/chic2incl/event_data/chic2incl_psip_data_event-${num}.root                                                              " >> ${JobText_SaveDir}/${jobOptions}
done

