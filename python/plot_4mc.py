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
# mbc.SetLogx()

# histo = 'h_Mgamgam_d'
# xmin = 0.0
# xmax = 5.0

# histo = 'h_Mgamgam_n'
# xmin = 0.0
# xmax = 0.7

# histo = 'h_Mgamgam_chi'
# xmin = 3.0
# xmax = 4.0

# histo = 'h_gam1_E_d'
# xmin = 0.0
# xmax = 2.0

histo = 'h_gam1_E_n'
xmin = 0.0
xmax = 0.4

# histo = 'h_gam2_E'
# xmin = 0.0
# xmax = 2.5

# histo = 'h_mrec_gam1_d'
# xmin = 0.0
# xmax = 3.7

# histo = 'h_mrec_gam1_n'
# xmin = 3.3
# xmax = 3.7

# histo = 'h_gam1_costhe'
# histo = 'h_gam2_costhe'

# histo = 'h_mrec_gamgam_d'
# xmin = 0.0
# xmax = 3.8

# histo = 'h_mrec_gamgam_n'
# xmin = 2.9
# xmax = 3.8

# histo = 'h_ngam'

# histo = 'h_chic2_1c_d'
# histo = 'h_chic2_1c_n'

# histo = 'h_angle_gamgam'

# histo = 'h_trigger'

# histo = 'h_time'

## chic2incl
# f0 = TFile("scripts/chic0_invi/event_chic0/chic0_gam2invi_gen_mc_event.root")
# f1 = TFile("scripts/chic1_invi/event_chic1/chic1_gam2invi_gen_mc_event.root")
# f2 = TFile("scripts/chic2_invi/event_chic2/chic2_gam2invi_gen_mc_event.root")
# f3 = TFile('run/chic2incl/hist_inclusiveMC/chic2incl_psip_mc_event_merged_veto.root')
# f4 = TFile('run/chic2incl/hist_data/chic2incl_psip_data_event_merged_veto.root')
# # f4 = TFile('run/chic2incl/hist_data09/chic2incl_psip_data09_event_merged_1.root')
# f5 = TFile('run/chic2incl/hist_data3650/chic2incl_data3650_event_merged_veto.root')
# f6 = TFile('scripts/ee_decay/event/GDimuon.root')

## chicNoTDC
f0 = TFile("scripts/chic0_invi/event_chic0/chic0_gam2invi_gen_mc_noTDC_event_cos.root")
f1 = TFile("scripts/chic1_invi/event_chic1/chic1_gam2invi_gen_mc_noTDC_event_cos.root")
f2 = TFile("scripts/chic2_invi/event_chic2/chic2_gam2invi_gen_mc_noTDC_event_cos.root")
f3 = TFile('run/chicNoTDC/hist_inclusiveMC/chicNoTDC_psip_mc_event_merged_cos.root')
# f0 = TFile("3signal_n/chic0_gam2invi_gen_mc_noTDC_event_n.root")
# f1 = TFile("3signal_n/chic1_gam2invi_gen_mc_noTDC_event_n.root")
# f2 = TFile("3signal_n/chic2_gam2invi_gen_mc_noTDC_event_n.root")
# f3 = TFile('run/chicNoTDC/hist_inclusiveMC/chicNoTDC_psip_mc_event_merged_n.root')
f4 = TFile('run/chicNoTDC/hist_data/chicNoTDC_psip_data_event_merged_trigger.root')
f5 = TFile('run/chicNoTDC/hist_data3650/chicNoTDC_data3650_event_merged_costrig.root')
f6 = TFile('scripts/ee_decay/event/GDimuon_noTDC_event_costrig.root')

h0_E = f0.Get(histo)
h1_E = f1.Get(histo)
h2_E = f2.Get(histo)
h3_E = f3.Get(histo)
h4_E = f4.Get(histo)
h5_E = f5.Get(histo)
h6_E = f6.Get(histo)

xbins = 100.0
ytitle = "Events/%dMeV" %((xmax - xmin) / xbins * 1000.0)
h4_E.GetYaxis().SetTitle(ytitle)
h4_E.GetYaxis().SetRangeUser(1, 100000000)

h4_E.SetTitle("")

# h3_E.Scale(0.1)

# for data 2012
h5_E.Scale(7.866)
h3_E.Scale(341.0/400.0)
# h5_E.Scale(11.33)

# for data 2009
# h5_E.Scale(3.45)

# h4_E.Scale(1)
# h4_E.SetBins(10, -0.5, 9.5)
# h3_E.SetBins(10, -0.5, 9.5)
# h5_E.SetBins(10, -0.5, 9.5)

# h4_E.Scale(0.5)

# h0_E.Scale(30000)
# h1_E.Scale(30000)
# h2_E.Scale(30000)
# h5_E.Scale(7.866)
# # h4_E.Scale(0.000013)
# # h3_E.Scale(341.0/400.0)
# h3_E.Scale(2000)
# # h4_E.GetYaxis().SetRangeUser(1, 300000)
# h4_E.GetYaxis().SetRangeUser(0, 8000000)

# just for costheta
# h5_E.Scale(0.0025)
# h4_E.Scale(0.00025)
# h3_E.Scale(0.25)
# h6_E.Scale(0.1)
# h4_E.GetYaxis().SetRangeUser(1, 200)

