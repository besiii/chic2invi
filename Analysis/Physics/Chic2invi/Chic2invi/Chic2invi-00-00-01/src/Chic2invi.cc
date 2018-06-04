// -*- C++ -*- //
//
// Description: chic -> Invisible 
//
// Original Author:  XIAO Suyu <xiaosuyu@ihep.ac.cn>
//         Created:  [2017-10-30 Mon 16:30] 
//         Inspired by SHI Xin's code 
//
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

#include "DstEvent/TofHitStatus.h"

#include "VertexFit/IVertexDbSvc.h"
#include "VertexFit/SecondVertexFit.h"
#include "VertexFit/Helix.h"
#include "VertexFit/WTrackParameter.h"
#include "VertexFit/VertexFit.h"

#include "ParticleID/ParticleID.h"
#include "McTruth/McParticle.h"

#include "VertexFit/KalmanKinematicFit.h"
//#include "GammaConv/GammaConv.h"

#include <TFile.h>
#include <TH1.h>
#include <TTree.h>

//
// class declaration
//

class Chic2invi : public Algorithm {
  
public:
  Chic2invi(const std::string&, ISvcLocator*);
  ~Chic2invi(); 
  StatusCode initialize();
  StatusCode execute();
  StatusCode finalize();

private:
  // declare r0, z0 cut for charged tracks
  double m_ecms;
  double m_vr0cut, m_vz0cut;
  // double m_distin_pionlep;
  double m_cha_costheta_cut;
  double m_total_number_of_charged_max;
  double m_min_emctime;
  double m_max_emctime;
  double m_gammaCosCut;
  double m_costheta_barrel_max;
  double m_costheta_endcap_min;
  double m_costheta_endcap_max;
  double m_energy_barrel_min;
  double m_energy_endcap_min;
  double m_photon_iso_angle_min;
  double m_pion_polar_angle_max;
  double m_pion_momentum_max;
  double m_prob_e_min;
  double m_dipion_mass_min;
  double m_dipion_mass_max;
  double m_epem_theta_max;
  double psi_pair;
  double psi_pair_max;
  double cosepem;

  // PID info
  double m_prob_ep;
  double m_prob_em;
  double m_prob_mup;
  double m_prob_mum;
  double m_prob_pip;
  double m_prob_pim;
  double m_prob_kp;
  double m_prob_km;
  double m_prob_p; 
  double m_prob_pb; 

  // ee info
  double m_ep_px;
  double m_ep_py;
  double m_ep_pz;

  double m_em_px;
  double m_em_py;
  double m_em_pz;

  // fitted info
  double m_vtx_ep_px; 
  double m_vtx_ep_py; 
  double m_vtx_ep_pz; 
  double m_vtx_ep_p; 
  double m_vtx_ep_e;
  double m_vtx_ep_costheta;
  double m_vtx_ep_phi;

  double m_vtx_em_px; 
  double m_vtx_em_py; 
  double m_vtx_em_pz; 
  double m_vtx_em_p; 
  double m_vtx_em_e;
  double m_vtx_em_costheta;
  double m_vtx_em_phi;

  double m_vtx_mepem;
  double m_vtx_mrecepem;
  double m_vtx_cosepem;
  double m_vtx_cos2esys;

  // output file
  std::string m_output_filename;
  bool m_isMonteCarlo; 
  bool m_isZCcondition;
  bool m_trigger_flag;
  bool m_eventrate;
  TFile* m_fout; 
  
  // define Histograms
  TH1F* h_evtflw; 
  
  // define Trees
  TTree* m_tree;

  // common info 
  int m_run;
  int m_event;
  int m_chan_det;

  //MC truth info
  int m_testMC;
  int m_evttag;
 // int m_idxmc;
  int m_indexmc;
  int m_motheridx[100];
  int m_pdgid[100];

  double m_mc_mom_gam1;
  double m_mc_mom_gam2;
  double m_mc_pt_gam1;
  double m_mc_pt_gam2;
  double m_mc_costhe_gam1;
  double m_mc_costhe_gam2;

  double m_trkm_p; 
  double m_trkm_px; 
  double m_trkm_py; 
  double m_trkm_pz; 
  double m_trkm_theta; 
  double m_trkm_phi; 
  double m_trkm_eraw; 

  // charged tracks
  int m_ncharged;
  int m_nptrk;
  int m_nmtrk;
  double m_trkp_p;
  double m_trkp_px;
  double m_trkp_py;
  double m_trkp_pz;
  double m_trkp_theta;
  double m_trkp_phi;
  double m_trkp_eraw;

  // neutral tracks
  int m_nshow;
  int m_ngam;
  std::vector<double> *m_raw_gpx; 
  std::vector<double> *m_raw_gpy; 
  std::vector<double> *m_raw_gpz; 
  std::vector<double> *m_raw_ge; 

  std::vector<double> *m_raw_phi;
  std::vector<double> *m_chic2_1c;
  std::vector<double> *m_raw_theta;
  std::vector<double> *m_raw_costheta;
  std::vector<int> *m_raw_cstat;
  std::vector<int> *m_raw_nhit;       
  std::vector<int> *m_raw_module;
  std::vector<double> *m_raw_secmom;
  std::vector<double> *m_raw_time;       
  std::vector<double> *m_raw_trigger;       
 
  // vertex
  double m_vr0;
  double m_vz0;

  // chic2invi
  int m_ntrk; 
  int m_npho;

  // functions
  void book_histogram();
  void book_tree(); 
  void clearVariables();
  bool buildChicToInvisible();
  void saveGenInfo();
  void saveTrkInfo(EvtRecTrackIterator,
		   EvtRecTrackIterator);
  void saveEeInfo(RecMdcKalTrack *,
		    RecMdcKalTrack *);
  void saveVtxInfo(HepLorentzVector,
		   HepLorentzVector);  
  void saveGamInfo(std::vector<int>,
  		 SmartDataPtr<EvtRecTrackCol>);
  void kmFit(std::vector<int>,
  		 SmartDataPtr<EvtRecTrackCol>);
  bool isCosmicRay(std::vector<int>,
  		 SmartDataPtr<EvtRecTrackCol>);
  int selectChargedTracks(SmartDataPtr<EvtRecEvent>,
			  SmartDataPtr<EvtRecTrackCol>,
			  std::vector<int> &,
			  std::vector<int> &); 
  int selectElectronPositron(SmartDataPtr<EvtRecTrackCol>,
			      std::vector<int>,
			      std::vector<int>);
  void calcTrackPID(EvtRecTrackIterator,
		    double&,
		    double&,
		    double&,
		    double&,
			double&);
  bool hasGoodEeVertex(RecMdcKalTrack *,
			 RecMdcKalTrack *,
			 bool);
  void selectNeutralTracks(SmartDataPtr<EvtRecEvent>,
			  SmartDataPtr<EvtRecTrackCol>, std::vector<int>& iGam, std::vector<int>& iShow);
  bool passVertexSelection(CLHEP::Hep3Vector,
			   RecMdcKalTrack* ); 
  CLHEP::Hep3Vector getOrigin();
}; 


