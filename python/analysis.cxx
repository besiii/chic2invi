#include <TFile.h>
#include <TH1.h>
#include <TTree.h>
#include <TChain.h>
#include <TLorentzVector.h>

void analysis()
{
	double mPsip = 3.686;
	Double_t ecms = 3.686;
	double n_mgamma1;

	//inclusive mc
	TFile* newfile = new TFile("../cxx.root", "recreate");
	TTree* newtree = new TTree("all", "step2");
	TChain chain("tree");

//	string filelist="/afs/ihep.ac.cn/users/x/xiaosy/bes/chic2invi/v0.1/run/chic2invi/rootfile_inclusiveMC/";
//	string filename;
//	ifstream is(filelist.c_str());
//	while(getline(is,filename)){
//		chain.Add(filename.c_str());
//		cout<<"filename"<<filename<<endl;
//	} 

//	chain.Add("/afs/ihep.ac.cn/users/x/xiaosy/bes/chic2invi/v0.1/run/chic2incl/hist_inclusiveMC/chic2invi_psip_mc_merged_2.root");
//	chain.Add("/afs/ihep.ac.cn/users/x/xiaosy/bes/chic2invi/v0.1/run/chic2incl/hist_inclusiveMC/chic2invi_psip_mc_merged_3.root");
	chain.Add("/afs/ihep.ac.cn/users/x/xiaosy/bes/chic2invi/v0.1/run/chic2incl/rootfile_inclusiveMC/chic2invi_psip_mc-99.root");
	

	//data3650
/*	TFile* newfile = new TFile("Analysis_data3650.root", "recreate");
	TTree* newtree = new TTree("all", "step2");
	TChain chain("tree");
//	chain.Add("/afs/ihep.ac.cn/users/x/xiaosy/bes/chic2invi/v0.1/run/chic2invi/hist_data3650/chic2invi_data3650_merged_3.root");
//	chain.Add("/afs/ihep.ac.cn/users/x/xiaosy/bes/chic2invi/v0.1/run/chic2invi/hist_data3650/chic2invi_data3650_merged_4.root");
	chain.Add("/afs/ihep.ac.cn/users/x/xiaosy/bes/chic2invi/v0.1/run/chic2invi/hist_data3650/chic2invi_data3650_merged_16.root");
*/	
/*	//signal mc
	TFile* newfile = new TFile("Analysis_signalmc.root", "recreate");
	TTree* newtree = new TTree("all", "step2");
	TChain chain("tree");
	chain.Add("/besfs/groups/nphy/users/xiaosy/bes/chic2invi/v0.1/run/gen_mc/chic0_invi/rootfile_chic0/chic0_gam2invi_gen_mc.root");
//	chain.Add("/besfs/groups/nphy/users/xiaosy/bes/chic2invi/v0.1/run/gen_mc/chic1_invi/rootfile_chic1/chic1_gam2invi_gen_mc.root");
//	chain.Add("/besfs/groups/nphy/users/xiaosy/bes/chic2invi/v0.1/run/gen_mc/chic2_invi/rootfile_chic2/chic2_gam2invi_gen_mc.root");
*/
	Int_t m_run, m_event, m_indexmc, m_pdgid[100], m_motheridx[100];
	std::vector<double> *  m_raw_ge = 0;
	std::vector<double> * m_raw_gpx = 0;
	std::vector<double> * m_raw_gpy = 0;
	std::vector<double> * m_raw_gpz = 0;
	std::vector<double> * m_raw_phi = 0;
	std::vector<double> * m_raw_theta = 0;
	std::vector<double> * m_raw_costheta = 0;

	chain.SetBranchAddress("run", &m_run);
	chain.SetBranchAddress("event", &m_event);
	chain.SetBranchAddress("indexmc", &m_indexmc);
	chain.SetBranchAddress("pdgid", &m_pdgid);
	chain.SetBranchAddress("motheridx", &m_motheridx);
	chain.SetBranchAddress("raw_ge",   &m_raw_ge);
	chain.SetBranchAddress("raw_gpx", &m_raw_gpx);
	chain.SetBranchAddress("raw_gpy", &m_raw_gpy);
	chain.SetBranchAddress("raw_gpz", &m_raw_gpz);
	chain.SetBranchAddress("raw_phi", &m_raw_phi);
	chain.SetBranchAddress("raw_theta", &m_raw_theta);
	chain.SetBranchAddress("raw_costheta", &m_raw_costheta);

	//newtree
	Int_t n_run, n_event, n_indexmc, n_pdgid[100], n_motheridx[100];
	Int_t n_ngam;
	Double_t n_raw_g1px;
	Double_t n_raw_g1py;
	Double_t n_raw_g1pz;
	Double_t n_raw_g1e;
	Double_t n_raw_g2px;
	Double_t n_raw_g2py;
	Double_t n_raw_g2pz;
	Double_t n_raw_g2e;
	Double_t n_raw_Mgams;
	std::vector<double> *n_raw_phi;
	std::vector<double> *n_raw_theta;
	std::vector<double> *n_raw_costheta;
	TLorentzVector rec_gam1_p4_raw;
	TLorentzVector rec_gams_p4_raw;
	Double_t egam1;
	Double_t mrec_p4_raw;
	Double_t mrec_p4s_raw;

	newtree->Branch("run", &n_run, "run/I");
	newtree->Branch("event", &n_event, "event/I");
	newtree->Branch("ngam", &n_ngam, "ngam/I");
	newtree->Branch("indexmc", &n_indexmc, "indexmc/I");
	newtree->Branch("pdgid", n_pdgid, "pdgid[100]/I");
	newtree->Branch("motheridx", n_motheridx, "motheridx[100]/I");
	newtree->Branch("raw_g1e", &n_raw_g1e, "n_raw_g1e/D");
	newtree->Branch("raw_g1px", &n_raw_g1px, "n_raw_g1px/D");
	newtree->Branch("raw_g1py", &n_raw_g1py, "n_raw_g1py/D");
	newtree->Branch("raw_g1pz", &n_raw_g1pz, "n_raw_g1pz/D");
	newtree->Branch("raw_g2e", &n_raw_g2e, "n_raw_g2e/D");
	newtree->Branch("raw_g2px", &n_raw_g2px, "n_raw_g2px/D");
	newtree->Branch("raw_g2py", &n_raw_g2py, "n_raw_g2py/D");
	newtree->Branch("raw_g2pz", &n_raw_g2pz, "n_raw_g2pz/D");
	newtree->Branch("egam1", &egam1, "egam1/D");
	newtree->Branch("mrec_p4_raw", &mrec_p4_raw, "mrec_p4_raw/D");
	newtree->Branch("mrec_p4s_raw", &mrec_p4s_raw, "mrec_p4s_raw/D");
	newtree->Branch("raw_phi", &n_raw_phi);
	newtree->Branch("raw_theta", &n_raw_theta);
	newtree->Branch("raw_costheta", &n_raw_costheta);
	newtree->Branch("raw_Mgams", &n_raw_Mgams, "n_raw_Mgams/D");

	//newtree->Branch("");

	//analysis
	TLorentzVector cms_p4(0.011*ecms, 0, 0, ecms) ;
	TLorentzVector gam_p4_raw;
	TLorentzVector gams_p4_raw;
//	cout << "N " << chain.GetEntries() << endl;
	for (Int_t ii=0; ii<chain.GetEntries(); ii++){
		
	//	if (ii>5000) break;
		chain.GetEntry(ii);
		if (m_raw_ge->size() != 2) continue;

		//-------------------------------------------
		//   calculation
		//-------------------------------------------

		int gam1_index = -1;
		int gam2_index = -1;
		int Ncount  = 0;

		if (m_raw_costheta->size() != 2 ) continue;
/*		for(int l=0; l < m_raw_ge->size(); l++)
		{
			//cuts on photon candidates
			if (! ( m_raw_costheta->at(l) < 0.75 &&  m_raw_costheta->at(l) >-0.75 ) ) continue;
			Ncount ++;
		}
		if (Ncount != 2 ) continue;
*/
		//find index of gam1, gam2
		if (m_raw_ge->at(0) < m_raw_ge->at(1)){
			gam1_index = 0;
			gam2_index = 1;
		}
		else {
			gam1_index = 1;
			gam2_index = 0;
		}

		//---find gam1, gam2
		//--------------------------------------------
		//---event level selection
		TLorentzVector gam1_p4_raw(m_raw_gpx->at(gam1_index), m_raw_gpy->at(gam1_index),m_raw_gpz->at(gam1_index),m_raw_ge->at(gam1_index));
		TLorentzVector gam2_p4_raw(m_raw_gpx->at(gam2_index), m_raw_gpy->at(gam2_index),m_raw_gpz->at(gam2_index),m_raw_ge->at(gam2_index));

		//calculate 
		gam_p4_raw = gam1_p4_raw;
		gams_p4_raw = gam1_p4_raw + gam2_p4_raw;
		rec_gam1_p4_raw = cms_p4 - gam_p4_raw;
		rec_gams_p4_raw = cms_p4 - gams_p4_raw;

		// cut
		//Egam1
	//	if (! (m_raw_ge->at(gam1_index) > 0.22 && m_raw_ge->at(gam1_index) < 0.28) ) continue;
		//RecM gam1
	//	if(! (rec_gam1_p4_raw.M() > 3.4 && rec_gam1_p4_raw.M() < 3.45) ) continue;

		//veto Mgamgam	
		if( (gams_p4_raw.M() > 0.10 && gams_p4_raw.M() < 0.16) ) continue;	
		if( (gams_p4_raw.M() > 0.50 && gams_p4_raw.M() < 0.56) ) continue;	
		if( (gams_p4_raw.M() > 3.20 && gams_p4_raw.M() < 3.75) ) continue;	
		//----------------------------
		//   save into new tree
		//----------------------------
		n_run = m_run;
		n_event = m_event;
		n_ngam = m_raw_ge->size();
		n_indexmc = m_indexmc;
		n_raw_phi = m_raw_phi;
		n_raw_theta = m_raw_theta;
		n_raw_costheta = m_raw_costheta;
		n_raw_g1px = m_raw_gpx->at(gam1_index);
		n_raw_g1py = m_raw_gpy->at(gam1_index);
		n_raw_g1pz = m_raw_gpz->at(gam1_index);
		n_raw_g1e = m_raw_ge->at(gam1_index);
		n_raw_g2px = m_raw_gpx->at(gam2_index);
		n_raw_g2py = m_raw_gpy->at(gam2_index);
		n_raw_g2pz = m_raw_gpz->at(gam2_index);
		n_raw_g2e = m_raw_ge->at(gam2_index);
		n_raw_Mgams = gams_p4_raw.M();
		egam1 = m_raw_ge->at(gam1_index);
		mrec_p4_raw = rec_gam1_p4_raw.M();
		mrec_p4s_raw = rec_gams_p4_raw.M();
		for (Int_t m=0; m<n_indexmc; m++){
			n_pdgid[m] = m_pdgid[m];
			n_motheridx[m] = m_motheridx[m];
		}
		newtree->Fill();
	}
	newfile->cd();
	newtree->Write();
//	cout<<"end"<<endl;
}
