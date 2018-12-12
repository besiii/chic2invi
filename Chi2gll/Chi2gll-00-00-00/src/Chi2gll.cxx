#include "Chi2gll/Chi2gll.h"

#ifndef ENABLE_BACKWARDS_COMPATIBILITY
typedef HepGeom::Point3D<double> HepPoint3D;
#endif
const int PSI2S_PDG_ID = 100443;
const double xmass[5] = {0.000511, 0.105658, 0.139570,0.493677, 0.938272};//e,mu,pi,k,p


Chi2gll::Chi2gll(const std::string& name, ISvcLocator* pSvcLocator):Algorithm(name,pSvcLocator){
	declareProperty("Vr0cut",   m_vr0cut=1.0);
	declareProperty("Vz0cut",   m_vz0cut=10.0);
	declareProperty("cha_costheta_cut", m_cha_costheta_cut=0.93);
	declareProperty("total_number_of_charged_max", m_total_number_of_charged_max =10 );
	declareProperty("MinEstCut", m_min_emctime=0.0);
	declareProperty("MaxEstCut", m_max_emctime=14.0);
	declareProperty("CosthetaBarrelMax", m_costheta_barrel_max=0.8);
	declareProperty("CosthetaEndcapMin", m_costheta_endcap_min=0.86);
	declareProperty("CosthetaEndcapMax", m_costheta_endcap_max=0.92);
	declareProperty("ZChi_AnaCondition", m_isZCcondition=false);
	declareProperty("EnergyBarrelMin", m_energy_barrel_min=0.025); 
	declareProperty("EnergyEndcapMin", m_energy_endcap_min=0.050); 
	declareProperty("GammaCosCut",  m_gammaCosCut= 0.93); 
	declareProperty("PhotonIsoAngleMin", m_photon_iso_angle_min=20);

}
Chi2gll::~Chi2gll(){
	//add your code for deconstructor
}

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

StatusCode Chi2gll::initialize(){
	MsgStream log(msgSvc(), name());
	log<<MSG::INFO<<"Chi2gll::initialize()"<<endreq;
	//add your code here
	StatusCode status;
	NTuplePtr nt1(ntupleSvc(), "FILE1/ana");
	if ( nt1 ) m_tuple1 = nt1;
	else {
		m_tuple1 = ntupleSvc()->book ("FILE1/ana", CLID_ColumnWiseTuple, "ana N-Tuple example");
		if ( m_tuple1 )    {
			status = m_tuple1->addItem ("run",   m_run);
			status = m_tuple1->addItem ("event", m_event);
			status = m_tuple1->addItem("indexmc",          m_idxmc, 0, 100);
			status = m_tuple1->addIndexedItem("p4truth", m_idxmc, 6, m_p4truth);//0-3 : p4; 4: pdgid; 5: mcidx

			status = m_tuple1->addItem ("ncharged",  m_ntrk, 0, 15);//good charged track
			status = m_tuple1->addItem ("nneutral",  m_nshw, 0, 5);//good neutrual track
			status = m_tuple1->addItem ("ngoodcharged", m_ncharged, 0, 15);
			status = m_tuple1->addItem ("ngoodneutral", m_nneutral, 0, 5);
			status = m_tuple1->addItem ("nlepton", m_nlepton, 0,5);
			//0-3:p4;  4: charge; 5: particle type;  6-9 p4 shower of this lepton;;
			status = m_tuple1->addIndexedItem("p4trk",     m_nlepton,10, m_p4trk);
			status = m_tuple1->addIndexedItem("p4shw",     m_nshw,4, m_p4shw);
		}
		else    {
			log << MSG::ERROR << "    Cannot book N-tuple:" << long(m_tuple1) << endmsg;
			return StatusCode::FAILURE;
		}
	}
	return StatusCode::SUCCESS;

}

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

StatusCode Chi2gll::beginRun(){
	MsgStream log(msgSvc(), name());
	log<<MSG::INFO<<"Chi2gll::beginRun()"<<endreq;
	//add your code here
	return StatusCode::SUCCESS;

}

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