//
// module declare
//

DECLARE_ALGORITHM_FACTORY( Chic2invi )
DECLARE_FACTORY_ENTRIES( Chic2invi ) {
  DECLARE_ALGORITHM(Chic2invi);
}

LOAD_FACTORY_ENTRIES( Chic2invi )


//
//constants
//
//

const int PSI2S_PDG_ID = 100443;
const int CHIC0_PDG_ID = 174;
const int GAMMA_PDG_ID = 22;

const double E_MASS = 0.000511;

static long m_cout_everat(0);

//
// member functions
//
Chic2invi::Chic2invi(const std::string& name, ISvcLocator* pSvcLocator) :
  Algorithm(name, pSvcLocator),
  m_tree(0),
  m_raw_gpx(0), 
  m_raw_gpy(0), 
  m_raw_gpz(0), 
  m_raw_ge(0),  
  m_raw_phi(0),
  m_chic2_1c(0),
  m_raw_theta(0),
  m_raw_costheta(0),
  m_raw_cstat(0),
  m_raw_nhit(0),
  m_raw_module(0),
  m_raw_secmom(0),
  m_raw_time(0),
  m_raw_trigger(0)
{
  declareProperty("OutputFileName", m_output_filename);
  declareProperty("IsMonteCarlo", m_isMonteCarlo);
  declareProperty("ZChi_AnaCondition", m_isZCcondition=false);
  //declareProperty("ZChi_AnaCondition", m_isZCcondition=true);
  declareProperty("Ecms", m_ecms = 3.686);
  declareProperty("Vr0cut", m_vr0cut=10.0);
  declareProperty("Vz0cut", m_vz0cut=30.0);
  declareProperty("ChaCosthetaCut", m_cha_costheta_cut=0.93);
  declareProperty("TotalNumberOfChargedMax", m_total_number_of_charged_max=50);
  declareProperty("MinEstCut", m_min_emctime=0.0);
  declareProperty("MaxEstCut", m_max_emctime=14.0);
  declareProperty("GammaCosCut",  m_gammaCosCut= 0.93); 
  declareProperty("CosthetaBarrelMax", m_costheta_barrel_max=0.8);
  declareProperty("CosthetaEndcapMin", m_costheta_endcap_min=0.86);
  declareProperty("CosthetaEndcapMax", m_costheta_endcap_max=0.92);
  declareProperty("EnergyBarrelMin", m_energy_barrel_min=0.025); 
  declareProperty("EnergyEndcapMin", m_energy_endcap_min=0.050); 
  declareProperty("PhotonIsoAngleMin", m_photon_iso_angle_min=10);
  declareProperty("PionPolarAngleMax", m_pion_polar_angle_max=0.99);
  declareProperty("PionMomentumMax", m_pion_momentum_max=1.9); 
  declareProperty("OpenAngle_epem", m_epem_theta_max=0.5); 
  declareProperty("PsiPairMax", psi_pair_max=0.5); 
  declareProperty("Prob_e", m_prob_e_min=0.001);
  declareProperty("DipionMassMin", m_dipion_mass_min=3.0); 
  declareProperty("DipionMassMax", m_dipion_mass_max=3.2); 
  declareProperty("Trigger", m_trigger_flag=true); 
  declareProperty("EventRate", m_eventrate=true); 
  declareProperty("ChanDet", m_chan_det=1); 
}



StatusCode Chic2invi::initialize(){ MsgStream log(msgSvc(), name());
  log << MSG::INFO << ">>>>>>> in initialize()" << endmsg;

  StatusCode status;
  
  m_fout = new TFile(m_output_filename.c_str(), "RECREATE");
  m_fout->cd(); 

  book_histogram(); 
  book_tree(); 

  log << MSG::INFO << "successfully return from initialize()" <<endmsg;
  return StatusCode::SUCCESS;
}


StatusCode Chic2invi::execute() {
  MsgStream log(msgSvc(), name());
  log << MSG::INFO << "in execute()" << endreq;
  
  // clear variables 
  clearVariables();
  
  h_evtflw->Fill(0); // raw 
  SmartDataPtr<Event::EventHeader>eventHeader(eventSvc(),"/Event/EventHeader");
  if(!eventHeader) return StatusCode::FAILURE;

//   SmartDataPtr<EvtRecTrackCol> evtRecTrkCol(eventSvc(), "/Event/EvtRec/EvtRecTrackCol");
// 	if(!evtRecTrkCol){
// 		log << MSG::ERROR << "EvtRecTrackCol" << endreq;
// 		return StatusCode::SUCCESS;
// 	}

  m_run = eventHeader->runNumber();
  m_event = eventHeader->eventNumber();
  m_evttag = eventHeader->eventTag();

	if (!m_isMonteCarlo) {
	// if(m_trigger_flag){
		SmartDataPtr<TrigData> trigData(eventSvc(),EventModel::Trig::TrigData);
		if (!trigData){
			log << MSG::FATAL << "Could not find Trigger Data for physics analysis" << endreq;
			return StatusCode::FAILURE;
		}
		log << MSG::DEBUG << "Trigger conditions: " << endreq;
		for(int i=0; i < 48; i++){
			log << MSG::DEBUG << "i:" << i << "  name:" << trigData->getTrigCondName(i) << "  cond:" << trigData->getTrigCondition(i) << endreq;
		}
		int m_trig_tot(0), m_trig_which(-1);
		if(m_eventrate){
			for(int j=0; j<16; j++){
				if(trigData->getTrigChannel(j)){
					m_trig_tot ++;
					m_trig_which = j+1;
					//m_raw_trigger->push_back(m_trig_which);
					m_raw_trigger->push_back(j);
				}
			}
		}
	}
	
if (buildChicToInvisible()) {
	m_tree->Fill(); // only fill tree for the selected events 
}

cout<<"end"<<endl;

return StatusCode::SUCCESS; 
}