# just for theta_gamgam
# h0_E.Scale(20000)
# h1_E.Scale(20000)
# h2_E.Scale(20000)
# h3_E.Scale(2000)
# h6_E.Scale(2000)
# h5_E.Scale(7.866)
# h4_E.GetYaxis().SetRangeUser(1, 1600000)

h0_E.SetLineColor(ROOT.kRed)
h1_E.SetLineColor(ROOT.kBlue)
h2_E.SetLineColor(ROOT.kMagenta)
h4_E.SetLineColor(ROOT.kGreen+3)
h5_E.SetLineColor(ROOT.kOrange+7)
h6_E.SetLineColor(ROOT.kCyan+2)
h3_E.SetLineWidth(2)
h2_E.SetLineWidth(2)
h1_E.SetLineWidth(2)
h0_E.SetLineWidth(2)
h4_E.SetLineWidth(2)
h5_E.SetLineWidth(2)
h6_E.SetLineWidth(2)

# h4_E.SetFillColor(ROOT.kGreen+3)
# h5_E.SetFillColor(ROOT.kOrange+7)
# h6_E.SetFillColor(ROOT.kCyan+2)
# h4_E.SetFillStyle(3335)
# h5_E.SetFillStyle(3005)
# h6_E.SetFillStyle(3353)

# mbc.cd()
h4_E.Draw('')
h3_E.Draw("same")
h2_E.Draw("same")
h0_E.Draw("same")
h1_E.Draw("same")
h5_E.Draw("same")
h6_E.Draw("same")


h4_E.GetYaxis().SetName("")
h4_E.GetYaxis().SetTitleOffset(1.5)

legend = TLegend(0.63, 0.68, 0.84, 0.87)
# legend = TLegend(0.55, 0.28, 0.77, 0.47)
# legend = TLegend(0.45, 0.68, 0.67, 0.87)
# legend = TLegend(0.18, 0.68, 0.48, 0.87)
legend.AddEntry(h0_E,'#gamma_{1} with #chi_{c0}')
legend.AddEntry(h1_E,'#gamma_{1} with #chi_{c1}')
legend.AddEntry(h2_E,'#gamma_{1} with #chi_{c2}')
legend.AddEntry(h3_E,'#gamma_{1} from incl MC')
legend.AddEntry(h4_E,'#gamma_{1} from data 2012')
legend.AddEntry(h5_E,'#gamma_{1} from con3650')
legend.AddEntry(h6_E,'#gamma_{1} from GDimuon')
#legend.SetNColums(1)
legend.SetBorderSize(0)
legend.SetFillColor(0)
legend.Draw()


# h4_E.GetXaxis().SetTitle("M_{#gamma#gamma} (GeV/c^{2})")
# mbc.SaveAs("python/plots/Mgamgam_d_n.pdf")

# h4_E.GetXaxis().SetTitle("M_{#gamma#gamma} (GeV/c^{2})")
# mbc.SaveAs("python/plots/Mgamgam_n_n.pdf")

# h4_E.GetXaxis().SetTitle("M_{#gamma#gamma} (GeV/c^{2})")
# mbc.SaveAs("python/plots/Mgamgam_chi_n.pdf")

# h4_E.GetXaxis().SetTitle("E_{#gamma1} (GeV)")
# mbc.SaveAs("python/plots/egam1_d_no.pdf")

h4_E.GetXaxis().SetTitle("E_{#gamma1} (GeV)")
mbc.SaveAs("python/plots/egam1_n_costrig.pdf")

# h4_E.GetXaxis().SetTitle("E_{#gamma2} (GeV)")
# mbc.SaveAs("python/plots/egam2_tdc.pdf")
# mbc.SaveAs("python/plots/egam2normalscale.pdf")

# h4_E.GetXaxis().SetTitle("mrec_{#gamma1} (GeV/c^{2})")
# mbc.SaveAs("python/plots/mrecgam1_d.pdf")

# h4_E.GetXaxis().SetTitle("mrec_{#gamma1} (GeV/c^{2})")
# mbc.SaveAs("python/plots/mrecgam1_n.pdf")

# h4_E.GetXaxis().SetTitle("cos#theta_{1}")
# mbc.SaveAs("python/plots/cosgam1_cos.pdf")

# h4_E.GetXaxis().SetTitle("cos#theta_{2}")
# mbc.SaveAs("python/plots/cosgam2_cos.pdf")

# h4_E.GetXaxis().SetTitle("mrec_{#gamma#gamma} (GeV/c^{2})")
# mbc.SaveAs("python/plots/mrecgamgam_d.pdf")

# h4_E.GetXaxis().SetTitle("mrec_{#gamma#gamma} (GeV/c^{2})")
# mbc.SaveAs("python/plots/mrecgamgam_n.pdf")

# h4_E.GetXaxis().SetTitle("#chi^{2}_{1c}")
# mbc.SaveAs("python/plots/chisq.pdf")

# h4_E.GetXaxis().SetTitle("#theta_{#gamma#gamma}")
# mbc.SaveAs("python/plots/theta_veto.pdf")

# h1_E.GetXaxis().SetTitle("trigger")
# mbc.SaveAs("python/plots/trigger_no.pdf")

# h4_E.GetXaxis().SetTitle("time")
# mbc.SaveAs("python/plots/time.pdf")

# h4_E.GetXaxis().SetTitle("ngam")
# mbc.SaveAs("python/plots/ngam.pdf")