StatusCode Chi2gll::execute(){

	MsgStream log(msgSvc(), name());
	log<<MSG::INFO<<"Chi2gll::execute()"<<endreq;

	SmartDataPtr<Event::EventHeader> eventHeader(eventSvc(),"/Event/EventHeader");
	m_run = eventHeader->runNumber();
	m_event = eventHeader->eventNumber();
	if(m_run%10000==0)log << MSG::WARNING <<"run, evtnum = " << m_run << " , " << m_event <<endreq;


	// Begin to select events
	// to retrieve RecEvent
	SmartDataPtr<EvtRecEvent> evtRecEvent(eventSvc(), "/Event/EvtRec/EvtRecEvent");
	if ( ! evtRecEvent ) { 
		cout << MSG::FATAL << "Could not find EvtRecEvent" << endl;
		exit(1);
	}   
	// to retrieve RecTrackCol
	SmartDataPtr<EvtRecTrackCol> evtRecTrkCol( eventSvc(), "/Event/EvtRec/EvtRecTrackCol");
	if ( ! evtRecTrkCol ) { 
		cout << MSG::FATAL << "Could not find EvtRecTrackCol" << endl;
		exit(1);
	}



	//charged
	int totalCharged = evtRecEvent->totalCharged();
	if (totalCharged< 2 || totalCharged >10) return StatusCode::SUCCESS;
	m_ncharged = totalCharged;
	std::vector<int> iGood;
	int ngoodtrk = selectGoodChargedTracks(evtRecEvent, evtRecTrkCol, iGood);
	if(ngoodtrk <2 || ngoodtrk>10) return StatusCode::SUCCESS;

	//lepton
	vector<int> VEpId, VEmId, VMupId, VMumId;
	VEpId.clear(); VEmId.clear();VMupId.clear(); VMumId.clear();
	for(int a = 0; a < iGood.size(); a++) {
		EvtRecTrackIterator itTrk = evtRecTrkCol->begin() + iGood[a];
		RecMdcKalTrack* mdcTrk = (*itTrk)->mdcKalTrack(); 
		// better than the structure of
		// if(is E)... else if (is mu) ... else continue;
		if( ! (isGoodElectron(itTrk) ||isGoodMuon(itTrk) ) )continue;
		if(isGoodElectron(itTrk))
		{
			if(mdcTrk->charge() >0) VEpId.push_back(a);
			if(mdcTrk->charge() <0) VEmId.push_back(a);
		}
		if ( isGoodMuon(itTrk)){
			if(mdcTrk->charge() >0) VMupId.push_back(a);
			if(mdcTrk->charge() <0) VMumId.push_back(a);
		}

	}
	if( (VEpId.size() ==0 || VEmId.size() ==0)  &&  (VMupId.size() ==0 || VMumId.size() ==0) ) return StatusCode::SUCCESS;


	m_nlepton = VEpId.size() + VEmId.size() + VMupId.size() + VMumId.size();


	for(int i =0; i<m_nlepton ; i++){
		int leptonId = -1;
		int leptonType  = -1;
		if( i<VEpId.size() ){
			leptonId = VEpId[i];
			leptonType = 0;
		}else if (i < (VEpId.size() + VEmId.size()) ){
			int emId  = i - VEpId.size();
			leptonId = VEmId[emId];
			leptonType = 0;
		}else if (i < (VEpId.size() + VEmId.size() + VMupId.size())  ){
			int mupId = i - VEpId.size() - VEmId.size();
			leptonId = VMupId[mupId];
			leptonType = 1;
		}else if (i < m_nlepton  ){
			int mumId = i - VEpId.size() - VEmId.size() - VMupId.size();
			leptonId = VMumId[mumId];
			leptonType = 1;
		}else
			cout<<"in e mu loop, nonexist case happen,check code"<<endl;


		EvtRecTrackIterator itTrk = evtRecTrkCol->begin() + iGood[leptonId];
		saveLepton(itTrk, i, leptonType);
	}

	m_ntrk=iGood.size();


	//
	int nphoton = evtRecEvent->totalNeutral();
	if(nphoton <2||nphoton>4) return StatusCode::SUCCESS;
	m_nneutral = nphoton;
	std::vector<int> iGoodGam;   iGoodGam.clear();
	selectNeutralTracks(evtRecEvent, evtRecTrkCol, iGoodGam);
	if ( iGoodGam.size() < 2 ||  iGoodGam.size()>4  ) return StatusCode::SUCCESS;


	for(int i=0;i<iGoodGam.size();i++)
	{
		EvtRecTrackIterator itTrk = evtRecTrkCol->begin() + iGoodGam[i];
		RecEmcShower* emcTrk = (*itTrk)->emcShower();
		double eraw = emcTrk->energy();
		double phi = emcTrk->phi();
		double theta = emcTrk->theta();
		HepLorentzVector p4 = HepLorentzVector(eraw * sin(theta) * cos(phi), eraw * sin(theta) * sin(phi),eraw * cos(theta),eraw );
		for(int a=0; a<4; a++) m_p4shw[i][a] = p4[a];
	}
	m_nshw = iGoodGam.size();


	if(m_run <0) mctruth();

	m_tuple1->write();

	return StatusCode::SUCCESS;
}

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