StatusCode Chic2invi::finalize() {
  MsgStream log(msgSvc(), name());
  log << MSG::INFO << "in finalize()" << endmsg;

  m_fout->cd();
  m_tree->Write();
  h_evtflw->Write();
  m_fout->Close();
  
  return StatusCode::SUCCESS;
}


Chic2invi::~Chic2invi() {
}


void Chic2invi::book_histogram() {

  h_evtflw = new TH1F("hevtflw", "eventflow", 13, 0, 13);
  if (!h_evtflw) return;
  h_evtflw->GetXaxis()->SetBinLabel(1, "raw");
  h_evtflw->GetXaxis()->SetBinLabel(2, "N_{Good}=2");
  h_evtflw->GetXaxis()->SetBinLabel(3, "|cos#theta|<0.99");
  h_evtflw->GetXaxis()->SetBinLabel(4, "|p|<1.9");
  h_evtflw->GetXaxis()->SetBinLabel(5, "PID"); 
  h_evtflw->GetXaxis()->SetBinLabel(6, "cos#theta_{#pi^{+}#pi^{-}}<0.99");
  h_evtflw->GetXaxis()->SetBinLabel(7, "cos#theta_{#pi#pi sys}<0.99");
  h_evtflw->GetXaxis()->SetBinLabel(8, "3<M_{#pi#pi}^{rec}<3.2");
  h_evtflw->GetXaxis()->SetBinLabel(9, "N_{#gamma}<20");
  h_evtflw->GetXaxis()->SetBinLabel(10, "test");
}


void Chic2invi::book_tree() {

  m_tree=new TTree("tree", "Chic2invi");
  if (!m_tree) return; 

  //commom info
  m_tree->Branch("run",&m_run,"run/I");
  m_tree->Branch("event",&m_event,"event/I");
	  
  //charged tracks
  m_tree->Branch("ncharged", &m_ncharged, "ncharged/I");
  m_tree->Branch("nptrk", &m_nptrk, "nptrk/I");
  m_tree->Branch("nmtrk", &m_nmtrk, "nmtrk/I");
  m_tree->Branch("trkp_p", &m_trkp_p, "trkp_p/D"); 
  m_tree->Branch("trkp_px", &m_trkp_px, "trkp_px/D"); 
  m_tree->Branch("trkp_py", &m_trkp_py, "trkp_py/D"); 
  m_tree->Branch("trkp_pz", &m_trkp_pz, "trkp_pz/D"); 
  m_tree->Branch("trkp_theta", &m_trkp_theta, "trkp_theta/D"); 
  m_tree->Branch("trkp_phi", &m_trkp_phi, "trkp_phi/D"); 
  m_tree->Branch("trkp_eraw", &m_trkp_eraw, "trkp_eraw/D"); 

  m_tree->Branch("trkm_p", &m_trkm_p, "trkm_p/D"); 
  m_tree->Branch("trkm_px", &m_trkm_px, "trkm_px/D"); 
  m_tree->Branch("trkm_py", &m_trkm_py, "trkm_py/D"); 
  m_tree->Branch("trkm_pz", &m_trkm_pz, "trkm_pz/D"); 
  m_tree->Branch("trkm_theta", &m_trkm_theta, "trkm_theta/D"); 
  m_tree->Branch("trkm_phi", &m_trkm_phi, "trkm_phi/D"); 
  m_tree->Branch("trkm_eraw", &m_trkm_eraw, "trkm_eraw/D"); 
	  
  //vertex
  m_tree->Branch("vr0", &m_vr0, "vr0/D");
  m_tree->Branch("vz0", &m_vz0, "vz0/D");
	  
  //netual tracks
  m_tree->Branch("nshow", &m_nshow, "nshow/I");
  m_tree->Branch("ngam", &m_ngam, "ngam/I");
  m_tree->Branch("raw_gpx", &m_raw_gpx);
  m_tree->Branch("raw_gpy", &m_raw_gpy);
  m_tree->Branch("raw_gpz", &m_raw_gpz);
  m_tree->Branch("raw_ge", &m_raw_ge);
  
  m_tree->Branch("raw_phi", &m_raw_phi);
  m_tree->Branch("m_chic2_1c", &m_chic2_1c);
  m_tree->Branch("raw_theta", &m_raw_theta);
  m_tree->Branch("raw_costheta", &m_raw_costheta);
  m_tree->Branch("raw_cstat", &m_raw_cstat);
  m_tree->Branch("raw_nhit", &m_raw_nhit);
  m_tree->Branch("raw_module", &m_raw_module);
  m_tree->Branch("raw_secmom", &m_raw_secmom);
  m_tree->Branch("raw_time", &m_raw_time);
  m_tree->Branch("raw_trigger", &m_raw_trigger);

    // PID info
  m_tree->Branch("prob_ep", &m_prob_ep, "prob_ep/D"); 
  m_tree->Branch("prob_em", &m_prob_em, "prob_em/D"); 
  m_tree->Branch("prob_kp", &m_prob_kp, "prob_kp/D"); 
  m_tree->Branch("prob_km", &m_prob_km, "prob_km/D"); 
  m_tree->Branch("prob_p", &m_prob_p, "prob_p/D"); 
  m_tree->Branch("prob_pb", &m_prob_pb, "prob_pb/D"); 

  // save pion info
  m_tree->Branch("ep_px", &m_ep_px, "ep_px/D");
  m_tree->Branch("ep_py", &m_ep_py, "ep_py/D");
  m_tree->Branch("ep_pz", &m_ep_pz, "ep_pz/D");

  m_tree->Branch("em_px", &m_em_px, "em_px/D");
  m_tree->Branch("em_py", &m_em_py, "em_py/D");
  m_tree->Branch("em_pz", &m_em_pz, "em_pz/D");

  // fitted info
  m_tree->Branch("vtx_ep_px", &m_vtx_ep_px, "vtx_ep_px/D");
  m_tree->Branch("vtx_ep_py", &m_vtx_ep_py, "vtx_ep_py/D");
  m_tree->Branch("vtx_ep_pz", &m_vtx_ep_pz, "vtx_ep_pz/D");
  m_tree->Branch("vtx_ep_p", &m_vtx_ep_p, "vtx_ep_p/D");
  m_tree->Branch("vtx_ep_e", &m_vtx_ep_e, "vtx_ep_e/D");
  m_tree->Branch("vtx_ep_costheta", &m_vtx_ep_costheta, "vtx_ep_costheta/D");
  m_tree->Branch("vtx_ep_phi", &m_vtx_ep_phi, "vtx_ep_phi/D");

  m_tree->Branch("vtx_em_px", &m_vtx_em_px, "vtx_em_px/D");
  m_tree->Branch("vtx_em_py", &m_vtx_em_py, "vtx_em_py/D");
  m_tree->Branch("vtx_em_pz", &m_vtx_em_pz, "vtx_em_pz/D");
  m_tree->Branch("vtx_em_p", &m_vtx_em_p, "vtx_em_p/D");
  m_tree->Branch("vtx_em_e", &m_vtx_em_e, "vtx_em_e/D");
  m_tree->Branch("vtx_em_costheta", &m_vtx_em_costheta, "vtx_em_costheta/D");
  m_tree->Branch("vtx_em_phi", &m_vtx_em_phi, "vtx_em_phi/D");

  m_tree->Branch("vtx_mepem", &m_vtx_mepem, "vtx_mepem/D");
  m_tree->Branch("vtx_mrecepem", &m_vtx_mrecepem, "vtx_mrecepem/D");
  m_tree->Branch("vtx_cosepem", &m_vtx_cosepem, "vtx_cosepem/D");
  m_tree->Branch("vtx_cos2esys", &m_vtx_cos2esys, "vtx_cos2esys/D");

  // MC truth info
  if (!m_isMonteCarlo) return;
  m_tree->Branch("indexmc",&m_indexmc, "m_indexmc/I"); 
  m_tree->Branch("pdgid", m_pdgid, "m_pdgid[100]/I");
  m_tree->Branch("motheridx", m_motheridx, "m_motheridx[100]/I");
  m_tree->Branch("mc_mom_gam1", &m_mc_mom_gam1, "mc_mom_gam1/D");
  m_tree->Branch("mc_mom_gam2", &m_mc_mom_gam2, "mc_mom_gam2/D");
  m_tree->Branch("mc_pt_gam1", &m_mc_pt_gam1, "mc_pt_gam1/D");
  m_tree->Branch("mc_pt_gam2", &m_mc_pt_gam2, "mc_pt_gam2/D");
  m_tree->Branch("mc_costhe_gam1", &m_mc_costhe_gam1, "mc_costhe_gam1/D");
  m_tree->Branch("mc_costhe_gam2", &m_mc_costhe_gam2, "mc_costhe_gam2/D");
}

