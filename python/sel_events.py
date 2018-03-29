#!/usr/bin/env python
"""
Event Selection 
"""

__author__ = "XIAO Suyu <xiaosuyu@ihep.ac.cn>"
__copyright__ = "Copyright (c) XIAO Suyu"
__created__ = "[2017-12]" 

import sys
import os
import math 
import ROOT 
from progressbar import Bar, Percentage, ProgressBar
from time import time 
from tools import duration, check_outfile_path
from array import array

ECMS = 3.686
h_evtflw = ROOT.TH1F('hevtflw', 'eventflow', 10, 0, 10) 
h_evtflw.GetXaxis().SetBinLabel(1, 'raw')
h_evtflw.GetXaxis().SetBinLabel(2, 'N_{#gamma}=2')
h_evtflw.GetXaxis().SetBinLabel(3, '|cos#theta|<0.75')
h_evtflw.GetXaxis().SetBinLabel(8, '3<M_{#gamma#gamma}^{rec}<3.75') 

h_mrec_gam1 = ROOT.TH1D('h_mrec_gam1', 'mrec_gam1', 100, 3.3, 3.7)
h_mrec_gamgam = ROOT.TH1D('h_mrec_gamgam', 'mrec_gamgam', 100, 0.0, 3.95)
h_Mgamgam_wide = ROOT.TH1D('h_Mgamgam_wide', 'Mgamgam_wide', 100, 0, 4) 
h_Mgamgam_narrow = ROOT.TH1D('h_Mgamgam_narrow', 'Mgamgam_narrow', 100, 0, 0.7) 
h_gam1_p = ROOT.TH1D('h_gam1_p', 'gam1_p', 100, 0.0, 0.5) 
h_gam2_p = ROOT.TH1D('h_gam2_p', 'gam2_p', 100, 0.0, 0.5) 
h_gam1_costhe = ROOT.TH1D('h_gam1_costhe', 'gam1_costhe', 100, -1.0, 1.0)
h_gam1_E_wide = ROOT.TH1D('h_gam1_E_wide', 'gam1_E_wide', 100, 0.0, 2.0)
h_gam1_E_narrow = ROOT.TH1D('h_gam1_E_narrow', 'gam1_E_narrow', 100, 0.0, 0.4)
h_gam2_E = ROOT.TH1D('h_gam2_E', 'gam2_E', 100, 0.0, 2.0)
h_gam2_costhe = ROOT.TH1D('h_gam2_costhe', 'gam2_costhe', 100, -1.0, 1.0)
h_ngam = ROOT.TH1D('h_ngam', 'ngam', 100, 0, 11)

# Global items
#MC = bool(m_isMonteCarlo) 
raw_gpx = ROOT.vector('double')()
raw_gpy = ROOT.vector('double')()
raw_gpz = ROOT.vector('double')()
#n_raw_ge = ROOT.vector('double')()
raw_ge = ROOT.vector('double')()
gam1_E = ROOT.vector('double')()
gam2_E = ROOT.vector('double')()

raw_costheta = ROOT.vector('double')()
#m_pdgid = ROOT.vector('int')()
#m_pdgid = ROOT.array
#gam1_E = array('i', 100*[-99])

# ROOT.gROOT.ProcessLine(
# "struct MyTreeStruct{\
#    Double_t gam1_E;\
# };"	);

args = sys.argv[1:]
    #    print sys.argv[0]  
##    exit (0)

if (len(args) < 2):
    print 'input error'

infile = args[0]
outfile = args[1]
check_outfile_path(outfile)

fin = ROOT.TFile(infile)
t = fin.Get('tree')
t.SetBranchAddress("raw_gpx", raw_gpx)
t.SetBranchAddress("raw_gpy", raw_gpy)
t.SetBranchAddress("raw_gpz", raw_gpz)
t.SetBranchAddress("raw_ge", raw_ge)
t.SetBranchAddress("raw_costheta", raw_costheta)
t.SetBranchAddress("raw_costheta", raw_costheta)
#t.SetBranchAddress("m_isMonteCarlo", m_isMonteCarlo)
 #   t.SetBranchAddress("pdgid", m_pdgid, "pdgid[100]/I")
#    t.SetBranchAddress("motheridx", m_motheridx, "motheridx[100]/I")
entries = t.GetEntriesFast()
#   fout = ROOT.TFile(outfile, "RECREATE")
fout = ROOT.TFile(outfile, "RECREATE")
t_out = ROOT.TTree('tree', 'tree')
#mystruct = ROOT.MyTreeStruct()
#    t_out.Branch('vtx_mrecgam1', mystruct, 'vtx_mrecgam1/D')
# t_out.Branch('gam1_E', gam1_E, 'gam1_E/D')
t_out.Branch('gam1_E', gam1_E)
t_out.Branch('gam2_E', gam2_E)
t_out.Branch("raw_gpx", raw_gpx)
t_out.Branch("raw_gpy", raw_gpy)
t_out.Branch("raw_gpz", raw_gpz)
t_out.Branch("raw_ge", raw_ge)
t_out.Branch("raw_costheta", raw_costheta)


