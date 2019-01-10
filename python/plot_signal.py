#!/usr/bin/env python
"""
Generate plots
"""

__author__ = "AMIT PATHAK <amit@ihep.ac.cn>"
__copyright__ = "Copyright (c) AMIT PATHAK"
__created__ = "[2019-01-08 Tue 15:00]"

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
xmax = 5.0
xbins = 500.0
ytitle = "Events/%dMeV" %((xmax - xmin) / xbins * 1000.0)

f0 = TFile("doc/fig/chi2gll_selection_001.root")
f1 = TFile("doc/fig/chic2incl_psip_mc_event_merged_1.root")


h0_E = f0.Get('h_inv_mass_chicj')
h1_E = f1.Get('h_inv_mass_chicj')

h0_E.Scale(1.0/h0_E.Integral())
h1_E.Scale(1.0/h1_E.Integral())

h0_E.SetLineColor(ROOT.kRed)
h1_E.SetLineColor(ROOT.kBlue)

h0_E.SetLineWidth(2)
h1_E.SetLineWidth(2)
h1_E.Draw()
h0_E.Draw()
h1_E.Draw("same")
h0_E.Draw("same")
h1_E.GetXaxis().SetTitle("inv_mass_{#chi_{cJ}} (GeV/c^{2})")
h1_E.GetYaxis().SetTitle(ytitle)
h1_E.GetYaxis().SetTitleOffset(1.5)
h1_E.SetMaximum(2400)

legend = TLegend(0.65, 0.6, 0.82, 0.8)
legend.AddEntry(h0_E,'inv_mass of #chi_{cJ}')
legend.AddEntry(h1_E,'inv_mass of #chi_{cJ}')




legend.SetBorderSize(0)
legend.SetFillColor(0)
legend.Draw()
mbc.SaveAs("dat/run/plots/mass_chicj_signal.pdf")