void Chic2invi::clearVariables() {

  // EMC Info
  m_raw_gpx->clear();
  m_raw_gpy->clear();
  m_raw_gpz->clear();
  m_raw_ge->clear();

  m_raw_phi->clear();
  m_chic2_1c->clear();
  m_raw_theta->clear();
  m_raw_costheta->clear();
  m_raw_cstat->clear();
  m_raw_nhit->clear();
  m_raw_module->clear();
  m_raw_secmom->clear();
  m_raw_time->clear();
  m_raw_trigger->clear();

  //MC Topology
  m_indexmc = 0;
  for(int i=0; i<100; i++){
	  m_pdgid[i] = 0;
	  m_motheridx[i] = 0;
  }
  m_run = 0;
  m_event = 0;
}

bool Chic2invi::buildChicToInvisible() {

	SmartDataPtr<EvtRecEvent>evtRecEvent(eventSvc(),"/Event/EvtRec/EvtRecEvent");
	if(!evtRecEvent) return false;

	SmartDataPtr<EvtRecTrackCol> evtRecTrkCol(eventSvc(), "/Event/EvtRec/EvtRecTrackCol");
	if(!evtRecTrkCol) return false;

	h_evtflw->Fill(9);

	m_ncharged = evtRecEvent->totalCharged();
	if (m_ncharged != 2) return false;
	h_evtflw->Fill(1); // N_{Good} = 0

	if (evtRecEvent->totalNeutral() != 1) return false;
	h_evtflw->Fill(2); // N_{Shower} = 2

	std::vector<int> iPGood, iMGood;
	selectChargedTracks(evtRecEvent, evtRecTrkCol, iPGood, iMGood);

//	cout<<"select charged tracks done"<<endl;
	if(selectElectronPositron(evtRecTrkCol, iPGood, iMGood)!=1) return false;
//	cout<<"select e+e- done"<<endl;

	std::vector<int> iGam;
	iGam.clear();
	std::vector<int> iShow;
	iShow.clear();

	selectNeutralTracks(evtRecEvent, evtRecTrkCol, iGam, iShow);
//	cout<<"select neutral tracks done"<<endl;
//	cout<<"Ngam = "<<iGam.size()<<endl;
	if (iGam.size() != 1) return false;
	cout<<"Ngam = 1 done"<<endl;
//	if( isCosmicRay(iGam, evtRecTrkCol) ) return false;
//	if (iGam.size() != 2) return false;

	saveGamInfo(iGam, evtRecTrkCol);
//	cout<<"save gam info done"<<endl;
	m_ngam = iGam.size();
	m_nshow = iShow.size();

//	kmFit(iGam, evtRecTrkCol);
//	cout<<"fit done"<<endl;

	h_evtflw->Fill(8); // N_{#gamma} < 10 

	if (m_isMonteCarlo) saveGenInfo();

	return true; 
}

void Chic2invi::saveGenInfo(){

	SmartDataPtr<Event::McParticleCol> mcParticleCol(eventSvc(), "/Event/MC/McParticleCol");
	HepLorentzVector mc_psip, mc_gam1, mc_gam2;

	//MC Topology
	{
		int m_numParticle = 0;
		bool Decay = false;
		int rootIndex = -1;
		bool strange = false;
		Event::McParticleCol::iterator iter_mc_topo = mcParticleCol->begin();
		for (; iter_mc_topo != mcParticleCol->end(); iter_mc_topo++){
			if ((*iter_mc_topo)->primaryParticle()&&(*iter_mc_topo)->particleProperty()==11&&((*iter_mc_topo)->mother()).particleProperty()==11) {strange=true;}
			if ((*iter_mc_topo)->primaryParticle()) continue;
			if (!(*iter_mc_topo)->decayFromGenerator()) continue;
			if ((*iter_mc_topo)->particleProperty() == PSI2S_PDG_ID){
				Decay = true;
				rootIndex = (*iter_mc_topo)->trackIndex();
			}
			if (!Decay) continue;
			int mcidx = ((*iter_mc_topo)->mother()).trackIndex() - rootIndex;
			int pdgid = (*iter_mc_topo)->particleProperty();
			if(strange&&((*iter_mc_topo)->mother()).particleProperty()!=PSI2S_PDG_ID) mcidx--;
			m_pdgid[m_numParticle] = pdgid;
			m_motheridx[m_numParticle] = mcidx;
			m_numParticle++;
		}
		m_indexmc = m_numParticle;
	}

	Event::McParticleCol::iterator iter_mc = mcParticleCol->begin();
	for (; iter_mc != mcParticleCol->end(); iter_mc++){
		if ((*iter_mc)->primaryParticle()) continue;
		if (!(*iter_mc)->decayFromGenerator()) continue;

		if ((*iter_mc)->mother().particleProperty() == PSI2S_PDG_ID){
			if ((*iter_mc)->particleProperty() == GAMMA_PDG_ID)
				mc_gam1 = (*iter_mc)->initialFourMomentum();
		}
		if ((*iter_mc)->mother().particleProperty() == CHIC0_PDG_ID){
			if ((*iter_mc)->particleProperty() == GAMMA_PDG_ID)
				mc_gam2 = (*iter_mc)->initialFourMomentum();
		}
	}
	m_mc_mom_gam1 = mc_gam1.vect().mag();
	m_mc_mom_gam2 = mc_gam2.vect().mag();

	m_mc_pt_gam1 = mc_gam1.vect().perp();
	m_mc_pt_gam2 = mc_gam2.vect().perp();

	m_mc_costhe_gam1 = mc_gam1.vect().cosTheta();
	m_mc_costhe_gam2 = mc_gam2.vect().cosTheta();
}