n_run = array('i',[0])
n_event = array('i',[0])
n_indexmc = array('i',[0])
t_out.Branch("run", n_run, "run/I")
t_out.Branch("event", n_event, "event/I")
t_out.Branch("indexmc", n_indexmc, "indexmc/I")
n_pdgid = array('i', 100*[-99])
n_motheridx = array('i', 100*[-99])
t_out.Branch("pdgid", n_pdgid, "pdgid[100]/I")
t_out.Branch("motheridx", n_motheridx, "motheridx[100]/I")

pbar = ProgressBar(widgets=[Percentage(), Bar()], maxval=entries).start()
time_start = time()

cms_p4 = ROOT.TLorentzVector(0.011*ECMS, 0, 0, ECMS)
print 'entries=', entries 
for jentry in xrange(entries):
#for jentry in xrange(1000):    
    pbar.update(jentry+1)
#    ientry = t.LoadTree(jentry)
    nb = t.GetEntry(jentry)
#    print len(raw_ge)
    if (len(raw_ge) == 2):
        gam1_index = -1
        gam2_index = -1 
        if (raw_ge[0] < raw_ge[1]):
            gam1_index = 0
            gam2_index = 1
        else:
            gam1_index = 1
            gam2_index = 0
        gam1_p4_raw = ROOT.TLorentzVector(t.raw_gpx.at(gam1_index), t.raw_gpy.at(gam1_index), t.raw_gpz.at(gam1_index), t.raw_ge.at(gam1_index))    
        gam2_p4_raw = ROOT.TLorentzVector(t.raw_gpx.at(gam2_index), t.raw_gpy.at(gam2_index), t.raw_gpz.at(gam2_index), t.raw_ge.at(gam2_index))

        gam_p4_raw = gam1_p4_raw
        gams_p4_raw = gam1_p4_raw + gam2_p4_raw
        rec_gam1_p4_raw = cms_p4 - gam_p4_raw
        rec_gams_p4_raw = cms_p4 - gams_p4_raw
        
        cut_ngam = (t.ngam == 2)
        cut_pi0 = (gams_p4_raw.M() < 0.10 or gams_p4_raw.M() > 0.16)
        cut_eta = (gams_p4_raw.M() < 0.50 or gams_p4_raw.M() > 0.57)
        cut_chic = (gams_p4_raw.M() < 3.22 or gams_p4_raw.M() > 3.75)
        cut_cos = (abs(t.raw_costheta.at(gam1_index)) < 0.75 and abs(t.raw_costheta.at(gam2_index)) < 0.75)
        # cut_mrec = (rec_gam1_p4_raw.M() > 3.3 and rec_gam1_p4_raw.M() < 3.7)
        # cut_chic2 = (rec_gam1_p4_raw.M() > 3.54 and rec_gam1_p4_raw.M() < 3.59)
        cut_egam = (t.raw_ge.at(gam1_index) < t.raw_ge.at(gam2_index))

        Mgamgam = gams_p4_raw.M()
        mrec_gam1_raw = rec_gam1_p4_raw.M()
        mrec_gamgam_raw = rec_gams_p4_raw.M()

        #if (cut_ngam and cut_egam and cut_pi0 and cut_eta and cut_chic and cut_chic2):

        # veto
        if (cut_ngam and cut_egam and cut_pi0 and cut_eta and cut_chic):
        
        # cos
        # if (cut_ngam and cut_egam and cut_pi0 and cut_eta and cut_chic and cut_cos):
        
        # n
        # if (cut_ngam and cut_egam):
            
            gam1_E.push_back(t.raw_ge.at(gam1_index))
            gam2_E.push_back(t.raw_ge.at(gam2_index))
            h_Mgamgam_wide.Fill(Mgamgam)
            h_Mgamgam_narrow.Fill(Mgamgam)
            h_mrec_gam1.Fill(mrec_gam1_raw)
            h_mrec_gamgam.Fill(mrec_gamgam_raw)
            h_gam1_costhe.Fill(t.raw_costheta.at(gam1_index))
            h_gam1_E_wide.Fill(t.raw_ge.at(gam1_index))
            h_gam1_E_narrow.Fill(t.raw_ge.at(gam1_index))
            h_gam2_E.Fill(t.raw_ge.at(gam2_index))
            h_gam2_costhe.Fill(t.raw_costheta.at(gam2_index))
            h_ngam.Fill(t.ngam)
#            print t.run
            if (t.run < 0):   # judge whether this run is MonteCarlo
                n_run[0] = t.run
                n_event[0] = t.event
                n_indexmc[0] = t.m_indexmc
                for ii in range(t.m_indexmc):
                    n_pdgid[ii] = t.m_pdgid[ii]
                    n_motheridx[ii] = t.m_motheridx[ii]
       #     t_out.Fill()
            gam1_E.clear()
            gam2_E.clear()
        
#t_out.Write()
h_evtflw.Write()
h_mrec_gam1.Write()
h_mrec_gamgam.Write()
h_Mgamgam_wide.Write()
h_Mgamgam_narrow.Write()
h_gam1_costhe.Write()
h_gam1_E_wide.Write()
h_gam1_E_narrow.Write()
h_gam2_E.Write()
h_gam2_costhe.Write()
h_ngam.Write()
fout.Close()
pbar.finish()
                
    
dur = duration(time()-time_start)
sys.stdout.write(' \nDone in %s. \n' % dur)
