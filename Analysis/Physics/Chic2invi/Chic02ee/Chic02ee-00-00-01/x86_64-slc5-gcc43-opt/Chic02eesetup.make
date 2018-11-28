----------> uses
# use BesAIDA BesAIDA-* External
#   use AIDA v* LCG_Interfaces (no_version_directory) (native_version=3.2.1)
#     use LCG_Configuration v*  (no_version_directory)
#     use LCG_Settings v*  (no_version_directory)
#       use LCG_SettingsCompat *  (no_version_directory)
#       use LCG_SettingsCompat *  (no_version_directory)
# use BesPolicy BesPolicy-* 
#   use BesCxxPolicy BesCxxPolicy-* 
#     use GaudiPolicy v*  (no_version_directory)
#       use LCG_Settings *  (no_version_directory)
#       use Python * LCG_Interfaces (no_auto_imports) (no_version_directory) (native_version=2.5.4p2)
#         use LCG_Configuration v*  (no_version_directory)
#         use LCG_Settings v*  (no_version_directory)
#       use tcmalloc v* LCG_Interfaces (no_auto_imports) (no_version_directory) (native_version=1.4)
#         use LCG_Configuration v*  (no_version_directory)
#         use LCG_Settings v*  (no_version_directory)
#   use BesFortranPolicy BesFortranPolicy-* 
#     use LCG_Settings v*  (no_version_directory)
# use GaudiInterface GaudiInterface-* External
#   use GaudiKernel *  (no_version_directory)
#     use GaudiPolicy v*  (no_version_directory)
#     use ROOT v* LCG_Interfaces (no_version_directory) (native_version=5.24.00b)
#       use LCG_Configuration v*  (no_version_directory)
#       use LCG_Settings v*  (no_version_directory)
#       use GCCXML v* LCG_Interfaces (no_auto_imports) (no_version_directory) (native_version=0.9.0_20090601)
#         use LCG_Configuration v*  (no_version_directory)
#         use LCG_Settings v*  (no_version_directory)
#       use Python v* LCG_Interfaces (no_auto_imports) (no_version_directory)
#     use Reflex v* LCG_Interfaces (no_version_directory)
#       use LCG_Configuration v*  (no_version_directory)
#       use LCG_Settings v*  (no_version_directory)
#       use ROOT v* LCG_Interfaces (no_auto_imports) (no_version_directory) (native_version=5.24.00b)
#     use Boost v* LCG_Interfaces (no_version_directory) (native_version=1.39.0_python2.5)
#       use LCG_Configuration v*  (no_version_directory)
#       use LCG_Settings v*  (no_version_directory)
#       use Python v* LCG_Interfaces (no_auto_imports) (no_version_directory) (native_version=2.5.4p2)
#     use CppUnit v* LCG_Interfaces (private) (no_auto_imports) (no_version_directory) (native_version=1.12.1_p1)
#       use LCG_Configuration v*  (no_version_directory)
#       use LCG_Settings v*  (no_version_directory)
#   use GaudiSvc *  (no_version_directory)
#     use GaudiKernel v*  (no_version_directory)
#     use Reflex v* LCG_Interfaces (no_auto_imports) (no_version_directory)
#     use CLHEP v* LCG_Interfaces (no_auto_imports) (no_version_directory) (native_version=2.0.4.5)
#       use LCG_Configuration v*  (no_version_directory)
#       use LCG_Settings v*  (no_version_directory)
#     use AIDA v* LCG_Interfaces (no_auto_imports) (no_version_directory) (native_version=3.2.1)
#     use Boost v* LCG_Interfaces (no_auto_imports) (no_version_directory) (native_version=1.39.0_python2.5)
#     use ROOT v* LCG_Interfaces (no_auto_imports) (no_version_directory) (native_version=5.24.00b)
#     use PCRE v* LCG_Interfaces (no_auto_imports) (no_version_directory) (native_version=4.4)
#       use LCG_Configuration v*  (no_version_directory)
#       use LCG_Settings v*  (no_version_directory)
# use DstEvent DstEvent-* Event
#   use BesPolicy BesPolicy-* 
#   use GaudiInterface GaudiInterface-* External
#   use BesCLHEP BesCLHEP-* External
#     use CLHEP v* LCG_Interfaces (no_version_directory) (native_version=2.0.4.5)
#     use HepMC * LCG_Interfaces (no_version_directory) (native_version=2.03.11)
#       use LCG_Configuration v*  (no_version_directory)
#       use LCG_Settings v*  (no_version_directory)
#     use HepPDT * LCG_Interfaces (no_version_directory) (native_version=2.05.04)
#       use LCG_Configuration v*  (no_version_directory)
#       use LCG_Settings v*  (no_version_directory)
#     use BesExternalArea BesExternalArea-* External
#   use EventModel EventModel-* Event
#     use BesPolicy BesPolicy-* 
#     use GaudiInterface GaudiInterface-* External
# use EventModel EventModel-* Event
# use TrigEvent TrigEvent-* Event
#   use BesPolicy BesPolicy-* 
#   use GaudiInterface GaudiInterface-01-* External
# use ParticleID ParticleID-* Analysis
#   use BesPolicy BesPolicy-01-* 
#   use GaudiInterface GaudiInterface-01-* External
#   use DstEvent DstEvent-* Event
#   use BesROOT BesROOT-* External
#     use CASTOR v* LCG_Interfaces (no_version_directory) (native_version=2.1.8-10)
#       use LCG_Configuration v*  (no_version_directory)
#       use LCG_Settings v*  (no_version_directory)
#     use ROOT v* LCG_Interfaces (no_version_directory) (native_version=5.24.00b)
#   use EvtRecEvent EvtRecEvent-* Event
#     use BesPolicy BesPolicy-* 
#     use GaudiInterface GaudiInterface-* External
#     use BesCLHEP BesCLHEP-* External
#     use EventModel EventModel-* Event
#     use EvTimeEvent EvTimeEvent-* Event
#       use BesPolicy BesPolicy-01-* 
#       use GaudiInterface GaudiInterface-01-* External
#       use BesCLHEP BesCLHEP-* External
#       use MdcGeomSvc MdcGeomSvc-* Mdc
#         use BesPolicy BesPolicy-01-* 
#         use GaudiInterface GaudiInterface-* External
#         use calibUtil * Calibration
#           use GaudiInterface GaudiInterface-01-* External
#           use facilities * Calibration
#             use BesPolicy BesPolicy-* 
#           use xmlBase * Calibration
#             use BesPolicy * 
#             use XercesC * LCG_Interfaces (no_version_directory) (native_version=2.8.0)
#               use LCG_Configuration v*  (no_version_directory)
#               use LCG_Settings v*  (no_version_directory)
#             use facilities * Calibration
#           use rdbModel * Calibration
#             use BesPolicy * 
#             use facilities * Calibration
#             use xmlBase * Calibration
#             use MYSQL * External
#               use mysql * LCG_Interfaces (no_version_directory) (native_version=5.0.18)
#                 use LCG_Configuration v*  (no_version_directory)
#                 use LCG_Settings v*  (no_version_directory)
#           use BesROOT BesROOT-00-* External
#           use DatabaseSvc DatabaseSvc-* Database
#             use BesPolicy BesPolicy-* 
#             use GaudiInterface GaudiInterface-* External
#             use mysql * LCG_Interfaces (no_version_directory) (native_version=5.0.18)
#             use sqlite * LCG_Interfaces (no_version_directory) (native_version=3.6.8)
#               use LCG_Configuration v*  (no_version_directory)
#               use LCG_Settings v*  (no_version_directory)
#             use BesROOT * External
#         use CalibData * Calibration
#           use facilities facilities-* Calibration
#           use GaudiInterface * External
#           use BesROOT BesROOT-00-* External
#         use EventModel EventModel-* Event
#         use BesCLHEP BesCLHEP-00-* External (private)
#       use RelTable RelTable-* Event
#         use BesPolicy BesPolicy-01-* 
#         use GaudiInterface GaudiInterface-01-* External
#       use EventModel EventModel-* Event
#       use Identifier Identifier-* DetectorDescription
#         use BesPolicy BesPolicy-* 
#     use MdcRecEvent MdcRecEvent-* Mdc
#       use BesPolicy BesPolicy-01-* 
#       use GaudiInterface GaudiInterface-01-* External
#       use MdcGeomSvc MdcGeomSvc-* Mdc
#       use RelTable RelTable-* Event
#       use EventModel EventModel-* Event
#       use Identifier Identifier-* DetectorDescription
#       use DstEvent DstEvent-* Event
#       use BesCLHEP BesCLHEP-* External (private)
#     use TofRecEvent TofRecEvent-* Tof
#       use BesPolicy BesPolicy-01-* 
#       use GaudiInterface GaudiInterface-01-* External
#       use Identifier Identifier-* DetectorDescription
#       use EventModel EventModel-* Event
#       use DstEvent * Event
#     use EmcRecEventModel EmcRecEventModel-* Emc
#       use BesPolicy BesPolicy-* 
#       use Identifier Identifier-* DetectorDescription
#       use BesCLHEP BesCLHEP-* External
#       use EventModel EventModel-* Event
#       use DstEvent DstEvent-* Event
#       use EmcRecGeoSvc EmcRecGeoSvc-* Emc
#         use BesPolicy BesPolicy-* 
#         use Identifier Identifier-* DetectorDescription
#         use ROOTGeo ROOTGeo-* DetectorDescription
#           use BesPolicy BesPolicy-01-* 
#           use GaudiInterface GaudiInterface-* External
#           use BesCLHEP BesCLHEP-* External
#           use BesROOT BesROOT-* External
#           use XercesC * LCG_Interfaces (no_version_directory) (native_version=2.8.0)
#           use GdmlToRoot GdmlToRoot-* External
#             use BesExternalArea BesExternalArea-* External
#             use BesROOT BesROOT-* External
#           use GdmlManagement GdmlManagement-* DetectorDescription
#             use BesExternalArea BesExternalArea-* External
#         use BesCLHEP BesCLHEP-* External
#         use GaudiInterface GaudiInterface-* External
#     use MucRecEvent MucRecEvent-* Muc
#       use BesPolicy BesPolicy-01-* 
#       use GaudiInterface GaudiInterface-01-* External
#       use Identifier Identifier-* DetectorDescription
#       use EventModel EventModel-* Event
#       use ExtEvent ExtEvent-* Event
#         use BesPolicy BesPolicy-01-* 
#         use GaudiInterface GaudiInterface-01-* External
#         use BesCLHEP BesCLHEP-* External
#         use EventModel EventModel-* Event
#         use DstEvent DstEvent-* Event
#       use MucGeomSvc MucGeomSvc-* Muc
#         use BesPolicy BesPolicy-01-* 
#         use GaudiInterface GaudiInterface-* External
#         use Identifier Identifier-* DetectorDescription
#         use ROOTGeo ROOTGeo-* DetectorDescription
#         use BesCLHEP BesCLHEP-* External
#         use BesROOT BesROOT-* External
#         use XercesC * LCG_Interfaces (no_version_directory) (native_version=2.8.0)
#         use GdmlToRoot GdmlToRoot-* External
#         use G4Geo G4Geo-* DetectorDescription
#           use BesPolicy BesPolicy-01-* 
#           use GaudiInterface GaudiInterface-* External
#           use BesCLHEP BesCLHEP-* External
#           use BesGeant4 BesGeant4-* External
#             use BesExternalArea BesExternalArea-00-* External
#             use BesCLHEP BesCLHEP-00-* External
#           use XercesC * LCG_Interfaces (no_version_directory) (native_version=2.8.0)
#           use GdmlToG4 GdmlToG4-* External
#             use BesExternalArea BesExternalArea-* External
#             use BesGeant4 BesGeant4-* External
#             use XercesC * LCG_Interfaces (no_version_directory) (native_version=2.8.0)
#           use GdmlManagement GdmlManagement-* DetectorDescription
#           use Identifier Identifier-* DetectorDescription
#           use SimUtil SimUtil-* Simulation/BOOST
#             use BesPolicy BesPolicy-01-* 
#             use BesGeant4 BesGeant4-00-* External
#       use DstEvent DstEvent-* Event
#       use BesCLHEP BesCLHEP-* External (private)
#     use ExtEvent ExtEvent-* Event
#     use DstEvent DstEvent-* Event
#   use MdcRecEvent MdcRecEvent-* Mdc
#   use TofRecEvent TofRecEvent-* Tof
#   use EmcRecEventModel EmcRecEventModel-* Emc
#   use MucRecEvent MucRecEvent-* Muc
#   use ExtEvent ExtEvent-* Event
# use VertexFit VertexFit-* Analysis
#   use BesPolicy BesPolicy-01-* 
#   use GaudiInterface GaudiInterface-* External
#   use BesCLHEP BesCLHEP-* External
#   use MYSQL MYSQL-* External
#   use DstEvent DstEvent-* Event
#   use MdcRecEvent MdcRecEvent-* Mdc
#   use EmcRecEventModel EmcRecEventModel-* Emc
#   use MagneticField MagneticField-* 
#     use BesPolicy BesPolicy-01-* 
#     use GaudiInterface GaudiInterface-* External
#     use BesCLHEP * External
#     use BesROOT * External
#     use EventModel EventModel-* Event
#     use rdbModel * Calibration
#     use DatabaseSvc * Database
#     use BesTimerSvc BesTimerSvc-* Utilities
#       use BesPolicy BesPolicy-* 
#       use GaudiInterface GaudiInterface-* External
#   use EventModel EventModel-* Event
#   use EvtRecEvent EvtRecEvent-* Event
#   use DatabaseSvc DatabaseSvc-* Database
# use BesROOT BesROOT-00-* External
# use McTruth McTruth-* Event
#   use BesPolicy BesPolicy-01-* 
#   use EventModel EventModel-* Event
#   use GaudiInterface GaudiInterface-01-* External
#   use Identifier Identifier-* DetectorDescription
#   use RelTable RelTable-* Event
#   use BesCLHEP BesCLHEP-* External (private)
# use MdcRecEvent MdcRecEvent-* Mdc
# use MucRecEvent MucRecEvent-* Muc
#
# Selection :
use CMT v1r20p20081118 (/afs/ihep.ac.cn/bes3/offline/ExternalLib/contrib)
use BesExternalArea BesExternalArea-00-00-21 External (/afs/ihep.ac.cn/bes3/offline/Boss/6.6.4.p03/)
use GdmlManagement GdmlManagement-00-00-31 DetectorDescription (/afs/ihep.ac.cn/bes3/offline/Boss/6.6.4.p03/)
use LCG_SettingsCompat v1  (/afs/ihep.ac.cn/bes3/offline/ExternalLib/lcg/app/releases/LCGCMT/LCGCMT_57a_clhep2.0.4.5)
use LCG_Settings v1  (/afs/ihep.ac.cn/bes3/offline/ExternalLib/lcg/app/releases/LCGCMT/LCGCMT_57a_clhep2.0.4.5)
use BesFortranPolicy BesFortranPolicy-00-01-03  (/afs/ihep.ac.cn/bes3/offline/Boss/6.6.4.p03)
use LCG_Configuration v1  (/afs/ihep.ac.cn/bes3/offline/ExternalLib/lcg/app/releases/LCGCMT/LCGCMT_57a_clhep2.0.4.5)
use sqlite v1 LCG_Interfaces (/afs/ihep.ac.cn/bes3/offline/ExternalLib/lcg/app/releases/LCGCMT/LCGCMT_57a_clhep2.0.4.5/)
use mysql v1 LCG_Interfaces (/afs/ihep.ac.cn/bes3/offline/ExternalLib/lcg/app/releases/LCGCMT/LCGCMT_57a_clhep2.0.4.5/)
use MYSQL MYSQL-00-00-09 External (/afs/ihep.ac.cn/bes3/offline/Boss/6.6.4.p03/)
use XercesC v1 LCG_Interfaces (/afs/ihep.ac.cn/bes3/offline/ExternalLib/lcg/app/releases/LCGCMT/LCGCMT_57a_clhep2.0.4.5/)
use CASTOR v1 LCG_Interfaces (/afs/ihep.ac.cn/bes3/offline/ExternalLib/lcg/app/releases/LCGCMT/LCGCMT_57a_clhep2.0.4.5/)
use HepPDT v1 LCG_Interfaces (/afs/ihep.ac.cn/bes3/offline/ExternalLib/lcg/app/releases/LCGCMT/LCGCMT_57a_clhep2.0.4.5/)
use HepMC v1 LCG_Interfaces (/afs/ihep.ac.cn/bes3/offline/ExternalLib/lcg/app/releases/LCGCMT/LCGCMT_57a_clhep2.0.4.5/)
use PCRE v1 LCG_Interfaces (/afs/ihep.ac.cn/bes3/offline/ExternalLib/lcg/app/releases/LCGCMT/LCGCMT_57a_clhep2.0.4.5/) (no_auto_imports)
use CLHEP v1 LCG_Interfaces (/afs/ihep.ac.cn/bes3/offline/ExternalLib/lcg/app/releases/LCGCMT/LCGCMT_57a_clhep2.0.4.5/)
use BesCLHEP BesCLHEP-00-00-09 External (/afs/ihep.ac.cn/bes3/offline/Boss/6.6.4.p03/)
use BesGeant4 BesGeant4-00-00-09 External (/afs/ihep.ac.cn/bes3/offline/Boss/6.6.4.p03/)
use GdmlToG4 GdmlToG4-00-00-10 External (/afs/ihep.ac.cn/bes3/offline/Boss/6.6.4.p03/)
use CppUnit v1 LCG_Interfaces (/afs/ihep.ac.cn/bes3/offline/ExternalLib/lcg/app/releases/LCGCMT/LCGCMT_57a_clhep2.0.4.5/) (no_auto_imports)
use GCCXML v1 LCG_Interfaces (/afs/ihep.ac.cn/bes3/offline/ExternalLib/lcg/app/releases/LCGCMT/LCGCMT_57a_clhep2.0.4.5/) (no_auto_imports)
use tcmalloc v1 LCG_Interfaces (/afs/ihep.ac.cn/bes3/offline/ExternalLib/lcg/app/releases/LCGCMT/LCGCMT_57a_clhep2.0.4.5/) (no_auto_imports)
use Python v1 LCG_Interfaces (/afs/ihep.ac.cn/bes3/offline/ExternalLib/lcg/app/releases/LCGCMT/LCGCMT_57a_clhep2.0.4.5/) (no_auto_imports)
use Boost v1 LCG_Interfaces (/afs/ihep.ac.cn/bes3/offline/ExternalLib/lcg/app/releases/LCGCMT/LCGCMT_57a_clhep2.0.4.5/)
use ROOT v1 LCG_Interfaces (/afs/ihep.ac.cn/bes3/offline/ExternalLib/lcg/app/releases/LCGCMT/LCGCMT_57a_clhep2.0.4.5/)
use BesROOT BesROOT-00-00-07 External (/afs/ihep.ac.cn/bes3/offline/Boss/6.6.4.p03/)
use GdmlToRoot GdmlToRoot-00-00-13 External (/afs/ihep.ac.cn/bes3/offline/Boss/6.6.4.p03/)
use Reflex v1 LCG_Interfaces (/afs/ihep.ac.cn/bes3/offline/ExternalLib/lcg/app/releases/LCGCMT/LCGCMT_57a_clhep2.0.4.5/)
use GaudiPolicy v10r4  (/afs/ihep.ac.cn/bes3/offline/ExternalLib/Gaudi/GAUDI_v21r6/x86_64-slc5-gcc43-clhep2.0.4.5)
use GaudiKernel v27r6  (/afs/ihep.ac.cn/bes3/offline/ExternalLib/Gaudi/GAUDI_v21r6/x86_64-slc5-gcc43-clhep2.0.4.5)
use BesCxxPolicy BesCxxPolicy-00-01-01  (/afs/ihep.ac.cn/bes3/offline/Boss/6.6.4.p03)
use BesPolicy BesPolicy-01-05-03  (/afs/ihep.ac.cn/bes3/offline/Boss/6.6.4.p03)
use SimUtil SimUtil-00-00-37 Simulation/BOOST (/afs/ihep.ac.cn/bes3/offline/Boss/6.6.4.p03/)
use Identifier Identifier-00-02-13 DetectorDescription (/afs/ihep.ac.cn/bes3/offline/Boss/6.6.4.p03/)
use facilities facilities-00-00-03 Calibration (/afs/ihep.ac.cn/bes3/offline/Boss/6.6.4.p03/)
use xmlBase xmlBase-00-00-02 Calibration (/afs/ihep.ac.cn/bes3/offline/Boss/6.6.4.p03/)
use rdbModel rdbModel-00-01-00 Calibration (/afs/ihep.ac.cn/bes3/offline/Boss/6.6.4.p03/)
use AIDA v1 LCG_Interfaces (/afs/ihep.ac.cn/bes3/offline/ExternalLib/lcg/app/releases/LCGCMT/LCGCMT_57a_clhep2.0.4.5/)
use GaudiSvc v18r6  (/afs/ihep.ac.cn/bes3/offline/ExternalLib/Gaudi/GAUDI_v21r6/x86_64-slc5-gcc43-clhep2.0.4.5)
use GaudiInterface GaudiInterface-01-03-07 External (/afs/ihep.ac.cn/bes3/offline/Boss/6.6.4.p03/)
use BesTimerSvc BesTimerSvc-00-00-12 Utilities (/afs/ihep.ac.cn/bes3/offline/Boss/6.6.4.p03/)
use G4Geo G4Geo-00-00-11 DetectorDescription (/afs/ihep.ac.cn/bes3/offline/Boss/6.6.4.p03/)
use ROOTGeo ROOTGeo-00-00-15 DetectorDescription (/afs/ihep.ac.cn/bes3/offline/Boss/6.6.4.p03/)
use MucGeomSvc MucGeomSvc-00-02-25 Muc (/afs/ihep.ac.cn/bes3/offline/Boss/6.6.4.p03/)
use EmcRecGeoSvc EmcRecGeoSvc-01-01-07 Emc (/afs/ihep.ac.cn/bes3/offline/Boss/6.6.4.p03/)
use RelTable RelTable-00-00-02 Event (/afs/ihep.ac.cn/bes3/offline/Boss/6.6.4.p03/)
use CalibData CalibData-00-01-09 Calibration (/afs/ihep.ac.cn/bes3/offline/Boss/6.6.4.p03/)
use DatabaseSvc DatabaseSvc-00-00-24 Database (/afs/ihep.ac.cn/bes3/offline/Boss/6.6.4.p03/)
use calibUtil calibUtil-00-00-38 Calibration (/afs/ihep.ac.cn/bes3/offline/Boss/6.6.4.p03/)
use TrigEvent TrigEvent-00-01-01 Event (/afs/ihep.ac.cn/bes3/offline/Boss/6.6.4.p03/)
use EventModel EventModel-01-05-31 Event (/afs/ihep.ac.cn/bes3/offline/Boss/6.6.4.p03/)
use McTruth McTruth-00-02-19 Event (/afs/ihep.ac.cn/bes3/offline/Boss/6.6.4.p03/)
use MagneticField MagneticField-00-01-38  (/afs/ihep.ac.cn/bes3/offline/Boss/6.6.4.p03)
use MdcGeomSvc MdcGeomSvc-00-01-37 Mdc (/afs/ihep.ac.cn/bes3/offline/Boss/6.6.4.p03/)
use EvTimeEvent EvTimeEvent-00-00-08 Event (/afs/ihep.ac.cn/bes3/offline/Boss/6.6.4.p03/)
use DstEvent DstEvent-00-02-50-p01 Event (/afs/ihep.ac.cn/bes3/offline/Boss/6.6.4.p03/)
use ExtEvent ExtEvent-00-00-13 Event (/afs/ihep.ac.cn/bes3/offline/Boss/6.6.4.p03/)
use MucRecEvent MucRecEvent-00-02-50-p01 Muc (/afs/ihep.ac.cn/bes3/offline/Boss/6.6.4.p03/)
use EmcRecEventModel EmcRecEventModel-01-01-18 Emc (/afs/ihep.ac.cn/bes3/offline/Boss/6.6.4.p03/)
use TofRecEvent TofRecEvent-00-02-14 Tof (/afs/ihep.ac.cn/bes3/offline/Boss/6.6.4.p03/)
use MdcRecEvent MdcRecEvent-00-05-14 Mdc (/afs/ihep.ac.cn/bes3/offline/Boss/6.6.4.p03/)
use EvtRecEvent EvtRecEvent-00-01-04 Event (/afs/ihep.ac.cn/bes3/offline/Boss/6.6.4.p03/)
use VertexFit VertexFit-00-02-71 Analysis (/afs/ihep.ac.cn/bes3/offline/Boss/6.6.4.p03/)
use ParticleID ParticleID-00-04-54 Analysis (/afs/ihep.ac.cn/bes3/offline/Boss/6.6.4.p03/)
use BesAIDA BesAIDA-00-00-01 External (/afs/ihep.ac.cn/bes3/offline/Boss/6.6.4.p03/)
----------> tags
CMTv1 (from CMTVERSION)
CMTr20 (from CMTVERSION)
CMTp20081118 (from CMTVERSION)
Linux (from uname) package BesPolicy implies [Unix host-linux]
x86_64-slc5-gcc43-opt (from CMTCONFIG) package LCG_Settings implies [Linux slc5-amd64 gcc43 optimized target-linux target-x86_64 target-slc5 target-gcc43 target-opt]
chic2invi_no_config (from PROJECT) excludes [chic2invi_config]
chic2invi_root (from PROJECT) excludes [chic2invi_no_root]
chic2invi_cleanup (from PROJECT) excludes [chic2invi_no_cleanup]
chic2invi_no_prototypes (from PROJECT) excludes [chic2invi_prototypes]
chic2invi_with_installarea (from PROJECT) excludes [chic2invi_without_installarea]
chic2invi_with_version_directory (from PROJECT) excludes [chic2invi_without_version_directory]
chic2invi (from PROJECT)
BOSS_no_config (from PROJECT) excludes [BOSS_config]
BOSS_root (from PROJECT) excludes [BOSS_no_root]
BOSS_cleanup (from PROJECT) excludes [BOSS_no_cleanup]
BOSS_no_prototypes (from PROJECT) excludes [BOSS_prototypes]
BOSS_with_installarea (from PROJECT) excludes [BOSS_without_installarea]
BOSS_with_version_directory (from PROJECT) excludes [BOSS_without_version_directory]
GAUDI_no_config (from PROJECT) excludes [GAUDI_config]
GAUDI_root (from PROJECT) excludes [GAUDI_no_root]
GAUDI_cleanup (from PROJECT) excludes [GAUDI_no_cleanup]
GAUDI_prototypes (from PROJECT) excludes [GAUDI_no_prototypes]
GAUDI_with_installarea (from PROJECT) excludes [GAUDI_without_installarea]
GAUDI_without_version_directory (from PROJECT) excludes [GAUDI_with_version_directory]
LCGCMT_no_config (from PROJECT) excludes [LCGCMT_config]
LCGCMT_no_root (from PROJECT) excludes [LCGCMT_root]
LCGCMT_cleanup (from PROJECT) excludes [LCGCMT_no_cleanup]
LCGCMT_prototypes (from PROJECT) excludes [LCGCMT_no_prototypes]
LCGCMT_without_installarea (from PROJECT) excludes [LCGCMT_with_installarea]
LCGCMT_with_version_directory (from PROJECT) excludes [LCGCMT_without_version_directory]
x86_64 (from package CMT) package LCG_Settings implies [host-x86_64]
slc55 (from package CMT) package LCG_Settings implies [host-slc5]
gcc432 (from package CMT) package LCG_Settings implies [gcc43 host-gcc43]
Unix (from package CMT) package LCG_Settings implies [host-unix] package LCG_Settings excludes [WIN32 Win32]
ROOT_GE_5_15 (from package LCG_Configuration)
ROOT_GE_5_19 (from package LCG_Configuration)
gcc43 (from package LCG_SettingsCompat)
amd64 (from package LCG_SettingsCompat)
slc5 (from package LCG_SettingsCompat)
slc5-amd64 (from package LCG_SettingsCompat) package LCG_SettingsCompat implies [slc5 amd64]
optimized (from package LCG_SettingsCompat) package BesPolicy implies [opt]
target-unix (from package LCG_Settings)
host-x86_64 (from package LCG_Settings)
host-gcc4 (from package LCG_Settings) package LCG_Settings implies [host-gcc]
host-gcc43 (from package LCG_Settings) package LCG_Settings implies [host-gcc4]
host-gcc (from package LCG_Settings)
host-linux (from package LCG_Settings)
host-unix (from package LCG_Settings)
host-slc5 (from package LCG_Settings) package LCG_Settings implies [host-slc]
host-slc (from package LCG_Settings)
target-linux (from package LCG_Settings) package LCG_Settings implies [target-unix]
target-slc5 (from package LCG_Settings) package LCG_Settings implies [target-slc]
target-opt (from package LCG_Settings)
target-gcc43 (from package LCG_Settings) package LCG_Settings implies [target-gcc4]
target-x86_64 (from package LCG_Settings)
target-slc (from package LCG_Settings)
target-gcc4 (from package LCG_Settings) package LCG_Settings implies [target-gcc]
target-gcc (from package LCG_Settings)
opt (from package BesCxxPolicy) package BesPolicy implies [optimized]
HasAthenaRunTime (from package BesPolicy)
ROOTBasicLibs (from package BesROOT)
----------> CMTPATH
# Add path /afs/ihep.ac.cn/users/a/amitraahul/bes/chic2invi/v0.1 from initialization
# Add path /afs/ihep.ac.cn/bes3/offline/Boss/6.6.4.p03 from initialization
# Add path /afs/ihep.ac.cn/bes3/offline/ExternalLib/Gaudi/GAUDI_v21r6/x86_64-slc5-gcc43-clhep2.0.4.5 from initialization
# Add path /afs/ihep.ac.cn/bes3/offline/ExternalLib/lcg/app/releases/LCGCMT/LCGCMT_57a_clhep2.0.4.5 from initialization