void Chic2invi::selectNeutralTracks(SmartDataPtr<EvtRecEvent> evtRecEvent,
		SmartDataPtr<EvtRecTrackCol> evtRecTrkCol, std::vector<int>& iGam, std::vector<int>& iShow) {


	// loop through neutral tracks
	for(int i=evtRecEvent->totalCharged(); i< evtRecEvent->totalTracks(); i++) {
		if (i > m_total_number_of_charged_max) break;

		EvtRecTrackIterator itTrk = evtRecTrkCol->begin() + i ;
		if(!(*itTrk)->isEmcShowerValid()) continue;
		RecEmcShower *emcTrk = (*itTrk)->emcShower();
		iShow.push_back((*itTrk)->trackId());

		// TDC window
		if ( !(emcTrk->time() >= m_min_emctime && emcTrk->time() <= m_max_emctime) )
			continue; 

		// Energy threshold
		double abs_costheta(fabs(cos(emcTrk->theta())));
		bool barrel = (abs_costheta < m_costheta_barrel_max); 
		bool endcap = (abs_costheta > m_costheta_endcap_min
				&& abs_costheta < m_costheta_endcap_max);
		double eraw = emcTrk->energy();

		if (!m_isZCcondition){     // Cut by "costheta"
			if ( !( (barrel && eraw > m_energy_barrel_min)
						|| (endcap && eraw > m_energy_endcap_min)))  continue; 
		}
		else{                      // Cut by "module"
			int module = emcTrk->module();
			if( module == 1 ){  if( !(eraw > m_energy_barrel_min) ) continue; }
			else{ if( !(eraw > m_energy_endcap_min) ) continue; }
		}

		// photon isolation: the opening angle between a candidate shower
		// and the closest charged track should be larger than 10 degree 
		CLHEP::Hep3Vector emcpos(emcTrk->x(), emcTrk->y(), emcTrk->z());

		// EMC costheta cut 
		double costhe = cos(emcpos.theta());
		if ( fabs(costhe) >= m_gammaCosCut) continue;

		// find the nearest charged track
		double dthe = 200.;
		double dphi = 200.;
		double dang = 200.; 
		for(int j = 0; j < evtRecEvent->totalCharged(); j++) {
			EvtRecTrackIterator jtTrk = evtRecTrkCol->begin() + j;
			if(!(*jtTrk)->isExtTrackValid()) continue;
			RecExtTrack *extTrk = (*jtTrk)->extTrack();
			if(extTrk->emcVolumeNumber() == -1) continue;
			CLHEP::Hep3Vector extpos = extTrk->emcPosition();
			double angd = extpos.angle(emcpos);
			double thed = extpos.theta() - emcpos.theta();
			double phid = extpos.deltaPhi(emcpos);
			thed = fmod(thed+CLHEP::twopi+CLHEP::twopi+pi, CLHEP::twopi) - CLHEP::pi;
			phid = fmod(phid+CLHEP::twopi+CLHEP::twopi+pi, CLHEP::twopi) - CLHEP::pi;

			if(fabs(thed) < fabs(dthe)) dthe = thed;
			if(fabs(phid) < fabs(dphi)) dphi = phid;
			if(angd < dang) dang = angd;	    
		}

		//if(dang>=200) continue;
		dthe = dthe * 180 / (CLHEP::pi);
		dphi = dphi * 180 / (CLHEP::pi);
		dang = dang * 180 / (CLHEP::pi);
		if (dang < m_photon_iso_angle_min ) continue; 

		iGam.push_back((*itTrk)->trackId());
	} // end loop neutral tracks     

/*	  if(iGam.size() == 1) {
		m_ngam = iGam.size();
		m_nshow = iShow.size();

		}
	saveGamInfo(iGam, evtRecTrkCol);   
*/	
//	return iGam.size(); 
}


void Chic2invi::saveGamInfo(std::vector<int> iGam,
		SmartDataPtr<EvtRecTrackCol> evtRecTrkCol){


	double eraw;
	double phi;
	double theta;

	for(vector<int>::size_type i=0; i<iGam.size(); i++)  {

		EvtRecTrackIterator itTrk = evtRecTrkCol->begin() + iGam[i];
		RecEmcShower* emcTrk = (*itTrk)->emcShower();
		eraw = emcTrk->energy();
		phi = emcTrk->phi();
		theta = emcTrk->theta();
		int cstat = emcTrk->status();
		int nhit = emcTrk->numHits();
		int module = emcTrk->module();      
		double secmom = emcTrk->secondMoment();      
		double time = emcTrk->time();

		HepLorentzVector p4 = HepLorentzVector(eraw * sin(theta) * cos(phi),
				eraw * sin(theta) * sin(phi),
				eraw * cos(theta),
				eraw );
		m_raw_gpx->push_back(p4.px());
		m_raw_gpy->push_back(p4.py());
		m_raw_gpz->push_back(p4.pz());
		m_raw_ge->push_back(p4.e());

		m_raw_phi->push_back(phi);
		m_raw_theta->push_back(theta);
		m_raw_costheta->push_back(cos(theta));
		m_raw_cstat->push_back(cstat);
		m_raw_nhit->push_back(nhit);
		m_raw_module->push_back(module);
		m_raw_secmom->push_back(secmom);
		m_raw_time->push_back(time);
	}


}





