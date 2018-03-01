#!/usr/bin/env python
"""
Generate plots
"""

__author__ = "XIAO Suyu <xiaosuyu@ihep.ac.cn>"
__copyright__ = "Copyright (c) XIAO Suyu"
__created__ = "[2018-02-27 Tue 15:49]"

import ROOT
from ROOT import gStyle, TCanvas, TString, TChain, TStyle
from ROOT import TH1D, TFile, TLegend

mbc = TCanvas('mbc', '', 800, 600)
mbc.SetFillColor(0)
mbc.SetFrameFillColor(0)
gStyle.SetPadColor(0)
gStyle.SetCanvasColor(0)
gStyle.SetOptStat(0)
mbc.SetLeftMargin(0.15)
mbc.SetRightMargin(0.15)
mbc.SetTopMargin(0.1)
mbc.SetBottomMargin(0.15)

xmin = 0.0
xmax = 0.4
xbins = 100.0
ytitle = "Events/%dMeV" %((xmax - xmin) / xbins * 1000.0)

f0 = TFile("scripts/chic0_invi/event_chic0/chic0_gam2invi_gen_mc_event_nveto.root")
f1 = TFile("scripts/chic1_invi/event_chic1/chic1_gam2invi_gen_mc_event_nveto.root")
f2 = TFile("scripts/chic2_invi/event_chic2/chic2_gam2invi_gen_mc_event_nveto.root")
f3 = TFile('run/chic2incl/hist_inclusiveMC/chic2incl_psip_mc_event_merged_nveto.root')
#h0_E = f0.Get('h_gam1_E')
#h1_E = f1.Get('h_gam1_E')
#h2_E = f2.Get('h_gam1_E')
#h3_E = f3.Get('h_gam1_E')
h0_E = f0.Get('h_Mgamgam')
h1_E = f1.Get('h_Mgamgam')
h2_E = f2.Get('h_Mgamgam')
h3_E = f3.Get('h_Mgamgam')

#h3_E.Scale(0.5)
h3_E.Scale(0.01)
h0_E.SetLineColor(ROOT.kRed)
h1_E.SetLineColor(ROOT.kBlue)
h2_E.SetLineColor(ROOT.kMagenta)
h3_E.SetLineWidth(2)
h2_E.SetLineWidth(2)
h1_E.SetLineWidth(2)
h0_E.SetLineWidth(2)
h3_E.Draw()
h2_E.Draw("same")
h1_E.Draw("same")
h0_E.Draw("same")
#h3_E.GetXaxis().SetTitle("E_{#gamma1} (GeV)")
h3_E.GetXaxis().SetTitle("M_{#gamma#gamma} (GeV/c^{2})")
h3_E.GetYaxis().SetTitle(ytitle)
h3_E.GetYaxis().SetTitleOffset(1.5)
h3_E.GetYaxis().SetRange(0, 1200)

legend = TLegend(0.5, 0.6, 0.82, 0.8)
legend.AddEntry(h0_E,'#gamma_{1} with #chi_{c0}')
legend.AddEntry(h1_E,'#gamma_{1} with #chi_{c1}')
legend.AddEntry(h2_E,'#gamma_{1} with #chi_{c2}')
legend.AddEntry(h3_E,'#gamma_{1} from inclusive MC')

#legend.SetNColums(1)
legend.SetBorderSize(0)
legend.SetFillColor(0)
legend.Draw()
#mbc.SaveAs("python/plots/egam1.pdf")
mbc.SaveAs("python/plots/Mgamgam.pdf")