StatusCode Chi2gll::endRun(){
	MsgStream log(msgSvc(), name());
	log<<MSG::INFO<<"Chi2gll::endRun()"<<endreq;
	//add your code here
	return StatusCode::SUCCESS;

}

// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

StatusCode Chi2gll::finalize(){
	MsgStream log(msgSvc(), name());
	log<<MSG::INFO<<"Chi2gll::finalize()"<<endreq;
	//add your code here
	return StatusCode::SUCCESS;
}



//--------------------------------------------------------------------------------------------
//--------------------add your code here,for other member-functions---------------------------
//--------------------------------------------------------------------------------------------

int Chi2gll::selectGoodChargedTracks(SmartDataPtr<EvtRecEvent> evtRecEvent,
		SmartDataPtr<EvtRecTrackCol> evtRecTrkCol,
		std::vector<int> & iGood) {

	CLHEP::Hep3Vector xorigin(0,0,0);
	IVertexDbSvc*  vtxsvc;
	Gaudi::svcLocator()->service("VertexDbSvc", vtxsvc);
	if(vtxsvc->isVertexValid()){
		double *dbv = vtxsvc->PrimaryVertex(); 
		xorigin.setX(dbv[0]);
		xorigin.setY(dbv[1]);
		xorigin.setZ(dbv[2]);
	}

	iGood.clear();
	int np=0;
	int nm=0;

	for(int i = 0; i < evtRecEvent->totalCharged(); i++){
		EvtRecTrackIterator itTrk=evtRecTrkCol->begin() + i;
		if(!(*itTrk)->isMdcKalTrackValid()) continue;
		if(!(*itTrk)->isMdcTrackValid()) continue;
		RecMdcKalTrack* mdcTrk = (*itTrk)->mdcKalTrack();

		if (!passVertexSelection(xorigin, mdcTrk) ) continue; 
		if(fabs(cos(mdcTrk->theta())) > m_cha_costheta_cut) continue;

		iGood.push_back((*itTrk)->trackId());

	} // end charged tracks
	return iGood.size();
}

bool Chi2gll::passVertexSelection(CLHEP::Hep3Vector xorigin,
		RecMdcKalTrack* mdcTrk ) {
	HepVector a = mdcTrk->helix();
	HepSymMatrix Ea = mdcTrk->err();
	HepPoint3D point0(0.,0.,0.);

	VFHelix helixip(point0,a,Ea);
	HepPoint3D IP(xorigin[0],xorigin[1],xorigin[2]);
	helixip.pivot(IP);
	HepVector vecipa = helixip.a();

	double m_vz0 = vecipa[3];
	double m_vr0 = vecipa[0];

	if(fabs(m_vz0) >= m_vz0cut) return false;
	if(fabs(m_vr0) >= m_vr0cut) return false;

	return true;
}

bool Chi2gll::isGoodElectron(EvtRecTrackIterator itTrk){
	ParticleID * pidp = ParticleID::instance();
	pidp->init();
	pidp->setMethod(pidp->methodProbability());
	pidp->setChiMinCut(4);
	pidp->setRecTrack(*itTrk);
	// use PID sub-system
	pidp->usePidSys(pidp->useDedx() | pidp->useTof1() | pidp->useTof2() | pidp->useEmc());
	//pidp->usePidSys(pidp->useDedx() | pidp->useTof1() | pidp->useTof2());
	pidp->identify(pidp->onlyPion() | pidp->onlyKaon() | pidp->onlyElectron());
	//pidp->identify(pidp->onlyElectron() | pidp->onlyMuon());
	pidp->calculate();

	if(pidp->IsPidInfoValid()) {
		double probpi = pidp->probPion();
		double probk  = pidp->probKaon();
		double probe  = pidp->probElectron();
		double probmu  = pidp->probMuon();
		if(probe > probpi  && probe > 0.) return true;
		else
			return false;
	}
	else
		return false;
}

