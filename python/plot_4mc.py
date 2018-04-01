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
mbc.SetLogy()

xmin = 0.0
xmax = 0.4
xbins = 100.0
ytitle = "Events/%dMeV" %((xmax - xmin) / xbins * 1000.0)

# histo = 'h_Mgamgam_d'
# histo = 'h_Mgamgam_n'
# histo = 'h_gam1_E_d'
# histo = 'h_gam1_E_n'
# histo = 'h_gam2_E'
# histo = 'h_mrec_gam1_d'
# histo = 'h_mrec_gam1_n'
# histo = 'h_gam1_costhe'
# histo = 'h_gam2_costhe'
# histo = 'h_mrec_gamgam_d'
histo = 'h_mrec_gamgam_n'
# histo = 'h_ngam'
f0 = TFile("scripts/chic0_invi/event_chic0/chic0_gam2invi_gen_mc_event_22.root")
f1 = TFile("scripts/chic1_invi/event_chic1/chic1_gam2invi_gen_mc_event_22.root")
f2 = TFile("scripts/chic2_invi/event_chic2/chic2_gam2invi_gen_mc_event_22.root")
f3 = TFile('run/chic2incl/hist_inclusiveMC/chic2incl_psip_mc_event_merged_22.root')
f4 = TFile('run/chic2incl/hist_data/chic2incl_psip_data_event_merged_22.root')
f5 = TFile('run/chic2incl/hist_data3650/chic2incl_data3650_event_merged_22.root')
f6 = TFile('scripts/ee_decay/event/GDimuon_22.root')
h0_E = f0.Get(histo)
h1_E = f1.Get(histo)
h2_E = f2.Get(histo)
h3_E = f3.Get(histo)
h4_E = f4.Get(histo)
h5_E = f5.Get(histo)
h6_E = f6.Get(histo)

h5_E.Scale(11.33)
h4_E.Scale(1)
h4_E.GetYaxis().SetRangeUser(1, 10000000000)

# just for costheta
# h5_E.Scale(0.00025)
# h4_E.Scale(0.000025)
# h3_E.Scale(0.025)
# h6_E.Scale(0.1)
# h4_E.GetYaxis().SetRangeUser(1, 260)

h0_E.SetLineColor(ROOT.kRed)
h1_E.SetLineColor(ROOT.kBlue)
h2_E.SetLineColor(ROOT.kMagenta)
h4_E.SetLineColor(ROOT.kGreen+3)
h5_E.SetLineColor(ROOT.kOrange+7)
h6_E.SetLineColor(ROOT.kCyan+2)
h3_E.SetLineWidth(2)
h4_E.SetLineWidth(2)
h2_E.SetLineWidth(2)
h1_E.SetLineWidth(2)
h0_E.SetLineWidth(2)
h5_E.SetLineWidth(2)
h6_E.SetLineWidth(2)
h4_E.Draw('e')
h2_E.Draw("same")
h1_E.Draw("same")
h0_E.Draw("same")
h3_E.Draw("same")
h5_E.Draw("same")
h6_E.Draw("same")


h4_E.GetYaxis().SetTitle(ytitle)
h4_E.GetYaxis().SetTitleOffset(1.5)

legend = TLegend(0.44, 0.68, 0.74, 0.87)
#legend = TLegend(0.54, 0.68, 0.84, 0.87)
# legend = TLegend(0.3, 0.65, 0.6, 0.87)
legend.AddEntry(h0_E,'#gamma_{1} with #chi_{c0}')
legend.AddEntry(h1_E,'#gamma_{1} with #chi_{c1}')
legend.AddEntry(h2_E,'#gamma_{1} with #chi_{c2}')
legend.AddEntry(h3_E,'#gamma_{1} from inclusive MC')
legend.AddEntry(h4_E,'#gamma_{1} from data 2012')
legend.AddEntry(h5_E,'#gamma_{1} from con3650')
legend.AddEntry(h6_E,'#gamma_{1} from GDimuon')
#legend.SetNColums(1)
legend.SetBorderSize(0)
legend.SetFillColor(0)
legend.Draw()


# h4_E.GetXaxis().SetTitle("M_{#gamma#gamma} (GeV/c^{2})")
# mbc.SaveAs("python/plots/Mgamgam_d.pdf")

# h4_E.GetXaxis().SetTitle("M_{#gamma#gamma} (GeV/c^{2})")
# mbc.SaveAs("python/plots/Mgamgam_n.pdf")

# h4_E.GetXaxis().SetTitle("E_{#gamma1} (GeV)")
# mbc.SaveAs("python/plots/egam1_d.pdf")

# h4_E.GetXaxis().SetTitle("E_{#gamma1} (GeV)")
# mbc.SaveAs("python/plots/egam1_n.pdf")

# h4_E.GetXaxis().SetTitle("E_{#gamma2} (GeV)")
# mbc.SaveAs("python/plots/egam2.pdf")

# h4_E.GetXaxis().SetTitle("mrec_{#gamma1} (GeV/c^{2})")
# mbc.SaveAs("python/plots/mrecgam1_d.pdf")

# h4_E.GetXaxis().SetTitle("mrec_{#gamma1} (GeV/c^{2})")
# mbc.SaveAs("python/plots/mrecgam1_n.pdf")

# h4_E.GetXaxis().SetTitle("cos#theta_{1}")
# mbc.SaveAs("python/plots/cosgam1.pdf")

# h4_E.GetXaxis().SetTitle("cos#theta_{2}")
# mbc.SaveAs("python/plots/cosgam2.pdf")

# h4_E.GetXaxis().SetTitle("mrec_{#gamma#gamma} (GeV/c^{2})")
# mbc.SaveAs("python/plots/mrecgamgam_d.pdf")

h4_E.GetXaxis().SetTitle("mrec_{#gamma#gamma} (GeV/c^{2})")
mbc.SaveAs("python/plots/mrecgamgam_n.pdf")

