#!/bin/bash

JobText_SaveDir=../../run/chicNoTDC/job_text/data_by_5_event

for num in {1..2753}
do
    jobOptions=jobOptions_chicNoTDC_data_by_5_event-${num}.sh
    echo   " #!/bin/bash                                                  " >> ${JobText_SaveDir}/${jobOptions}
    echo   "                                                              " >> ${JobText_SaveDir}/${jobOptions}
    echo   "cd \$HOME/bes/chic2invi/v0.1                                   " >> ${JobText_SaveDir}/${jobOptions}
    echo   "./python/sel_events.py run/chicNoTDC/rootfile_data_by_5/chicNoTDC_psip_data_by_5-${num}.root run/chicNoTDC/event_data_by_5/chicNoTDC_psip_data_by_5_event-${num}.root                                                              " >> ${JobText_SaveDir}/${jobOptions}
done