void Chic2invi::kmFit(std::vector<int> iGam,
		SmartDataPtr<EvtRecTrackCol> evtRecTrkCol){

	double eraw;
	double phi;
	double theta;

	for(vector<int>::size_type i=0; i<iGam.size(); i++)  {

		EvtRecTrackIterator itTrk = evtRecTrkCol->begin() + iGam[i];
		RecEmcShower* emcTrk = (*itTrk)->emcShower();
		eraw = emcTrk->energy();
		phi = emcTrk->phi();
		theta = emcTrk->theta();
	}

	int gam1_index = -1;
	int gam2_index = -1;
	// if(m_raw_ge->size()!=2) continue;
	if(m_raw_ge->at(0)<m_raw_ge->at(1)){
		gam1_index = 0;
		gam2_index = 1;
	}
	else{
		gam1_index = 1;
		gam2_index = 0;
	}
	HepLorentzVector gam1_p4_raw = HepLorentzVector(m_raw_gpx->at(gam1_index), 
			m_raw_gpy->at(gam1_index), 
			m_raw_gpz->at(gam1_index), 
			m_raw_ge->at(gam1_index));
	HepLorentzVector gam2_p4_raw = HepLorentzVector(m_raw_gpx->at(gam2_index), 
			m_raw_gpy->at(gam2_index), 
			m_raw_gpz->at(gam2_index), 
			m_raw_ge->at(gam2_index));
	//    WTrackParameter gam1 = WTrackParameter(gam1_p4_raw, phi, theta, eraw);
	HepLorentzVector cms_p4 = HepLorentzVector(0.011*m_ecms, 0, 0, m_ecms);
	RecEmcShower *gam1 = (*(evtRecTrkCol->begin()+iGam[gam1_index]))->emcShower();

	double M_CHIC2=3.55620;
	KalmanKinematicFit* kmfitchic2 = KalmanKinematicFit::instance();
	kmfitchic2->init();
	kmfitchic2->setChisqCut(2500);
	kmfitchic2->AddTrack(0, 0.0, gam1);
	kmfitchic2->AddMissTrack(1,M_CHIC2);
	//    kmfitchic2->AddFourMomentum(0, cms_p4);
	kmfitchic2->AddResonance(0, m_ecms, 0, 1);
	double kmchisq(-9.);
	if(!kmfitchic2->Fit()) kmchisq=999.;
	else{
		kmchisq=kmfitchic2->chisq();
	}

	m_chic2_1c->push_back(kmchisq);

}

bool Chic2invi::isCosmicRay(std::vector<int> iGam,
		SmartDataPtr<EvtRecTrackCol> evtRecTrkCol){

	// cosmic veto
	double time1 = -99, time2 = -99;
	for(vector<int>::size_type i=0;i<2;i++){
		EvtRecTrackIterator itTrk = evtRecTrkCol->begin() + iGam[i];
		if ((*itTrk)->isTofTrackValid()){
			SmartRefVector<RecTofTrack> tofTrkCol=(*itTrk)->tofTrack();
			SmartRefVector<RecTofTrack>::iterator iter_tof=tofTrkCol.begin();
			for(;iter_tof!=tofTrkCol.end();iter_tof++){
				TofHitStatus* status = new TofHitStatus;
				status->setStatus( (*iter_tof)->status() );
				if (status->is_cluster()){
					if (i==0)
					time1 = (*iter_tof)->tof();
					else
					time2 = (*iter_tof)->tof();
				}
				delete status;
			}	
		}
	}
	if( time1!=-99 && time2!=-99 && fabs(time1-time2)>5)
	return true;
}

int Chic2invi::selectChargedTracks(SmartDataPtr<EvtRecEvent> evtRecEvent,
									SmartDataPtr<EvtRecTrackCol> evtRecTrkCol,
									std::vector<int> & iPGood,
									std::vector<int> & iMGood){
	CLHEP::Hep3Vector xorigin = getOrigin();

	std::vector<int> iGood;
	iGood.clear();
	iPGood.clear();
	iMGood.clear();

	// loop through charged tracks
	for(int i=0; i<evtRecEvent->totalCharged(); i++){
		// get mdcTrk
		EvtRecTrackIterator itTrk=evtRecTrkCol->begin()+i;

		// Good Kalman Track
		if(!(*itTrk)->isMdcKalTrackValid()) continue;
		if(!(*itTrk)->isMdcTrackValid()) continue;
		RecMdcKalTrack* mdcTrk = (*itTrk)->mdcKalTrack();

		// No Good Vertex
		// if(!passVertexSelection(xorigin, mdcTrk)) continue;
//		if(passVertexSelection(xorigin, mdcTrk)) continue;

		// Polar angle cut
		if(fabs(cos(mdcTrk->theta()))>m_cha_costheta_cut) continue;
		iGood.push_back((*itTrk)->trackId());
		if(mdcTrk->charge()>0) iPGood.push_back((*itTrk)->trackId());
		if(mdcTrk->charge()<0) iMGood.push_back((*itTrk)->trackId());
	} // end charged tracks

	m_ncharged = iGood.size();
	m_nptrk = iPGood.size();
	m_nmtrk = iMGood.size();

	if(m_nptrk>0 && m_nmtrk>0){
		EvtRecTrackIterator itTrk_p = evtRecTrkCol->begin() + iPGood[0];
		EvtRecTrackIterator itTrk_m = evtRecTrkCol->begin() + iMGood[0];
		saveTrkInfo(itTrk_p, itTrk_m);
	}
	return iGood.size();
}

void Chic2invi::saveTrkInfo(EvtRecTrackIterator itTrk_p, EvtRecTrackIterator itTrk_m){
	RecMdcTrack* mdcTrk_p = (*itTrk_p)->mdcTrack();
	m_trkp_p = mdcTrk_p->p();
	m_trkp_px = mdcTrk_p->px();
	m_trkp_py = mdcTrk_p->py();
	m_trkp_pz = mdcTrk_p->pz();
	m_trkp_theta = mdcTrk_p->theta();
	m_trkp_phi = mdcTrk_p->phi();

	RecMdcTrack* mdcTrk_m = (*itTrk_m)->mdcTrack();
	m_trkm_p = mdcTrk_m->p();
	m_trkm_px = mdcTrk_m->px();
	m_trkm_py = mdcTrk_m->py();
	m_trkm_pz = mdcTrk_m->pz();
	m_trkm_theta = mdcTrk_m->theta();
	m_trkm_phi = mdcTrk_m->phi();

	if((*itTrk_m)->isEmcShowerValid()){
		RecEmcShower *emcTrk_p = (*itTrk_m)->emcShower();
		m_trkp_eraw = emcTrk_p->energy();
	}
}

