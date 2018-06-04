#!/bin/bash

# 120101 25338-25402 64
# 120106 25494-25558    64
# 120111 25684-25695 11
# 120116 25784-25805    21
# 120121 25878-25884 6
# 120126 25971-25992    21
# 120129 26022-26048    26
# 120210 26204-26210 6
# 120215 26294-26312    18
# 120220 26398-26417 19
# 120224 26499-26523    24
# 120304 26577-26590 13
# 120311 26627-26645    18
# 120314 26694-26711    17
# 120321 26820-26834    14
# 120325 26975-26993    18
# 120329 27046-27058    12
# 120330 27059-27083    24

date=120330
JobText_SaveDir=../ee_decay/jobs/$date

for num in {0..24}

do
    num1=$((num + 27059))

    file_list=run_00${num1}_GDimuon_file001_SFO-1.raw
    dstfile=${num}_GDimuon_1.dst
    jobOptions=jobOptions_rec_${num}_GDimoun_1.txt

    # file_list=run_00${num1}_GDimuon_file001_SFO-2.raw
    # dstfile=${num}_GDimuon_2.dst
    # jobOptions=jobOptions_rec_${num}_GDimoun_2.txt

    echo   "//input data                                                           "  > ${JobText_SaveDir}/${jobOptions}
    echo   "#include \"\$RAWDATACNVROOT/share/ReadRawDatajobOptions.txt\"          "  > ${JobText_SaveDir}/${jobOptions}
    echo   "#include \"\$TRIGMAKERALGROOT/share/jobOptions_TrigMakerAlg.txt\"      " >> ${JobText_SaveDir}/${jobOptions}
    echo   "#include \"\$OFFLINEEVENTLOOPMGRROOT/share/OfflineEventLoopMgr_Option.txt\"    " >> ${JobText_SaveDir}/${jobOptions}
    echo   "#include \"\$CALIBSVCROOT/share/job-CalibData.txt\"                    " >> ${JobText_SaveDir}/${jobOptions}
    echo   "#include \"\$MAGNETICFIELDROOT/share/MagneticField.txt\"                        " >> ${JobText_SaveDir}/${jobOptions}
    echo   "#include \"\$ESTIMEALGROOT/share/job_EsTimeAlg.txt\"                        " >> ${JobText_SaveDir}/${jobOptions}
    echo   "                                                                                   " >> ${JobText_SaveDir}/${jobOptions}

    echo   "// PAT+TSF method for MDC reconstruction                        " >> ${JobText_SaveDir}/${jobOptions}
    echo   "#include \"\$MDCXRECOROOT/share/jobOptions_MdcPatTsfRec.txt\"                        " >> ${JobText_SaveDir}/${jobOptions}
    echo   "#include \"\$KALFITALGROOT/share/job_kalfit_numf_data.txt\"                        " >> ${JobText_SaveDir}/${jobOptions}
    echo   "#include \"\$MDCDEDXALGROOT/share/job_dedx_all.txt\"                        " >> ${JobText_SaveDir}/${jobOptions}
    echo   "#include \"\$TRKEXTALGROOT/share/TrkExtAlgOption.txt\"                      " >> ${JobText_SaveDir}/${jobOptions}
    echo   "#include \"\$TOFRECROOT/share/jobOptions_TofRec_Data.txt\"                        " >> ${JobText_SaveDir}/${jobOptions}
    echo   "#include \"\$TOFENERGYRECROOT/share/TofEnergyRecOptions_Data.txt\"                        " >> ${JobText_SaveDir}/${jobOptions}
    echo   "#include \"\$EMCRECROOT/share/EmcRecOptions.txt\"                        " >> ${JobText_SaveDir}/${jobOptions}
    echo   "#include \"\$EMCTIMERECROOT/share/EmcTimeRecOptions.txt\"                        " >> ${JobText_SaveDir}/${jobOptions}
    echo   "#include \"\$MUCRECALGROOT/share/jobOptions_MucRec.txt\"                        " >> ${JobText_SaveDir}/${jobOptions}
    echo   "#include \"\$HLTMAKERALGROOT/share/jobOptions_HltMakerAlg.txt\"                        " >> ${JobText_SaveDir}/${jobOptions}
    echo   "#include \"\$EVENTASSEMBLYROOT/share/EventAssembly.txt\"                        " >> ${JobText_SaveDir}/${jobOptions}
    echo   "#include \"\$PRIMARYVERTEXALGROOT/share/jobOptions_kalman.txt\"                        " >> ${JobText_SaveDir}/${jobOptions}
    echo   "#include \"\$VEEVERTEXALGROOT/share/jobOptions_veeVertex.txt\"                        " >> ${JobText_SaveDir}/${jobOptions}
     echo   "                                                                                   " >> ${JobText_SaveDir}/${jobOptions}

    echo   "//output ROOT DST data                                                             " >> ${JobText_SaveDir}/${jobOptions}
    echo   "#include \"\$ROOTIOROOT/share/jobOptions_Dst2Root_data.txt\"                        " >> ${JobText_SaveDir}/${jobOptions}
 
    echo   "//configure for calibration constants                                             " >> ${JobText_SaveDir}/${jobOptions}
    echo   "#include \"\$CALIBSVCROOT/share/calibConfig_rec_data.txt\"                        " >> ${JobText_SaveDir}/${jobOptions}
 
    echo   "//Set output level threshold (2=DEBUG, 3=INFO, 4=WARNING, 5=ERROR, 6=FATAL )      " >> ${JobText_SaveDir}/${jobOptions}
    echo   "MessageSvc.OutputLevel = 6;                                                       " >> ${JobText_SaveDir}/${jobOptions}
    echo   "                                                                                   " >> ${JobText_SaveDir}/${jobOptions}

    echo   "//input data file                                                                 " >> ${JobText_SaveDir}/${jobOptions}
    echo   "RawDataInputSvc.InputFiles={\"/bes3fs/offline/data/cal/round05/$date/$file_list\"};   " >> ${JobText_SaveDir}/${jobOptions}
    echo   "//output data file                                                                 " >> ${JobText_SaveDir}/${jobOptions}
    echo   "RootCnvSvc.digiRootOutputFile =\"../../dst/$date/$dstfile\";                                 " >> ${JobText_SaveDir}/${jobOptions}
    echo   "//Number of events to be processed (default is 10)                                 " >> ${JobText_SaveDir}/${jobOptions}
    echo   "ApplicationMgr.EvtMax = -1;                                                        " >> ${JobText_SaveDir}/${jobOptions}

    echo   "                                                                                   " >> ${JobText_SaveDir}/${jobOptions}
    echo   "                                                                                   " >> ${JobText_SaveDir}/${jobOptions}
done