bool Chi2gll::isGoodMuon(EvtRecTrackIterator itTrk){
	ParticleID * pidp = ParticleID::instance();
	pidp->init();
	pidp->setMethod(pidp->methodProbability());
	pidp->setChiMinCut(4);
	pidp->setRecTrack(*itTrk);
	// use PID sub-system
	pidp->usePidSys(pidp->useDedx() | pidp->useTof1() | pidp->useTof2());
	pidp->identify(pidp->onlyPion() | pidp->onlyKaon() | pidp->onlyProton());
	pidp->identify(pidp->onlyElectron() | pidp->onlyMuon());
	pidp->calculate();

	if(pidp->IsPidInfoValid()) {
		double probpi = pidp->probPion();
		double probk  = pidp->probKaon();
		double probe  = pidp->probElectron();
		double probmu  = pidp->probMuon();
		if(probmu > probe && probmu > 0.001 && probmu > probk) return true;
		else
			return false;
	}
	else
		return false;
}



void Chi2gll::selectNeutralTracks(SmartDataPtr<EvtRecEvent> evtRecEvent,
		SmartDataPtr<EvtRecTrackCol> evtRecTrkCol,  vector<int> &iGam) {


	for(int i=evtRecEvent->totalCharged(); i< evtRecEvent->totalTracks(); i++) {
		if (i > m_total_number_of_charged_max) break;

		EvtRecTrackIterator itTrk = evtRecTrkCol->begin() + i ;
		if(!(*itTrk)->isEmcShowerValid()) continue;
		RecEmcShower *emcTrk = (*itTrk)->emcShower();

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

		if(dang>=200) continue;
		dthe = dthe * 180 / (CLHEP::pi);
		dphi = dphi * 180 / (CLHEP::pi);
		dang = dang * 180 / (CLHEP::pi);
		if (dang < m_photon_iso_angle_min ) continue; 

		iGam.push_back((*itTrk)->trackId());
	} // end loop neutral tracks     


}


void Chi2gll::mctruth(){

	SmartDataPtr<Event::McParticleCol> mcParticleCol(eventSvc(), "/Event/MC/McParticleCol");

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
		HepLorentzVector p4iter = (*iter_mc_topo)->initialFourMomentum();
		for(int a=0; a<4; a++) m_p4truth[m_numParticle][a] = p4iter[a];
		m_p4truth[m_numParticle][4] = pdgid * 1.0;
		m_p4truth[m_numParticle][5] = mcidx * 1.0;

		m_numParticle++;
	}
	m_idxmc = m_numParticle;

}

void Chi2gll::saveLepton(EvtRecTrackIterator itTrk, int &a , int type){

	RecMdcKalTrack* mdcKalTrk = (*itTrk)->mdcKalTrack(); 
	double mass = -1;
	if(type == 0) mdcKalTrk->setPidType(RecMdcKalTrack::electron);
	else if(type == 1) mdcKalTrk->setPidType(RecMdcKalTrack::muon);
	else cout<<"in saveLepton(), wrong type"<<endl;

	mass = xmass[type];
	for ( int ll = 0; ll < 4; ll++ ) m_p4trk[a][ll]=mdcKalTrk->p4(mass)[ll];
	m_p4trk[a][4]=mdcKalTrk->charge();
	m_p4trk[a][5]= type;//pid type 0-4 for e mu pi k p

	//emc
	if((*itTrk)->isEmcShowerValid()){
		RecEmcShower *emcTrk = (*itTrk)->emcShower();
		double eraw = emcTrk->energy();
		double phi = emcTrk->phi();
		double theta = emcTrk->theta();
		HepLorentzVector p4 = HepLorentzVector(eraw * sin(theta) * cos(phi), eraw * sin(theta) * sin(phi),eraw * cos(theta),eraw );
		for(int d=0; d<4; d++) m_p4trk[a][d+6] = p4[d];
	}
	else{
		for(int d=0; d<4; d++) m_p4trk[a][d+6] = -1;
	}


}
