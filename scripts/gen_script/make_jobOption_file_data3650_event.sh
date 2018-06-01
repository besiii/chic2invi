#!/bin/bash

JobText_SaveDir=../../run/chic2incl/job_text/data3650_event

for num in {1..84}
do
    jobOptions=jobOptions_chic2incl_data3650_event-${num}.sh
    echo   " #!/bin/bash                                                  " >> ${JobText_SaveDir}/${jobOptions}
    echo   "                                                              " >> ${JobText_SaveDir}/${jobOptions}
    echo   "cd \$HOME/bes/chic2invi/v0.1                                   " >> ${JobText_SaveDir}/${jobOptions}
    echo   "./python/sel_events.py run/chic2incl/rootfile_data3650/chic2incl_data3650-${num}.root run/chic2incl/event_data3650/chic2incl_data3650_event-${num}.root                                                              " >> ${JobText_SaveDir}/${jobOptions}
done

