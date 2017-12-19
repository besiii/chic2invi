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

#include "EventModel/EventHeader.h"
#include "EvtRecEvent/EvtRecEvent.h"
#include "EvtRecEvent/EvtRecTrack.h"
#include "EventModel/EventHeader.h"
#include "CLHEP/Vector/ThreeVector.h"

#include "VertexFit/IVertexDbSvc.h"
#include "VertexFit/Helix.h"
#include "VertexFit/WTrackParameter.h"
#include "VertexFit/VertexFit.h"

#include "ParticleID/ParticleID.h"
#include "McTruth/McParticle.h"


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
  double m_prob_pion_min;
  double m_dipion_mass_min;
  double m_dipion_mass_max;

  // output file
  std::string m_output_filename;
  bool m_isMonteCarlo; 
  bool m_isZCcondition;
  TFile* m_fout; 
  
  // define Histograms
  TH1F* h_evtflw; 
  
  // define Trees
  TTree* m_tree;

  // common info 
  int m_run;
  int m_event;

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

  // neutral tracks
  int m_nshow;
  int m_ngam;
  int m_ncharged;
  std::vector<double> *m_raw_gpx; 
  std::vector<double> *m_raw_gpy; 
  std::vector<double> *m_raw_gpz; 
  std::vector<double> *m_raw_ge; 

  std::vector<double> *m_raw_phi;
  std::vector<double> *m_raw_theta;
  std::vector<double> *m_raw_costheta;
  std::vector<int> *m_raw_cstat;
  std::vector<int> *m_raw_nhit;       
  std::vector<int> *m_raw_module;
  std::vector<double> *m_raw_secmom;
  std::vector<double> *m_raw_time;       
  
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
  void savePionInfo(RecMdcKalTrack *,
		    RecMdcKalTrack *);
  void saveVtxInfo(HepLorentzVector,
		   HepLorentzVector);  
  void saveGamInfo(std::vector<int>,
		   SmartDataPtr<EvtRecTrackCol>);
  int selectChargedTracks(SmartDataPtr<EvtRecEvent>,
			  SmartDataPtr<EvtRecTrackCol>,
			  std::vector<int> &,
			  std::vector<int> &); 
  int selectPionPlusPionMinus(SmartDataPtr<EvtRecTrackCol>,
			      std::vector<int>,
			      std::vector<int>);
  void calcTrackPID(EvtRecTrackIterator,
		    double&,
		    double&,
		    double&);
  bool hasGoodPiPiVertex(RecMdcKalTrack *,
			 RecMdcKalTrack *,
			 bool);
  int selectNeutralTracks(SmartDataPtr<EvtRecEvent>,
			  SmartDataPtr<EvtRecTrackCol>);
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
  m_raw_theta(0),
  m_raw_costheta(0),
  m_raw_cstat(0),
  m_raw_nhit(0),
  m_raw_module(0),
  m_raw_secmom(0),
  m_raw_time(0)
{
  declareProperty("OutputFileName", m_output_filename);
  declareProperty("IsMonteCarlo", m_isMonteCarlo);
  declareProperty("ZChi_AnaCondition", m_isZCcondition=false);
  //declareProperty("ZChi_AnaCondition", m_isZCcondition=true);
  declareProperty("Ecms", m_ecms = 3.686);
  declareProperty("Vr0cut", m_vr0cut=1.0);
  declareProperty("Vz0cut", m_vz0cut=10.0);
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
  declareProperty("ProbPionMin", m_prob_pion_min=0.001);
  declareProperty("DipionMassMin", m_dipion_mass_min=3.0); 
  declareProperty("DipionMassMax", m_dipion_mass_max=3.2); 
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

  m_run = eventHeader->runNumber();
  m_event = eventHeader->eventNumber();
  m_evttag = eventHeader->eventTag();
/*
  if (m_event>10000 && m_event%10000 ==0) cout<<"event =="<<eventHeader->eventNumber()<<endl;
  if (eventHeader->runNumber()<0)
  {
  	//MC information
	SmartDataPtr<Event::McParticleCol> mcParticleCol(eventSvc(),"/Event/MC/McParticleCol");
	int m_numParticle = 0;
	if (!mcParticleCol){
		std::cout << "Could not retrieve McParticleCole" << std::endl;
		return StatusCode::FAILURE;
	}
	bool chicDecay = false;
	int rootIndex = -1;
	bool strange = false;
	Event::McParticleCol::iterator iter_mc = mcParticleCol->begin();
	int ngam_mc_eta =0, ngam_mc_pi0 = 0;
    
	for (; iter_mc != mcParticleCol->end(); iter_mc++){
		if (!chicDecay) continue;
		int mcidx = ((*iter_mc)->mother()).trackIndex() - rootIndex;
		int pdgid = (*iter_mc)->particleProperty();
		if(strange && ((*iter_mc)->mother()).particleProperty()!=100443) mcidx--;
		m_pdgid[m_numParticle] = pdgid;
		m_motheridx[m_numParticle] = mcidx;
		m_numParticle +=1;
		HepLorentzVector mctrue_track = (*iter_mc)->initialFourMomentum();

	}
	m_idxmc = m_numParticle;
  
  }
*/
	if (buildChicToInvisible()) {
    	m_tree->Fill(); // only fill tree for the selected events 
  	}

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
	  
	  
  //netual tracks
  m_tree->Branch("nshow", &m_nshow, "nshow/I");
  m_tree->Branch("ngam", &m_ngam, "ngam/I");
  m_tree->Branch("raw_gpx", &m_raw_gpx);
  m_tree->Branch("raw_gpy", &m_raw_gpy);
  m_tree->Branch("raw_gpz", &m_raw_gpz);
  m_tree->Branch("raw_ge", &m_raw_ge);
  
  m_tree->Branch("raw_phi", &m_raw_phi);
  m_tree->Branch("raw_theta", &m_raw_theta);
  m_tree->Branch("raw_costheta", &m_raw_costheta);
  m_tree->Branch("raw_cstat", &m_raw_cstat);
  m_tree->Branch("raw_nhit", &m_raw_nhit);
  m_tree->Branch("raw_module", &m_raw_module);
  m_tree->Branch("raw_secmom", &m_raw_secmom);
  m_tree->Branch("raw_time", &m_raw_time);

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
  m_raw_theta->clear();
  m_raw_costheta->clear();
  m_raw_cstat->clear();
  m_raw_nhit->clear();
  m_raw_module->clear();
  m_raw_secmom->clear();
  m_raw_time->clear();

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
  if (m_ncharged != 0) return false;
  h_evtflw->Fill(1); // N_{Good} = 0

  selectNeutralTracks(evtRecEvent, evtRecTrkCol);
  if (m_ngam >= 10) return false;
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


int Chic2invi::selectNeutralTracks(SmartDataPtr<EvtRecEvent> evtRecEvent,
		SmartDataPtr<EvtRecTrackCol> evtRecTrkCol) {

	std::vector<int> iGam;
	iGam.clear();
	std::vector<int> iShow;
	iShow.clear();

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

	m_ngam = iGam.size();
	m_nshow = iShow.size();

	saveGamInfo(iGam, evtRecTrkCol);   

	return iGam.size(); 
}


void Chic2invi::saveGamInfo(std::vector<int> iGam,
		SmartDataPtr<EvtRecTrackCol> evtRecTrkCol){

	for(vector<int>::size_type i=0; i<iGam.size(); i++)  {

		EvtRecTrackIterator itTrk = evtRecTrkCol->begin() + iGam[i];
		RecEmcShower* emcTrk = (*itTrk)->emcShower();
		double eraw = emcTrk->energy();
		double phi = emcTrk->phi();
		double theta = emcTrk->theta();

		HepLorentzVector p4 = HepLorentzVector(eraw * sin(theta) * cos(phi),
				eraw * sin(theta) * sin(phi),
				eraw * cos(theta),
				eraw );
		m_raw_gpx->push_back(p4.px());
		m_raw_gpy->push_back(p4.py());
		m_raw_gpz->push_back(p4.pz());
		m_raw_ge->push_back(p4.e());


		int cstat = emcTrk->status();
		int nhit = emcTrk->numHits();
		int module = emcTrk->module();      
		double secmom = emcTrk->secondMoment();      
		double time = emcTrk->time();

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



