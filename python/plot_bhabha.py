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
#mbc.SetLogy()

xmin = 0.0
xmax = 5.0
xbins = 100.0
ytitle = "Events/%dMeV" %((xmax - xmin) / xbins * 1000.0)

# histo = 'h_gam1_E_n'
histo = 'h_Mgamgam_d'
f0 = TFile('scripts/ee_decay/event/GDimuon_veto.root')
f1 = TFile('scripts/ee_decay/event/GEBhabha.root')
f2 = TFile('scripts/ee_decay/event/GDiphoton.root')
f3 = TFile('run/chic2incl/hist_data3650/chic2incl_data3650_event_merged_veto.root')
h0_E = f0.Get(histo)
h1_E = f1.Get(histo)
h2_E = f2.Get(histo)
h3_E = f3.Get(histo)

h1_E.Scale(4.09)
h2_E.Scale(1.33)
h3_E.Scale(0.0025)
h0_E.GetYaxis().SetRangeUser(1, 12000)

h0_E.SetLineColor(ROOT.kCyan+2)
h1_E.SetLineColor(ROOT.kBlue)
h2_E.SetLineColor(ROOT.kRed)
h3_E.SetLineColor(ROOT.kOrange+7)
h2_E.SetLineWidth(2)
h1_E.SetLineWidth(2)
h0_E.SetLineWidth(2)
h3_E.SetLineWidth(2)
h0_E.Draw("")
h1_E.Draw("same")
h2_E.Draw("same")
h3_E.Draw("same")
# h0_E.GetXaxis().SetTitle("E_{#gamma1} (GeV)")
h0_E.GetXaxis().SetTitle("M_{#gamma#gamma} (GeV/c^{2})")
h0_E.GetYaxis().SetTitle(ytitle)
h0_E.GetYaxis().SetTitleOffset(1.5)

#legend = TLegend(0.44, 0.68, 0.74, 0.87)
legend = TLegend(0.54, 0.68, 0.84, 0.87)
# legend = TLegend(0.16, 0.65, 0.46, 0.87)
legend.AddEntry(h0_E,'#gamma_{1} in Dimuon')
legend.AddEntry(h1_E,'#gamma_{1} in Bhabha')
legend.AddEntry(h2_E,'#gamma_{1} in Diphoton')
legend.AddEntry(h3_E,'#gamma_{1} in Con3650')

#legend.SetNColums(1)
legend.SetBorderSize(0)
legend.SetFillColor(0)
legend.Draw()
# mbc.SaveAs("python/plots/bhabha_egam1.pdf")
mbc.SaveAs("python/plots/bhabha_Mgamgam.pdf")
