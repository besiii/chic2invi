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
//int m_nGoodCharged;
int m_nlptrk;
int m_nlmtrk;
double m_trklp_p;
double m_trklp_px;
double m_trklp_py;
double m_trklp_pz;
double m_trklp_theta;
double m_trklp_phi;
double m_trklp_eraw;
double m_trklm_p;
double m_trklm_px;
double m_trklm_py;
double m_trklm_pz;
double m_trklm_theta;
double m_trklm_phi;
double m_trklm_eraw; 

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
			  std::vector<int> &,
			  std::vector<int> &);

int selectLeptonPlusLeptonMinus(SmartDataPtr<EvtRecTrackCol>,
				  std::vector<int>,
				  std::vector<int>);
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
m_tree->Branch("nchargedTrack",&m_ncharged,"charged/I");
// m_tree->Branch("nlptrk", &m_nlptrk, "nlptrk/I");
// m_tree->Branch("nlmtrk", &m_nlmtrk, "nlmtrk/I");


}


void Chic02ee::clearVariables(){
m_run=0;
m_event=0;
m_ncharged=-1;

}
bool Chic02ee::buildChic02ee() {

SmartDataPtr<EvtRecEvent>evtRecEvent(eventSvc(),"/Event/EvtRec/EvtRecEvent");
	if(!evtRecEvent) return false;
SmartDataPtr<EvtRecTrackCol> evtRecTrkCol(eventSvc(), "/Event/EvtRec/EvtRecTrackCol");
	if(!evtRecTrkCol) return false;

	h_evtflw->Fill(9);
std::vector<int> iLepPGood, iLepMGood;
selectChargedTracks(evtRecEvent, evtRecTrkCol,
		    iLepPGood, iLepMGood);

//selectChargedTracks(evtRecEvent, evtRecTrkCol, iPGood, iMGood);

 // if ( (m_nlptrk != 1) || (m_nlmtrk != 1) ) return false;
 // h_evtflw->Fill(1); //  N_LeptonP=1, N_LeptonM=1


  /* if(selectLeptonPlusLeptonMinus(evtRecTrkCol, iLepPGood, iLepMGood) != 1) return false; */ 
     
m_ncharged = evtRecEvent->totalCharged();
h_evtflw->Fill(2); // N_{Good} = 0

	// m_ncharged = evtRecEvent->totalCharged();
	// if (m_ncharged = 0) return false;
	// h_evtflw->Fill(2); // N_{Good} = 2
	
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
				   std::vector<int> & iLepPGood,
				   std::vector<int> & iLepMGood) {

CLHEP::Hep3Vector xorigin = getOrigin(); 

std::vector<int> iGood;
  iGood.clear();
  iLepPGood.clear();
  iLepMGood.clear();

    // loop through charged tracks 
    //cout<<evtRecEvent->totalCharged() <<endl; 
    for(int i = 0; i < evtRecEvent->totalCharged(); i++){
    
    // get mdcTrk 
    EvtRecTrackIterator itTrk=evtRecTrkCol->begin() + i;

    // Good Kalman Track 
    if((*itTrk)->isMdcKalTrackValid()) continue; // changed the condition from not equals to equals
         printf("\n Checking the loop \n ");
    if((*itTrk)->isMdcTrackValid()) continue; // changed the condition from not equals to equals
    RecMdcKalTrack* mdcTrk = (*itTrk)->mdcKalTrack();
    
    // Good Vertex 
    if (passVertexSelection(xorigin, mdcTrk) ) continue; // changed the condition from not equals to equals

    // Polar angle cut
    if(fabs(cos(mdcTrk->theta())) > m_cha_costheta_cut) continue;

    iGood.push_back((*itTrk)->trackId());


     // lepton candidates
      if(mdcTrk->charge()>0) iLepPGood.push_back((*itTrk)->trackId());
      if(mdcTrk->charge()<0) iLepMGood.push_back((*itTrk)->trackId());
    } // end charged tracks


 m_ncharged = iGood.size();
 m_nlptrk = iLepPGood.size();
 m_nlmtrk = iLepMGood.size(); 

/*if (m_nlptrk > 0 && m_nlmtrk > 0) {
    EvtRecTrackIterator itTrk_lp = evtRecTrkCol->begin() + iLepPGood[0];
    EvtRecTrackIterator itTrk_lm = evtRecTrkCol->begin() + iLepMGood[0];
    saveTrkInfo(itTrk_lp, itTrk_lm);
  }*/
  return iGood.size(); 

}
/*
int Chic02ee::selectLeptonPlusLeptonMinus(SmartDataPtr<EvtRecTrackCol> evtRecTrkCol,
					   std::vector<int> iPGood,
					   std::vector<int> iMGood) {
  int nlplm = 0;
  bool evtflw_filled = false;
  
  for(unsigned int i1 = 0; i1 < iPGood.size(); i1++) {
    EvtRecTrackIterator itTrk_p = evtRecTrkCol->begin() + iPGood[i1];
    RecMdcTrack* mdcTrk_p = (*itTrk_p)->mdcTrack();
    if (mdcTrk_p->charge() < 0) continue; // only positive charged tracks

    for(unsigned int i2 = 0; i2 < iMGood.size(); i2++) {
      EvtRecTrackIterator itTrk_m = evtRecTrkCol->begin() + iMGood[i2];
      RecMdcTrack* mdcTrk_m = (*itTrk_m)->mdcTrack();
      if (mdcTrk_m->charge() > 0) continue; // only negative charged tracks

      /*
	// lepton momentum 
      if ( ! ( fabs(mdcTrk_p->p()) < m_lepton_momentum_max  &&
      	       fabs(mdcTrk_m->p()) < m_lepton_momentum_max )) continue;

      if ( !evtflw_filled ) h_evtflw->Fill(8); //|p| cut 
      
      // apply vertex fit
      RecMdcKalTrack *lpTrk = (*(evtRecTrkCol->begin()+iPGood[i1]))->mdcKalTrack();
      RecMdcKalTrack *lmTrk = (*(evtRecTrkCol->begin()+iMGood[i2]))->mdcKalTrack();

      saveLeptonInfo(lpTrk, lmTrk);
      
      int ee_flag=0, mumu_flag=0;
      if ( hasGoodLpLmVertex(lpTrk, lmTrk, Electron_Hypothesis_Fit, evtflw_filled) ) ee_flag=1;
      if ( hasGoodLpLmVertex(lpTrk, lmTrk, Muon_Hypothesis_Fit, evtflw_filled) ) mumu_flag=1; 
      
      m_Chic02ee_flag = ee_flag;
      m_Chic02ee_flag = mumu_flag;
      if(ee_flag==1 || mumu_flag==1) nlplm++;
      evtflw_filled = true;
    }
  } 

  return nlplm; 
}
}


void Chic02ee::saveTrkInfo(EvtRecTrackIterator itTrk_lp,
			    EvtRecTrackIterator itTrk_lm) {
         RecMdcTrack* mdcTrk_lp = (*itTrk_lp)->mdcTrack(); 
  m_trklp_p = mdcTrk_lp->p();
  m_trklp_px = mdcTrk_lp->px();
  m_trklp_py = mdcTrk_lp->py();
  m_trklp_pz = mdcTrk_lp->pz();
  m_trklp_theta = mdcTrk_lp->theta();
  m_trklp_phi = mdcTrk_lp->phi();
  
  if((*itTrk_lp)->isEmcShowerValid()){
    RecEmcShower *emcTrk_lp = (*itTrk_lp)->emcShower();
    m_trklp_eraw = emcTrk_lp->energy();
  }
  else{ m_trklp_eraw = -99.0; }

  RecMdcTrack* mdcTrk_lm = (*itTrk_lm)->mdcTrack();
  m_trklm_p = mdcTrk_lm->p();
  m_trklm_px = mdcTrk_lm->px();
  m_trklm_py = mdcTrk_lm->py();
  m_trklm_pz = mdcTrk_lm->pz();
  m_trklm_theta = mdcTrk_lm->theta();
  m_trklm_phi = mdcTrk_lm->phi();
  
  if((*itTrk_lm)->isEmcShowerValid()){
    RecEmcShower *emcTrk_lm = (*itTrk_lm)->emcShower();
    m_trklm_eraw = emcTrk_lm->energy();
  }
  else{ m_trklm_eraw = -99.0; }

}   */
