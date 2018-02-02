#include "TStyle.h"
#include "TCanvas.h"
void plot()
{
    TCanvas *mbc=new TCanvas("mbc","mbc",800,600);
    mbc->SetFillColor(0);
    mbc->SetFrameFillColor(0);
    gStyle->SetPadColor(0);
    gStyle->SetCanvasColor(0);
    gStyle->SetOptStat(0);
    mbc->SetLeftMargin(0.15);
    mbc->SetRightMargin(0.15);
    mbc->SetTopMargin(0.1);
    mbc->SetBottomMargin(0.15);
    // set ytitle
    Double_t xmin=0, xmax=2;  Double_t xbins=500;
    //TH1::SetDefaultSumw2(1);
    TString a("Events/"); char b[100];  sprintf(b, "(%5.1f",(xmax-xmin)/xbins    *1000); TString d(" MeV)");
    TString ytitle = a + b + d;

    TChain *chic0=new TChain("tree");
    chic0->Add("../run/gen_mc/chic0_invi/rootfile_chic0/chic0_gam2invi_gen_mc.root");
    TChain *chic1=new TChain("tree");
    chic1->Add("../run/gen_mc/chic1_invi/rootfile_chic1/chic1_gam2invi_gen_mc.root");
    TChain *chic2=new TChain("tree");
    chic2->Add("../run/gen_mc/chic2_invi/rootfile_chic2/chic2_gam2invi_gen_mc.root");
    
    THStack *hs = new THStack("hs",""); 
/*    TH1D *MC_DD_phipi=new TH1D("MC_DD_phipi","",100,0.0,1.6);
    MC_DD_phipi->SetLineColor(kRed);
    MC_DD_phipi->SetFillColor(0);
    MC_DD_phipi->SetLineWidth(3);
    TH1D *MC_DD_kkpi=new TH1D("MC_DD_kkpi","",100,0.0,1.6);
    MC_DD_kkpi->SetLineColor(28);
    MC_DD_kkpi->SetFillColor(0);
    MC_DD_kkpi->SetLineWidth(2);
    MC_DD_kkpi->SetLineStyle(1);
*/
    TH1D *fromchic0=new TH1D("fromchic0","",100,0.0,2.0);
    fromchic0->SetFillColor(kRed);
    TH1D *fromchic1=new TH1D("fromchic1","",100,0.0,2.0);
    fromchic1->SetFillColor(kBlue);
    TH1D *fromchic2=new TH1D("fromchic2","",100,0.0,2.0);
    fromchic2->SetFillColor(6);
    

		TString a("raw_ge");
		TString cut("");

    chic0->Project("fromchic0",a,cut);
    chic1->Project("fromchic1",a,cut);
    chic2->Project("fromchic2",a,cut);
   
    fromchic0->Scale(214404/9997);
    fromchic1->Scale(214404/10399);
    fromchic2->Scale(214404/10177);
    
    
    hs->Add(fromchic0);
    hs->Add(fromchic1);
    hs->Add(fromchic2);
    

    mbc->cd();
    //hs->SetMaximum(130);
    hs->Draw();
    hs->GetXaxis()->SetTitle("E_{#gamma} (GeV)");
    hs->GetYaxis()->SetTitle(ytitle);
    hs->GetYaxis()->SetTitleOffset(1.5);
    
    TFile *f1;
	std::stringstream hist_title;
	hist_title << "h_gam1_E";
	f1 = new TFile("../run/chic2incl/hist_inclusiveMC/chic2incl_psip_mc_event_merged_ncostag.root");
	TH1F* h_E = dynamic_cast<TH1F*>(gDirectory->Get(hist_title.str().c_str()));
	h_E->Draw("same");
//    h_E->GetYaxis()->SetRange(0, 20000);


    TLegend *legend = new TLegend(0.3,0.7,0.7,0.8);
    //legend->SetHeader(tt);
    legend->AddEntry("fromchic0","E_{#gamma}_in_process_chic0","f");
    legend->AddEntry("fromchic1","E_{#gamma}_in_process_chic1","f");
    legend->AddEntry("fromchic2","E_{#gamma}_in_process_chic2","f");
//    legend->AddEntry("h_E","Egam_total","f");

    legend->SetNColumns(1);
    legend->SetBorderSize(0);
    legend->SetFillColor(0);
    legend->Draw();
    mbc->SaveAs("./chicj.eps");
}

