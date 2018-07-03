#!/bin/bash

JobText_SaveDir=../../run/chicNoTDC/job_text/data3650_event

for num in {1..84}
do
    jobOptions=jobOptions_chicNoTDC_data3650_event-${num}.sh
    echo   " #!/bin/bash                                                  " >> ${JobText_SaveDir}/${jobOptions}
    echo   "                                                              " >> ${JobText_SaveDir}/${jobOptions}
    echo   "cd \$HOME/bes/chic2invi/v0.1                                   " >> ${JobText_SaveDir}/${jobOptions}
    echo   "./python/sel_events.py run/chicNoTDC/rootfile_data3650/chicNoTDC_data3650-${num}.root run/chicNoTDC/event_data3650/chicNoTDC_data3650_event-${num}.root                                                              " >> ${JobText_SaveDir}/${jobOptions}
done

