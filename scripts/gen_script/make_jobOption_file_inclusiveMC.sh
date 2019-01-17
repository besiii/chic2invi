#!/bin/bash

JobText_SaveDir=../../dat/run/chic2incl/job_text/inclusiveMC

for num in {1..394}
do
    file_list=mc_664p03_psip_12mc_20G-${num}.txt
    rootfile=chic2incl_psip_mc-${num}.root
    jobOptions=jobOptions_inclusive_psip_mc-${num}.txt
    echo   "#include \"\$ROOTIOROOT/share/jobOptions_ReadRec.txt\"        "  > ${JobText_SaveDir}/${jobOptions}
    echo   "#include \"\$VERTEXFITROOT/share/jobOptions_VertexDbSvc.txt\" " >> ${JobText_SaveDir}/${jobOptions}
    echo   "#include \"\$MAGNETICFIELDROOT/share/MagneticField.txt\"      " >> ${JobText_SaveDir}/${jobOptions}
    echo   "#include \"\$ABSCORROOT/share/jobOptions_AbsCor.txt\"         " >> ${JobText_SaveDir}/${jobOptions}
    echo   "#include \"\$HOME/bes/chic2invi/v0.1/dat/run/samples/inclusiveMC/$file_list\" " >> ${JobText_SaveDir}/${jobOptions}
    echo   "                                                              " >> ${JobText_SaveDir}/${jobOptions}
    echo   "                                                              " >> ${JobText_SaveDir}/${jobOptions}
    echo   "ApplicationMgr.DLLs += {\"Chi2gll\"};                       " >> ${JobText_SaveDir}/${jobOptions}
    echo   "ApplicationMgr.TopAlg += { \"Chi2gll\" };                   " >> ${JobText_SaveDir}/${jobOptions}
    echo   "                                                              " >> ${JobText_SaveDir}/${jobOptions}
    echo   "// Set output level threshold (2=DEBUG, 3=INFO, 4=WARNING, 5=ERROR, 6=FATAL ) " >> ${JobText_SaveDir}/${jobOptions}
    echo   "MessageSvc.OutputLevel = 5;                                   " >> ${JobText_SaveDir}/${jobOptions}
    echo   "                                                              " >> ${JobText_SaveDir}/${jobOptions}
    echo   "// Number of events to be processed (default is 10)           " >> ${JobText_SaveDir}/${jobOptions}
    echo   "//ApplicationMgr.EvtMax = 5000;                               " >> ${JobText_SaveDir}/${jobOptions}
    echo   "ApplicationMgr.EvtMax = -1;                                   " >> ${JobText_SaveDir}/${jobOptions}
    echo   "                                                              " >> ${JobText_SaveDir}/${jobOptions}
    echo   "ApplicationMgr.HistogramPersistency = \"ROOT\";               " >> ${JobText_SaveDir}/${jobOptions}
    echo   "NTupleSvc.Output = {\"FILE1 DATAFILE='$HOME/bes/chic2invi/v0.1/dat/run/chic2incl/rootfile_inclusiveMC/$rootfile' OPT='NEW' TYP='ROOT'\"};" >> ${JobText_SaveDir}/${jobOptions}

    echo   "                                                              " >> ${JobText_SaveDir}/${jobOptions}
    echo   "                                                              " >> ${JobText_SaveDir}/${jobOptions}
done

