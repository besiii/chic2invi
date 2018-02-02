#include "TStyle.h"
#include "TCanvas.h"
void plotmrec()
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
    Double_t xmin=0, xmax=0.4;  Double_t xbins=100;
    //TH1::SetDefaultSumw2(1);
//    TString a("Events/"); char b[100];  sprintf(b, "(%5.1f",(xmax-xmin)/xbins    *1000); TString d(" MeV/c^{2})");
    TString a("Events/"); char b[100];  sprintf(b, "(%5.1f",(xmax-xmin)/xbins    *1000); TString d(" MeV)");
    TString ytitle = a + b + d;

 /*  
    fromchic0->Scale(214404/9997);
    fromchic1->Scale(214404/10399);
    fromchic2->Scale(214404/10177);
   */ 
    
    mbc->cd();
    //hs->SetMaximum(130);
    TFile *f0, *f1, *f2, *f3;
	std::stringstream hist_title;
//	hist_title << "h_mrec_gam1";
//	hist_title << "h_Mgamgam";
	hist_title << "h_gam1_E";
	f0 = new TFile("../run/gen_mc/chic0_invi/event_chic0/chic0_gam2invi_gen_mc_event_nveto.root");
	TH1F* h0_E = dynamic_cast<TH1F*>(gDirectory->Get(hist_title.str().c_str()));
	f1 = new TFile("../run/gen_mc/chic1_invi/event_chic1/chic1_gam2invi_gen_mc_event_nveto.root");
	TH1F* h1_E = dynamic_cast<TH1F*>(gDirectory->Get(hist_title.str().c_str()));
	f2 = new TFile("../run/gen_mc/chic2_invi/event_chic2/chic2_gam2invi_gen_mc_event_nveto.root");
	TH1F* h2_E = dynamic_cast<TH1F*>(gDirectory->Get(hist_title.str().c_str()));
	f3 = new TFile("../run/chic2incl/hist_inclusiveMC/chic2incl_psip_mc_event_merged_nveto.root");
	TH1F* h3_E = dynamic_cast<TH1F*>(gDirectory->Get(hist_title.str().c_str()));

//	h3_E->Scale(0.01);
	h3_E->Scale(0.3);
	h0_E->SetLineColor(kRed);
	h1_E->SetLineColor(kBlue);
	h2_E->SetLineColor(6);
	h3_E->SetLineWidth(2);
	h3_E->Draw();
	h2_E->Draw("same");
	h1_E->Draw("same");
	h0_E->Draw("same");
//    h3_E->GetXaxis()->SetTitle("mrec_{#gamma1} (GeV/c^{2})");
//    h3_E->GetXaxis()->SetTitle("M_{#gamma#gamma} (GeV/c^{2})");
    h2_E->GetXaxis()->SetTitle("E_{#gamma1} (GeV)");
    h2_E->GetYaxis()->SetTitle(ytitle);
    h2_E->GetYaxis()->SetTitleOffset(1.5);
    h2_E->GetYaxis()->SetRange(0, 1200);
    
    TLegend *legend = new TLegend(0.3,0.7,0.7,0.9);
    //legend->SetHeader(tt);
    legend->AddEntry(h0_E,"#gamma_{1} with #chi_{c0}","f");
    legend->AddEntry(h1_E,"#gamma_{1} with #chi_{c1}","f");
    legend->AddEntry(h2_E,"#gamma_{1} with #chi_{c2}","f");
    legend->AddEntry(h3_E,"#gamma_{1} from inclusive MC","f");

    legend->SetNColumns(1);
    legend->SetBorderSize(0);
    legend->SetFillColor(0);
    legend->Draw();
//    mbc->SaveAs("./mrecgam1.eps");
//    mbc->SaveAs("./Mgamgam.eps");
    mbc->SaveAs("./Egam1.eps");
}

