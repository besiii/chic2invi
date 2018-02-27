#!/usr/bin/env python
"""
Generate plots
"""

__author__ = "XIAO Suyu <xiaosuyu@ihep.ac.cn>"
__copyright__ = "Copyright (c) XIAO Suyu"
__created__ = "[2018-02-27 Tue 15:06]"

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
xmax = 2.0
xbins = 100.0
ytitle = "Events/%dMeV" %((xmax - xmin) / xbins * 1000.0)

chic0 = TChain('tree')
chic0.Add('run/gen_mc/chic0_invi/rootfile_chic0/chic0_gam2invi_gen_mc.root')
chic1 = TChain('tree')
chic1.Add('run/gen_mc/chic1_invi/rootfile_chic1/chic1_gam2invi_gen_mc.root')
chic2 = TChain('tree')
chic2.Add('run/gen_mc/chic2_invi/rootfile_chic2/chic2_gam2invi_gen_mc.root')
incl = TChain('tree')
incl.Add('run/chic2incl/hist_inclusiveMC/chic2invi_psip_mc_merged_2.root')
incl.Add('run/chic2incl/hist_inclusiveMC/chic2invi_psip_mc_merged_3.root')

fromchic0 = TH1D('fromchic0', '', 100, 0.0, 2.0)
fromchic0.SetLineColor(ROOT.kRed)
fromchic1 = TH1D('fromchic1', '', 100, 0.0, 2.0)
fromchic1.SetLineColor(ROOT.kBlue)
fromchic2 = TH1D('fromchic2', '', 100, 0.0, 2.0)
fromchic2.SetLineColor(ROOT.kMagenta)
fromincl = TH1D('fromincl', '', 100, 0.0, 2.0)
fromincl.SetLineColor(ROOT.kBlack)
fromincl.SetLineWidth(2)
fromchic0.SetLineWidth(2)
fromchic1.SetLineWidth(2)
fromchic2.SetLineWidth(2)

chic0.Project('fromchic0', 'raw_ge')
chic1.Project('fromchic1', 'raw_ge')
chic2.Project('fromchic2', 'raw_ge')
incl.Project('fromincl', 'raw_ge')

fromincl.Scale(0.003)

fromincl.Draw()
fromchic0.Draw('same')
fromchic1.Draw('same')
fromchic2.Draw('same')

fromincl.GetXaxis().SetTitle('E_{#gamma} (GeV)')
fromincl.GetYaxis().SetTitle(ytitle)
fromincl.GetYaxis().SetTitleOffset(1.5)

legend = TLegend(0.5, 0.6, 0.72, 0.8)
legend.AddEntry('fromchic0','E_{#gamma} in process chic0')
legend.AddEntry('fromchic1','E_{#gamma} in process chic1')
legend.AddEntry('fromchic2','E_{#gamma} in process chic2')
legend.AddEntry('fromincl','E_{#gamma} in Inclusive MC')

#legend.SetNColums(1)
legend.SetBorderSize(0)
legend.SetFillColor(0)
legend.Draw()
mbc.SaveAs("python/plots/same4mc.pdf")


