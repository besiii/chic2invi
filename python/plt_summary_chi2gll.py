#!/usr/bin/env python
"""
Plot summary histograms
"""

__author__ = "AMIT PATHAK <amit@ihep.ac.cn>"
__copyright__ = "Copyright (c) AMIT PATHAK"
__created__ = "[2018-12-24 Mon 15:33]"

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
	
	draw_run(sample, c, fs)
	draw_mass_electron(sample, c, fs)

def get_files_from_sample(sample):
	fs = []
	if 'chi2gll' in sample:
		fs.append(ROOT.TFile('dat/chi2gll_selection_001.root'))
	
	return fs

def leg_add_entry_hist(leg, f, h):
	sample = f.GetName()
	sample = sample.split('/')[1]
	if sample in ['chi2gll_selection_001.root']:
		leg.AddEntry(h, 'chi2gll')
	
	else:
		raise NameError(sample)
	
	return leg

def draw_run(sample, c, fs):
	hname = 'h_run'
	figfile = 'doc/fig/chi2gll_run_%s.pdf' %"_".join(sample)
	check_outfile_path(figfile)
	leg = ROOT.TLegend(0.2, 0.71, 0.32, 0.91)
	hs, leg = get_common_objects_to_draw(fs, hname, leg)

	for h in hs:
		if hs.index(h) == 0:
			h.SetXTitle('run')
			h.SetYTitle('Events')
			h.SetMarkerStyle(ROOT.kFullDotLarge)
			h.Draw()
		else:
			h.Draw('same')
	leg.Draw()
	c.SaveAs(figfile)

def draw_mass_electron(sample, c, fs):
	hname = 'h_inv_mass_electron'
	figfile = 'doc/fig/chi2gll_mass_electron_%s.pdf' %"_".join(sample)
	check_outfile_path(figfile)
	leg = ROOT.TLegend(0.2, 0.71, 0.32, 0.91)
	hs, leg = get_common_objects_to_draw(fs, hname, leg)

	for h in hs:
		if hs.index(h) == 0:
			h.SetXTitle('mass_electron(GeV)')
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
