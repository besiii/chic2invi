#!/usr/bin/env python
"""
Generate plots
"""

__author__ = "XIAO Suyu <xiaosuyu@ihep.ac.cn>"
__copyright__ = "Copyright (c) XIAO Suyu"
__created__ = "[2018-02-27 Tue 17:08]"

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
'''
#signal
f00 = TFile("run/gen_mc/chic0_invi/event_chic0/chic0_gam2invi_gen_mc_event_n.root")
f01 = TFile("run/gen_mc/chic1_invi/event_chic1/chic1_gam2invi_gen_mc_event_n.root")
f02 = TFile("run/gen_mc/chic2_invi/event_chic2/chic2_gam2invi_gen_mc_event_n.root")
f10 = TFile("run/gen_mc/chic0_invi/event_chic0/chic0_gam2invi_gen_mc_event_nveto.root")
f11 = TFile("run/gen_mc/chic1_invi/event_chic1/chic1_gam2invi_gen_mc_event_nveto.root")
f12 = TFile("run/gen_mc/chic2_invi/event_chic2/chic2_gam2invi_gen_mc_event_nveto.root")
h00_E = f00.Get('h_gam1_E')
h01_E = f01.Get('h_gam1_E')
h02_E = f02.Get('h_gam1_E')
h10_E = f10.Get('h_gam1_E')
h11_E = f11.Get('h_gam1_E')
h12_E = f12.Get('h_gam1_E')

h00_E.SetLineColor(ROOT.kRed)
h01_E.SetLineColor(ROOT.kBlue)
h02_E.SetLineColor(ROOT.kMagenta)
h10_E.SetLineColor(ROOT.kRed)
h11_E.SetLineColor(ROOT.kBlue)
h12_E.SetLineColor(ROOT.kMagenta)
h00_E.SetLineWidth(2)
h01_E.SetLineWidth(2)
h02_E.SetLineWidth(2)
h10_E.SetLineWidth(2)
h11_E.SetLineWidth(2)
h12_E.SetLineWidth(2)
h02_E.Draw('e')
h01_E.Draw("e,same")
h00_E.Draw("e,same")
h12_E.Draw('same')
h11_E.Draw("same")
h10_E.Draw("same")
h00_E.GetXaxis().SetTitle("E_{#gamma1} (GeV)")
h00_E.GetYaxis().SetTitle(ytitle)
h00_E.GetYaxis().SetTitleOffset(1.5)
h00_E.SetMaximum(1200)
'''
#inclusive
f03 = TFile("run/chic2incl/hist_inclusiveMC/chic2incl_psip_mc_event_merged_n.root")
f13 = TFile("run/chic2incl/hist_inclusiveMC/chic2incl_psip_mc_event_merged_nveto.root")
h03_E = f03.Get('h_gam1_E')
h13_E = f13.Get('h_gam1_E')
h03_E.SetLineColor(ROOT.kBlack)
h13_E.SetLineColor(ROOT.kBlack)
h03_E.SetLineWidth(2)
h13_E.SetLineWidth(2)
h03_E.Draw('e')
h13_E.Draw("same")
h03_E.GetXaxis().SetTitle("E_{#gamma1} (GeV)")
h03_E.GetYaxis().SetTitle(ytitle)
h03_E.GetYaxis().SetTitleOffset(1.5)

legend = TLegend(0.5, 0.55, 0.82, 0.85)
'''
#signal
legend.AddEntry(h00_E,'#gamma_{1} with #chi_{c0} before veto')
legend.AddEntry(h01_E,'#gamma_{1} with #chi_{c1} before veto')
legend.AddEntry(h02_E,'#gamma_{1} with #chi_{c2} before veto')
legend.AddEntry(h10_E,'#gamma_{1} with #chi_{c0} after veto')
legend.AddEntry(h11_E,'#gamma_{1} with #chi_{c1} after veto')
legend.AddEntry(h12_E,'#gamma_{1} with #chi_{c2} after veto')
'''
#inclusive
legend.AddEntry(h03_E,'#gamma_{1} from inclusive MC before veto')
legend.AddEntry(h13_E,'#gamma_{1} from inclusive MC after veto')


#legend.SetNColums(1)
legend.SetBorderSize(0)
legend.SetFillColor(0)
legend.Draw()
#mbc.SaveAs("python/plots/veto_signal.pdf")
mbc.SaveAs("python/plots/veto_inclusive.pdf")