CLHEP::Hep3Vector Chic2invi::getOrigin(){
	CLHEP::Hep3Vector xorigin(0,0,0);
	IVertexDbSvc* vtxsvc;
	Gaudi::svcLocator()->service("VertexDbSvc", vtxsvc);
	if(vtxsvc->isVertexValid()){
		double *dbv = vtxsvc->PrimaryVertex();
		xorigin.setX(dbv[0]);
		xorigin.setY(dbv[1]);
		xorigin.setZ(dbv[2]);
	}
	return xorigin;
}

bool Chic2invi::passVertexSelection(CLHEP::Hep3Vector xorigin, RecMdcKalTrack* mdcTrk){
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

	//******second vertex fit
	VertexFit *vtxfit_s = VertexFit::instance();
	WTrackParameter  wvks = vtxfit_s->wVirtualTrack(0);
	SecondVertexFit *vtxfit2 = SecondVertexFit::instance();
	double ks_2chis, ks_lchue;
	ks_2chis=-100;
	ks_lchue =-100;
	HepPoint3D newvx(0., 0., 0.);
	HepSymMatrix newEvx(3, 0);
	VertexParameter primaryVpar;
	IVertexDbSvc*  vtxsvc;
	Gaudi::svcLocator()->service("VertexDbSvc", vtxsvc);
	if(!(vtxsvc->isVertexValid())) {
			cout<<"Attention --!(vtxsvc->isVertexValid())"<<endl;
	}
	double* db_vx = vtxsvc->PrimaryVertex();
	double* db_vx_err = vtxsvc->SigmaPrimaryVertex();
	newvx.setX(db_vx[0]);
	newvx.setY(db_vx[1]);
	newvx.setZ(db_vx[2]);
	newEvx[0][0] = db_vx_err[0]*db_vx_err[0];
	newEvx[1][1] = db_vx_err[1]*db_vx_err[1];
	newEvx[2][2] = db_vx_err[2]*db_vx_err[2];
	primaryVpar.setVx(newvx);
	primaryVpar.setEvx(newEvx);
	vtxfit2->init();
	vtxfit2->setPrimaryVertex(primaryVpar);
	vtxfit2->AddTrack(0, wvks);
	vtxfit2->setVpar(vtxfit_s->vpar(0));
	bool okv2=vtxfit2->Fit();
	if(!okv2) return false;

	ks_2chis= vtxfit2->chisq();
	//WTrackParameter wks;
	//wks = vtxfit2->wpar();
	//p4_ks_2s=wks.p();

	double ks_dl  = vtxfit2->decayLength();
	double ks_dle = vtxfit2->decayLengthError();
	ks_lchue = ks_dl/ks_dle;


	return true;
}

int Chic2invi::selectElectronPositron(SmartDataPtr<EvtRecTrackCol> evtRecTrkCol, 
										std::vector<int> iPGood,
										std::vector<int> iMGood){
	int nee = 0;
	bool evtflw_filled = false;

//	cout<<"select ee start"<<endl;
	for(unsigned int i1=0; i1<iPGood.size(); i1++){
		EvtRecTrackIterator itTrk_p = evtRecTrkCol->begin() + iPGood[i1];
		RecMdcTrack* mdcTrk_p = (*itTrk_p)->mdcTrack();
		if(mdcTrk_p->charge()<0) continue; //only positive charged tracks

		for(unsigned int i2=0; i2<iMGood.size(); i2++){
			EvtRecTrackIterator itTrk_m = evtRecTrkCol->begin() + iMGood[i2];
			RecMdcTrack* mdcTrk_m = (*itTrk_m)->mdcTrack();
			if (mdcTrk_m->charge()>0) continue; // only negative charged tracks

			//polar angle for both pions
			if( !(fabs(cos(mdcTrk_p->theta())) < m_pion_polar_angle_max && 
				  fabs(cos(mdcTrk_m->theta())) < m_pion_polar_angle_max )) continue;
			if (!evtflw_filled) h_evtflw->Fill(2); // |cos#theta| cut

			// ee momentum
			if ( !(fabs(mdcTrk_p->p()) < m_pion_momentum_max && 
				   fabs(mdcTrk_m->p()) < m_pion_momentum_max )) continue;

			if (!evtflw_filled) h_evtflw->Fill(3); // |p| cut

			// track PID
			double prob_ep, prob_kp, prob_em, prob_km, prob_p, prob_pb;
			double prob_mup, prob_pip, prob_mum, prob_pim;
//			cout<<"calcTrackPID start"<<endl;
			calcTrackPID(itTrk_p, prob_ep, prob_mup, prob_pip, prob_kp, prob_p);
			calcTrackPID(itTrk_m, prob_em, prob_mum, prob_pim, prob_km, prob_pb);
//			cout<<"calcTrackPID done"<<endl;

			m_prob_ep = prob_ep;
			m_prob_mup = prob_mup;
			m_prob_pip = prob_pip;
			m_prob_kp = prob_kp;
			m_prob_p = prob_p;

			m_prob_em = prob_em;
			m_prob_mum = prob_mum;
			m_prob_pim = prob_pim;
			m_prob_km = prob_km;
			m_prob_pb = prob_pb;

//			cout<<m_prob_ep<<endl;
//			cout<<m_prob_mup<<endl;
//			cout<<m_prob_pip<<endl;
//			cout<<m_prob_kp<<endl;
//			cout<<m_prob_p<<endl;
//			cout<<m_prob_em<<endl;
//			cout<<m_prob_mum<<endl;
//			cout<<m_prob_pim<<endl;
//			cout<<m_prob_km<<endl;
//			cout<<m_prob_pb<<endl;
//			cout<<"judge epem start"<<endl;
			
			if( !(prob_ep > m_prob_e_min && prob_em > m_prob_e_min && 
				  prob_ep > m_prob_mup && prob_em > m_prob_mum && 
				  prob_ep > m_prob_pip && prob_em > m_prob_pim && 
				  prob_ep > m_prob_kp && prob_em > m_prob_km && 
				  prob_ep > m_prob_p && prob_em > m_prob_pb ) ) continue;
//			cout<<"judge epem done"<<endl;

			if (!evtflw_filled) h_evtflw->Fill(4); // PID

			// apply vertex fit
//			cout<<"kmfit on epem"<<endl;
			RecMdcKalTrack *epTrk = (*(evtRecTrkCol->begin()+iPGood[i1]))->mdcKalTrack();
			RecMdcKalTrack *emTrk = (*(evtRecTrkCol->begin()+iMGood[i2]))->mdcKalTrack();

			if (!hasGoodEeVertex(epTrk, emTrk, evtflw_filled)) continue;
//			cout<<"ee vertex done"<<endl;

			saveEeInfo(epTrk, emTrk);
//			cout<<"save ee info done"<<endl;

			nee++;
			evtflw_filled = true;
		}
	}
	return nee;
}

