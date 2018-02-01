#include "TStyle.h"
#include "TCanvas.h"
void plotveto()
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
    
    mbc->cd();
    TFile *f00, *f01, *f02, *f03;   //before veto
    TFile *f10, *f11, *f12, *f13;   //after veto
	std::stringstream hist_title;
//	hist_title << "h_mrec_gam1";
//	hist_title << "h_Mgamgam";
	hist_title << "h_gam1_E";
	
	//signal
	f00 = new TFile("../run/gen_mc/chic0_invi/event_chic0/chic0_gam2invi_gen_mc_event_n.root");
	TH1F* h00_E = dynamic_cast<TH1F*>(gDirectory->Get(hist_title.str().c_str()));
	f01 = new TFile("../run/gen_mc/chic1_invi/event_chic1/chic1_gam2invi_gen_mc_event_n.root");
	TH1F* h01_E = dynamic_cast<TH1F*>(gDirectory->Get(hist_title.str().c_str()));
	f02 = new TFile("../run/gen_mc/chic2_invi/event_chic2/chic2_gam2invi_gen_mc_event_n.root");
	TH1F* h02_E = dynamic_cast<TH1F*>(gDirectory->Get(hist_title.str().c_str()));
	f10 = new TFile("../run/gen_mc/chic0_invi/event_chic0/chic0_gam2invi_gen_mc_event_nveto.root");
	TH1F* h10_E = dynamic_cast<TH1F*>(gDirectory->Get(hist_title.str().c_str()));
	f11 = new TFile("../run/gen_mc/chic1_invi/event_chic1/chic1_gam2invi_gen_mc_event_nveto.root");
	TH1F* h11_E = dynamic_cast<TH1F*>(gDirectory->Get(hist_title.str().c_str()));
	f12 = new TFile("../run/gen_mc/chic2_invi/event_chic2/chic2_gam2invi_gen_mc_event_nveto.root");
	TH1F* h12_E = dynamic_cast<TH1F*>(gDirectory->Get(hist_title.str().c_str()));
	
	//inclusive
	f03 = new TFile("../run/chic2incl/hist_inclusiveMC/chic2incl_psip_mc_event_merged_n.root");
	TH1F* h03_E = dynamic_cast<TH1F*>(gDirectory->Get(hist_title.str().c_str()));
	f13 = new TFile("../run/chic2incl/hist_inclusiveMC/chic2incl_psip_mc_event_merged_nveto.root");
	TH1F* h13_E = dynamic_cast<TH1F*>(gDirectory->Get(hist_title.str().c_str()));

//	h3_E->Scale(0.01);

	//signal
	h01_E->SetLineColor(kBlue);
	h11_E->SetLineColor(kBlue);
	h01_E->SetLineWidth(2);
	h11_E->SetLineWidth(2);
	h01_E->Draw("e");
	h11_E->Draw("same");
	h00_E->SetLineColor(kRed);
	h10_E->SetLineColor(kRed);
	h00_E->SetLineWidth(2);
	h10_E->SetLineWidth(2);
	h00_E->Draw("e,same");
	h10_E->Draw("same");
	h02_E->SetLineColor(6);
	h12_E->SetLineColor(6);
	h02_E->SetLineWidth(2);
	h12_E->SetLineWidth(2);
	h02_E->Draw("e,same");
	h12_E->Draw("same");
    h00_E->GetXaxis()->SetTitle("E_{#gamma1} (GeV)");
    h00_E->GetYaxis()->SetTitle(ytitle);
    h00_E->GetYaxis()->SetTitleOffset(1.5);
    h00_E->GetYaxis()->SetRange(0, 1200);
  
	//inclusive	
	h03_E->SetLineColor(1);
	h13_E->SetLineColor(1);
	h03_E->SetLineWidth(2);
	h13_E->SetLineWidth(2);
	h03_E->Draw("e");
	h13_E->Draw("same");
    h03_E->GetXaxis()->SetTitle("E_{#gamma1} (GeV)");
    h03_E->GetYaxis()->SetTitle(ytitle);
    h03_E->GetYaxis()->SetTitleOffset(1.5);
    h03_E->GetYaxis()->SetRange(0, 1200);

    TLegend *legend = new TLegend(0.3,0.7,0.7,0.9);
/*	
	//signal
    legend->AddEntry(h00_E,"#gamma_{1} with #chi_{c0} before veto","f");
    legend->AddEntry(h10_E,"#gamma_{1} with #chi_{c0} after veto","f");
    legend->AddEntry(h01_E,"#gamma_{1} with #chi_{c1} before veto","f");
    legend->AddEntry(h11_E,"#gamma_{1} with #chi_{c1} after veto","f");
    legend->AddEntry(h02_E,"#gamma_{1} with #chi_{c2} before veto","f");
    legend->AddEntry(h12_E,"#gamma_{1} with #chi_{c2} after veto","f");
*/
	//inclusive
    legend->AddEntry(h03_E,"#gamma_{1} from inclusive MC before veto","f");
    legend->AddEntry(h13_E,"#gamma_{1} from inclusive MC after veto","f");
    
	legend->SetNColumns(1);
    legend->SetBorderSize(0);
    legend->SetFillColor(0);
    legend->Draw();
    mbc->SaveAs("./Egam1_signal.eps");
}

