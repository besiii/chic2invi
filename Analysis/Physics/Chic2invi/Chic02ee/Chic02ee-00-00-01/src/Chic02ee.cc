// -*- C++ -*- //
//
// Description: chic02ee -> e+ e- 
//
// Original Author:  Amit pathak <amit@ihep.ac.cn>
//         Created:  [2018-07-25 Mon 16:30] 
//         Inspired by SHI Xin's code 
//         Helped by maoqiang
//


//
// system include files
//


#include "GaudiKernel/Algorithm.h"
#include "GaudiKernel/DeclareFactoryEntries.h"
#include "GaudiKernel/LoadFactoryEntries.h"
#include "GaudiKernel/NTuple.h"
#include "GaudiKernel/Bootstrap.h"

#include "EvtRecEvent/EvtRecEvent.h"
#include "EvtRecEvent/EvtRecTrack.h"

#include "EventModel/EventHeader.h"
#include "EventModel/EventModel.h"
#include "EventModel/Event.h"
#include "TrigEvent/TrigEvent.h"
#include "TrigEvent/TrigData.h"

#include "CLHEP/Vector/ThreeVector.h"
#include "VertexFit/IVertexDbSvc.h"
#include "VertexFit/Helix.h"
#include "VertexFit/WTrackParameter.h"
#include "VertexFit/VertexFit.h"
#include "DstEvent/TofHitStatus.h"


#include <TFile.h>
#include <TH1.h>
#include <TTree.h>
//
// class declaration //
//

class Chic02ee : public Algorithm {
  
public:
  Chic02ee(const std::string&, ISvcLocator*);
  ~Chic02ee(); 
  StatusCode initialize();
  StatusCode execute();
  StatusCode finalize();

private:


double m_vr0cut, m_vz0cut;
double m_ecms;
double m_total_number_of_charged_max;
double m_cha_costheta_cut;


//output file
std::string m_output_filename;
  bool m_isMonteCarlo; 
  bool m_eventrate;
  TFile* m_fout; 


//define Histograms
TH1F* h_evtflw;


//define Trees
TTree* m_tree;

//
//common info
//
int m_run;
int m_event;

//
//charged tracks
//
int m_ncharged;
int m_nGoodChargedTrack;

//
// vertex
//
double m_vr0;
double m_vz0;

//
// MC truth info
//
int m_evttag;

//
//chic02ee
//
int m_ntrk;


//
//functions
//
void book_histogram();
void book_tree();
void clearVariables();
bool buildChic02ee();
void saveTrkInfo(EvtRecTrackIterator,
		   EvtRecTrackIterator);
int selectChargedTracks(SmartDataPtr<EvtRecEvent>,
			  SmartDataPtr<EvtRecTrackCol>,
			  std::vector<int> &);

bool passVertexSelection(CLHEP::Hep3Vector,
			RecMdcKalTrack*);
CLHEP::Hep3Vector getOrigin();

};

//
//module declare 
//


DECLARE_ALGORITHM_FACTORY( Chic02ee )
DECLARE_FACTORY_ENTRIES( Chic02ee ) {
  DECLARE_ALGORITHM(Chic02ee);
}

LOAD_FACTORY_ENTRIES( Chic02ee )

//
//member functions
//


Chic02ee::Chic02ee(const std::string& name, ISvcLocator* pSvcLocator) :
  Algorithm(name, pSvcLocator),
m_tree(0)
{
declareProperty("OutputFileName",m_output_filename);
declareProperty("IsMonteCarlo",m_isMonteCarlo);
declareProperty("TotalNumberOfChargedMax",m_total_number_of_charged_max = 50);
declareProperty("ChaCosthetaCut", m_cha_costheta_cut = 0.93);

}



StatusCode Chic02ee::initialize(){ MsgStream log(msgSvc(), name());
 log << MSG::INFO << ">>>>>>> in initialize()" << endmsg;

  StatusCode status;
  
  m_fout = new TFile(m_output_filename.c_str(), "RECREATE");
  m_fout->cd(); 

  book_histogram(); 
  book_tree(); 

  log << MSG::INFO << "successfully return from initialize()" <<endmsg; 

 return StatusCode::SUCCESS;
}


StatusCode Chic02ee::execute() {
 MsgStream log(msgSvc(), name());
  log << MSG::INFO << "in execute()" << endreq;
  
  // clear variables 
   clearVariables();
   h_evtflw->Fill(0); //raw
SmartDataPtr<Event::EventHeader> eventHeader(eventSvc(),"/Event/EventHeader");
if (!eventHeader) return StatusCode::FAILURE;

       
m_run = eventHeader->runNumber();
m_event = eventHeader->eventNumber();


	
if (buildChic02ee()) {
m_tree->Fill();// only fill tree for the selected events 
}


return StatusCode::SUCCESS; 
}