void Chic2invi::saveEeInfo(RecMdcKalTrack *epTrk, RecMdcKalTrack *emTrk){

	m_ep_px = epTrk->px();
	m_ep_py = epTrk->py();
	m_ep_pz = epTrk->pz();

	m_em_px = emTrk->px();
	m_em_py = emTrk->py();
	m_em_pz = emTrk->pz();
}

bool Chic2invi::hasGoodEeVertex(RecMdcKalTrack *epTrk, RecMdcKalTrack *emTrk, bool evtflw_filled){
//	cout<<"ee vertex start"<<endl;	
	HepLorentzVector pcms = HepLorentzVector(0.011*m_ecms, -0.001, 0.005, m_ecms);
	HepLorentzVector p4_vtx_ep, p4_vtx_em, p4_vtx_epem, p4_vtx_recepem;
	WTrackParameter wvepTrk, wvemTrk;
	epTrk->setPidType(RecMdcKalTrack::pion);
	wvepTrk = WTrackParameter(E_MASS, epTrk->getZHelix(), epTrk->getZError());

	emTrk->setPidType(RecMdcKalTrack::pion);
	wvemTrk = WTrackParameter(E_MASS, emTrk->getZHelix(), emTrk->getZError());

	HepPoint3D vx(0., 0., 0.);
	HepSymMatrix Evx(3, 0);

	double bx = 1E+6;
	double by = 1E+6;
	double bz = 1E+6;
	Evx[0][0] = bx*bx;
	Evx[1][1] = by*by;
	Evx[2][2] = bz*bz;
	
	VertexParameter vxpar;
	vxpar.setVx(vx);
	vxpar.setEvx(Evx);

//	cout<<"1"<<endl;	
	VertexFit* vtxfit = VertexFit::instance();
	vtxfit->init();
	vtxfit->AddTrack(0,  wvepTrk);
	vtxfit->AddTrack(1,  wvemTrk);
	vtxfit->AddVertex(0, vxpar,0,1);

	if(!vtxfit->Fit(0)) return false;

	vtxfit->Swim(0);
//	cout<<"2"<<endl;	
		
	WTrackParameter wep = vtxfit->wtrk(0);
	WTrackParameter wem = vtxfit->wtrk(1);
	p4_vtx_ep = vtxfit->pfit(0) ;
	p4_vtx_em = vtxfit->pfit(1) ;
	p4_vtx_recepem = pcms - p4_vtx_ep - p4_vtx_em;
	p4_vtx_epem = p4_vtx_ep + p4_vtx_em;

	double angle_epem = p4_vtx_ep.vect().angle(p4_vtx_em.vect());
	// double cos2esys = (p4_vtx_ep + p4_vtx_em).cosTheta();

//	cout<<"angle_epem = "<<angle_epem<<endl;
//	if( ! (angle_epem < m_epem_theta_max) ) return false;
	if( !evtflw_filled ) h_evtflw->Fill(5); // "cos#theta_{#pi^{+}#pi^{-}}<0.99"

	psi_pair = (p4_vtx_ep.phi() - p4_vtx_em.phi()) / angle_epem;
//	cout<<"psi_pair = "<<psi_pair<<endl;
//	if( ! (psi_pair < psi_pair_max ) ) return false;
	if( !evtflw_filled ) h_evtflw->Fill(6); // cos#theta_{#pi#pi sys}<0.99 

//	if( ! ( p4_vtx_recepem.m() >= m_dipion_mass_min &&
//		p4_vtx_recepem.m() <= m_dipion_mass_max) ) return false;
	if( !evtflw_filled ) h_evtflw->Fill(7); // 3<M_{#pi#pi}^{rec}<3.2

//	cout<<"save vtx info start"<<endl;
	saveVtxInfo(p4_vtx_ep, p4_vtx_em); 
	m_vtx_mrecepem = p4_vtx_recepem.m();
	m_vtx_mepem = p4_vtx_epem.m();
	m_vtx_cosepem = cosepem;
	// m_vtx_cos2esys = cos2esys; 

//	cout<<"123"<<endl;	
	return true;
}

void Chic2invi::saveVtxInfo(HepLorentzVector p4_vtx_ep,
			    HepLorentzVector p4_vtx_em){

	m_vtx_ep_px = p4_vtx_ep.px();
	m_vtx_ep_py = p4_vtx_ep.py();
	m_vtx_ep_pz = p4_vtx_ep.pz();
	m_vtx_ep_p = p4_vtx_ep.rho();
	m_vtx_ep_e = p4_vtx_ep.e();
	m_vtx_ep_costheta = p4_vtx_ep.cosTheta();
	m_vtx_ep_phi = p4_vtx_ep.phi();

	m_vtx_em_px = p4_vtx_em.px();
	m_vtx_em_py = p4_vtx_em.py();
	m_vtx_em_pz = p4_vtx_em.pz();
	m_vtx_em_p = p4_vtx_em.rho();
	m_vtx_em_e = p4_vtx_em.e();
	m_vtx_em_costheta = p4_vtx_em.cosTheta();
	m_vtx_em_phi = p4_vtx_em.phi();

}

void Chic2invi::calcTrackPID(EvtRecTrackIterator itTrk_p, double& prob_ep, double& prob_mup, 
							double& prob_pip, double& prob_kp, double& prob_p){
	prob_ep = 999.;
	prob_mup = 999.;
	prob_pip = 999.;
	prob_kp = 999.;
	prob_p = 999.;
	ParticleID* pidp = ParticleID::instance();
	pidp->init();
	pidp->setMethod(pidp->methodProbability());
	pidp->setChiMinCut(4);
	pidp->setRecTrack(*itTrk_p);
	// use PID sub-system
	pidp->usePidSys(pidp->useDedx() | pidp->useTof1() | pidp->useTof2());
	pidp->identify(pidp->onlyPionKaonProton());
	pidp->calculate();
	if(pidp->IsPidInfoValid()){
		prob_ep = pidp->probElectron();
		prob_mup = pidp->probMuon();
		prob_pip = pidp->probPion();
		prob_kp = pidp->probKaon();
		prob_p = pidp->probProton();
	}
}
