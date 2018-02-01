#include "TStyle.h"
#include "TCanvas.h"
void plotegam1()
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
    Double_t xmin=0, xmax=2;  Double_t xbins=100;
    //TH1::SetDefaultSumw2(1);
    TString a("Events/"); char b[100];  sprintf(b, "(%5.1f",(xmax-xmin)/xbins    *1000); TString d(" MeV)");
    TString ytitle = a + b + d;

    TChain *chic0=new TChain("tree");
    chic0->Add("../run/gen_mc/chic0_invi/rootfile_chic0/chic0_gam2invi_gen_mc.root");
    TChain *chic1=new TChain("tree");
    chic1->Add("../run/gen_mc/chic1_invi/rootfile_chic1/chic1_gam2invi_gen_mc.root");
    TChain *chic2=new TChain("tree");
    chic2->Add("../run/gen_mc/chic2_invi/rootfile_chic2/chic2_gam2invi_gen_mc.root");
    TChain *incl=new TChain("tree");
    incl->Add("../run/chic2incl/hist_inclusiveMC/chic2invi_psip_mc_merged_2.root");
    incl->Add("../run/chic2incl/hist_inclusiveMC/chic2invi_psip_mc_merged_3.root");
    
    TH1D *fromchic0=new TH1D("fromchic0","",100,0.0,0.4);
    fromchic0->SetLineColor(kRed);
    TH1D *fromchic1=new TH1D("fromchic1","",100,0.0,0.4);
    fromchic1->SetLineColor(kBlue);
    TH1D *fromchic2=new TH1D("fromchic2","",100,0.0,0.4);
    fromchic2->SetLineColor(6);
    TH1D *fromincl=new TH1D("fromincl","",100,0.0,0.4);
    fromincl->SetLineColor(1);
    
	TString a("raw_ge");
    chic0->Project("fromchic0",a);
    chic1->Project("fromchic1",a);
    chic2->Project("fromchic2",a);
    incl->Project("fromincl",a);
   
    fromincl->Scale(0.005);
//    fromincl->Scale(0.003);
    
	fromincl->Draw();
	fromchic0->Draw("same");
	fromchic1->Draw("same");
	fromchic2->Draw("same");

    fromincl->GetXaxis()->SetTitle("E_{#gamma} (GeV)");
    fromincl->GetYaxis()->SetTitle(ytitle);
    fromincl->GetYaxis()->SetTitleOffset(1.5);
    

    TLegend *legend = new TLegend(0.3,0.7,0.7,0.8);
    //legend->SetHeader(tt);
    legend->AddEntry("fromchic0","E_{#gamma} in process chic0","f");
    legend->AddEntry("fromchic1","E_{#gamma} in process chic1","f");
    legend->AddEntry("fromchic2","E_{#gamma} in process chic2","f");
    legend->AddEntry("fromincl","E_{#gamma} in Inclusive MC","f");
//    legend->AddEntry("h_E","Egam_total","f");

    legend->SetNColumns(1);
    legend->SetBorderSize(0);
    legend->SetFillColor(0);
    legend->Draw();
    mbc->SaveAs("./egam1before.eps");
}

