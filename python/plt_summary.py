#!/usr/bin/env python
"""
Plot summary histograms
"""

__author__ = "XIAO Suyu <xiaosuyu@ihep.ac.cn>"
__copyright__ = "Copyright (c) XIAO Suyu"
__created__ = "[2018-02-01 Thu 14:22]"

import os
import sys
import ROOT
from tools import check_outfile_path, set_root_style

def main():
	set_root_style(stat=0, grid=0)
	ROOT.gStyle.SetPadLeftMargin(0.15)

	sample = sys.argv[1:]
	fs = get_files_from_sample(sample)
	c = ROOT.TCanvas('c', 'c', 800, 800)
	
	draw_ngam(sample, c, fs)

def get_files_from_sample(sample):
	fs = []
	if 'chic0_invi' in sample:
		fs.append(ROOT.TFile('run/gen_mc/chic0_invi/event_chic0/chic0_gam2invi_gen_mc_event.root'))
	elif 'hist_inclusiveMC' in sample:
		fs.append(ROOT.TFile('run/chic2incl/hist_inclusiveMC/chic2incl_psip_mc_event_merged_n.root'))
	
	return fs

def leg_add_entry_hist(leg, f, h):
	sample = f.GetName()
	sample = sample.split('/')[2]

	if sample in ['chic0_invi']:
		leg.AddEntry(h, '#chi_{c0}')
	elif sample in ['hist_inclusiveMC']:
		leg.AddEntry(h, 'hist_inclusiveMC')

	else:
		raise NameError(sample)
	
	return leg

def draw_ngam(sample, c, fs):
	hname = 'h_ngam'
	figfile = 'doc/fig/chic2invi_ngam_%s.pdf' %"_".join(sample)

	leg = ROOT.TLegend(0.2, 0.71, 0.32, 0.91)
	hs, leg = get_common_objects_to_draw(fs, hname, leg)

	for h in hs:
		if hs.index(h) == 0:
			h.SetXTitle('N_{#gamma}')
			h.SetYTitle('Events')
			h.SetMarkerStyle(ROOT.kFullDotLarge)
			h.Draw()
		else:
			h.Draw('same')
	leg.Draw()
	c.SaveAs(figfile)

def get_common_objects_to_draw(fs, hname, leg):
	hs = []

	leg.SetTextSize(0.03)
	leg.SetFillColor(0)
	leg.SetFillStyle(0)
	leg.SetLineColor(0)
	leg.SetShadowColor(0)

	for f in fs:
		h = f.Get(hname)
		if fs.index(f) == 0:
			h.GetXaxis().SetLabelSize(0.03)
			h.GetYaxis().SetLabelSize(0.03)
			h.GetYaxis().SetTitleOffset(1.8)
			h.SetMarkerStyle(ROOT.kFullDotLarge)

		elif fs.index(f) == 1:
			h.SetLineColor(29)
			h.SetFillColor(29)

		elif fs.index(f) == 2:
			h.SetLineColor(ROOT.kOrange)
			h.SetFillColor(ROOT.kOrange)

		leg = leg_add_entry_hist(leg, f, h)
		hs.append(h)
	
	return hs, leg


if __name__ =='__main__':
	main()
