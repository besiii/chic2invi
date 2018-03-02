#!/usr/bin/env python
"""
Generate plots
"""

__author__ = "XIAO Suyu <xiaosuyu@ihep.ac.cn>"
__copyright__ = "Copyright (c) XIAO Suyu"
__created__ = "[2018-02-06 Tue 09:47]"

import ROOT
from ROOT import gStyle, TCanvas, TString, TChain, TStyle
from ROOT import THStack, TH1D, TFile, TLegend

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
chic0.Add('scripts/chic0_invi/rootfile_chic0/chic0_gam2invi_gen_mc.root')
chic1 = TChain('tree')
chic1.Add('scripts/chic1_invi/rootfile_chic1/chic1_gam2invi_gen_mc.root')
chic2 = TChain('tree')
chic2.Add('scripts/chic2_invi/rootfile_chic2/chic2_gam2invi_gen_mc.root')

hs = THStack('hs', '')

fromchic0 = TH1D('fromchic0', '', 100, 0.0, 2.0)
fromchic0.SetFillColor(ROOT.kRed)
fromchic1 = TH1D('fromchic1', '', 100, 0.0, 2.0)
fromchic1.SetFillColor(ROOT.kBlue)
fromchic2 = TH1D('fromchic2', '', 100, 0.0, 2.0)
fromchic2.SetFillColor(6)

chic0.Project('fromchic0', 'raw_ge')
chic1.Project('fromchic1', 'raw_ge')
chic2.Project('fromchic2', 'raw_ge')

fromchic0.Scale(214404/9997)
fromchic1.Scale(214404/10399)
fromchic2.Scale(214404/10177)

hs.Add(fromchic0)
hs.Add(fromchic1)
hs.Add(fromchic2)


mbc.cd()
hs.Draw()
hs.GetXaxis().SetTitle('E_{#gamma} (GeV)')
hs.GetYaxis().SetTitle(ytitle)
hs.GetYaxis().SetTitleOffset(1.5)

#f1 = TFile('run/chic2incl/hist_inclusiveMC/chic2incl_psip_mc_event_merged_ncostag.root')
#h_E = f1.Get('h_gam1_E')
#h_E.Draw('same')

legend = TLegend(0.5, 0.6, 0.72, 0.8)
legend.AddEntry('fromchic0','E_{#gamma} in process chic0')
legend.AddEntry('fromchic1','E_{#gamma} in process chic0')
legend.AddEntry('fromchic2','E_{#gamma} in process chic0')

#legend.SetNColums(1)
legend.SetBorderSize(0)
legend.SetFillColor(0)
legend.Draw()
mbc.SaveAs("python/plots/stack3signal.pdf")