StatusCode Chic02ee::finalize() {
MsgStream log(msgSvc(), name());
log << MSG::INFO << "in finalize()" << endmsg;

m_fout->cd();
m_tree->Write();
h_evtflw->Write();
m_fout->Close();

 return StatusCode::SUCCESS;
}


Chic02ee::~Chic02ee() {
}

void Chic02ee::book_histogram() {

h_evtflw = new TH1F("hevtflw","eventflow",13,0,13);
if (!h_evtflw) return;
}



void Chic02ee::book_tree(){
m_tree=new TTree("tree", "Chic02ee");
if (!m_tree) return;

// common info
m_tree->Branch("run",&m_run,"run/I");
m_tree->Branch("event",&m_event,"event/I");
m_tree->Branch("nchargedTrack",&m_ncharged,"nchargedTrack/I");
m_tree->Branch("nGoodChargedTrack",&m_nGoodChargedTrack, "nGoodChargedTrack/I");
}

void Chic02ee::clearVariables(){
m_run=0;
m_event=0;
m_ncharged=-1;
m_nGoodChargedTrack=-1;
}
bool Chic02ee::buildChic02ee() {

SmartDataPtr<EvtRecEvent>evtRecEvent(eventSvc(),"/Event/EvtRec/EvtRecEvent");
	if(!evtRecEvent) return false;
SmartDataPtr<EvtRecTrackCol> evtRecTrkCol(eventSvc(), "/Event/EvtRec/EvtRecTrackCol");
	if(!evtRecTrkCol) return false;

std::vector<int> iChargedGood;
selectChargedTracks(evtRecEvent, evtRecTrkCol,
            iChargedGood);
//selectChargedTracks(evtRecEvent, evtRecTrkCol, iChargedGood);

h_evtflw->Fill(9);
     
m_ncharged = evtRecEvent->totalCharged();
h_evtflw->Fill(2); // N_{Good} = 0

return true;

}
CLHEP::Hep3Vector Chic02ee::getOrigin() {
  CLHEP::Hep3Vector xorigin(0,0,0);
  IVertexDbSvc*  vtxsvc;
  Gaudi::svcLocator()->service("VertexDbSvc", vtxsvc);
  if(vtxsvc->isVertexValid()){
    double *dbv = vtxsvc->PrimaryVertex(); 
    xorigin.setX(dbv[0]);
    xorigin.setY(dbv[1]);
    xorigin.setZ(dbv[2]);
  }
  return xorigin; 
}

bool Chic02ee::passVertexSelection(CLHEP::Hep3Vector xorigin,
				    RecMdcKalTrack* mdcTrk ) {
  HepVector a = mdcTrk->helix();
  HepSymMatrix Ea = mdcTrk->err();
  HepPoint3D point0(0.,0.,0.);
  VFHelix helixip(point0,a,Ea);
  HepPoint3D IP(xorigin[0],xorigin[1],xorigin[2]);
  helixip.pivot(IP);
  HepVector vecipa = helixip.a();
  
  m_vz0 = vecipa[3];
  m_vr0 = vecipa[0];
  
  if(fabs(m_vz0) >= m_vz0cut) return false;
  if(fabs(m_vr0) >= m_vr0cut) return false;
  
  return true;
}

int Chic02ee::selectChargedTracks(SmartDataPtr<EvtRecEvent> evtRecEvent,
				   SmartDataPtr<EvtRecTrackCol> evtRecTrkCol,
				    std::vector<int> & iChargedGood) {

CLHEP::Hep3Vector xorigin = getOrigin(); 

 iChargedGood.clear();
  

    // loop through charged tracks 
    for(int i = 0; i < evtRecEvent->totalCharged(); i++){
    
    // get mdcTrk 
    EvtRecTrackIterator itTrk=evtRecTrkCol->begin() + i;

    // Good Kalman Track 
    if(!(*itTrk)->isMdcKalTrackValid()) continue;
	cout<<"isMdcTrackValid"<<endl;
     
    if(!(*itTrk)->isMdcTrackValid()) continue; 
    RecMdcKalTrack* mdcTrk = (*itTrk)->mdcKalTrack();
	cout<<"mdcKalTrackValid"<<endl;

      // Good Vertex 
    if (!passVertexSelection(xorigin, mdcTrk)) continue;
	cout<<"passVertexSelection"<<endl;

      // Polar angle cut
    if(fabs(cos(mdcTrk->theta())) > m_cha_costheta_cut) continue;
    
    iChargedGood.push_back((*itTrk)->trackId());

    } // end charged tracks

m_nGoodChargedTrack = iChargedGood.size();
  
return iChargedGood.size(); 

}
