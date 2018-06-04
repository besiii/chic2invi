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

h_mrec_gam1_d = ROOT.TH1D('h_mrec_gam1_d', 'mrec_gam1_d', 100, 0.0, 3.7)
h_mrec_gam1_n = ROOT.TH1D('h_mrec_gam1_n', 'mrec_gam1_n', 100, 3.3, 3.7)
h_mrec_gamgam_d = ROOT.TH1D('h_mrec_gamgam_d', 'mrec_gamgam_d', 100, 0.0, 3.8)
h_mrec_gamgam_n = ROOT.TH1D('h_mrec_gamgam_n', 'mrec_gamgam_n', 100, 2.9, 3.8)
h_Mgamgam_d = ROOT.TH1D('h_Mgamgam_d', 'Mgamgam_d', 100, 0, 5) 
h_Mgamgam_n = ROOT.TH1D('h_Mgamgam_n', 'Mgamgam_n', 100, 0, 0.7) 
h_gam1_p = ROOT.TH1D('h_gam1_p', 'gam1_p', 100, 0.0, 0.5) 
h_gam2_p = ROOT.TH1D('h_gam2_p', 'gam2_p', 100, 0.0, 0.5) 
h_gam1_costhe = ROOT.TH1D('h_gam1_costhe', 'gam1_costhe', 100, -1.0, 1.0)
h_gam1_E_d = ROOT.TH1D('h_gam1_E_d', 'gam1_E_d', 100, 0.0, 2.0)
h_gam1_E_n = ROOT.TH1D('h_gam1_E_n', 'gam1_E_n', 100, 0.0, 0.4)
h_gam2_E = ROOT.TH1D('h_gam2_E', 'gam2_E', 100, 0.0, 2.5)
h_gam2_costhe = ROOT.TH1D('h_gam2_costhe', 'gam2_costhe', 100, -1.0, 1.0)
h_ngam = ROOT.TH1D('h_ngam', 'ngam', 100, 0, 11)
h_chic2_1c_d = ROOT.TH1D('h_chic2_1c_d', 'm_chic2_1c', 100, 0, 0.0001)
h_chic2_1c_n = ROOT.TH1D('h_chic2_1c_n', 'm_chic2_1c', 100, 0, 0.00001)
h_angle_gamgam = ROOT.TH1D('h_angle_gamgam', 'angle_gamgam', 100, 0, 3.15)
h_trigger = ROOT.TH1D('h_trigger', 'raw_trigger', 16, 1, 17)

# Global items
raw_gpx = ROOT.vector('double')()
raw_gpy = ROOT.vector('double')()
raw_gpz = ROOT.vector('double')()
raw_ge = ROOT.vector('double')()
gam1_E = ROOT.vector('double')()
gam2_E = ROOT.vector('double')()
raw_costheta = ROOT.vector('double')()
m_chic2_1c = ROOT.vector('double')()
angle_gamgam = ROOT.vector('double')()
raw_trigger = ROOT.vector('double')()

args = sys.argv[1:]

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
# t.SetBranchAddress("raw_trigger", raw_trigger)
# t.SetBranchAddress("m_chic2_1c", m_chic2_1c)
entries = t.GetEntriesFast()
fout = ROOT.TFile(outfile, "RECREATE")
t_out = ROOT.TTree('tree', 'tree')
t_out.Branch('gam1_E', gam1_E)
t_out.Branch('gam2_E', gam2_E)
t_out.Branch("raw_gpx", raw_gpx)
t_out.Branch("raw_gpy", raw_gpy)
t_out.Branch("raw_gpz", raw_gpz)
t_out.Branch("raw_ge", raw_ge)
t_out.Branch("raw_costheta", raw_costheta)
t_out.Branch("m_chic2_1c", m_chic2_1c)
t_out.Branch("angle_gamgam", angle_gamgam)
t_out.Branch("raw_trigger", raw_trigger)


n_run = array('i',[0])
n_event = array('i',[0])
n_indexmc = array('i',[0])
t_out.Branch("run", n_run, "run/I")
t_out.Branch("Event", n_event, "event/I")
t_out.Branch("indexmc", n_indexmc, "indexmc/I")
n_pdgid = array('i', 100*[-99])
n_motheridx = array('i', 100*[-99])
t_out.Branch("pdgid", n_pdgid, "pdgid[100]/I")
t_out.Branch("motheridx", n_motheridx, "motheridx[100]/I")

pbar = ProgressBar(widgets=[Percentage(), Bar()], maxval=entries).start()
time_start = time()

cms_p4 = ROOT.TLorentzVector(0.011*ECMS, 0, 0, ECMS)
# entries = 10
print 'entries=', entries 
for jentry in xrange(entries):
    pbar.update(jentry+1)
    nb = t.GetEntry(jentry)

    h_ngam.Fill(t.ngam)
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

        theta_gamgam = gam1_p4_raw.Angle(gam2_p4_raw.Vect())

        gam_p4_raw = gam1_p4_raw
        gams_p4_raw = gam1_p4_raw + gam2_p4_raw
        rec_gam1_p4_raw = cms_p4 - gam_p4_raw
        rec_gams_p4_raw = cms_p4 - gams_p4_raw
        
        cut_ngam = (t.ngam == 2)
        cut_pi0 = (gams_p4_raw.M() < 0.10 or gams_p4_raw.M() > 0.16)
        cut_eta = (gams_p4_raw.M() < 0.50 or gams_p4_raw.M() > 0.57)
        cut_chic = (gams_p4_raw.M() < 3.22 or gams_p4_raw.M() > 3.75)
        cut_cos = (abs(t.raw_costheta.at(gam1_index)) < 0.75 and abs(t.raw_costheta.at(gam2_index)) < 0.75)
        cut_egam = (t.raw_ge.at(gam1_index) < t.raw_ge.at(gam2_index))
        cut_chisq_2 = (t.m_chic2_1c.at(0) < 0.000001)
        cut_angle_gamgam = (gam1_p4_raw.Angle(gam2_p4_raw.Vect())>0.65 and gam1_p4_raw.Angle(gam2_p4_raw.Vect())<2.9)
        cut_egam2 = (t.raw_ge.at(gam2_index) > 0.5)

        Mgamgam = gams_p4_raw.M()
        mrec_gam1_raw = rec_gam1_p4_raw.M()
        mrec_gamgam_raw = rec_gams_p4_raw.M()
        #if (t.raw_trigger.at(0) == 2 or t.raw_trigger.at(0) == 3 or t.raw_trigger.at(0) == 6):
        #    print t.event 
        # cut on energe of gam2
        # if (cut_ngam and cut_egam and cut_pi0 and cut_eta and cut_chic and cut_angle_gamgam and cut_egam2):

        # angle_gamgam
        if (cut_ngam and cut_egam and cut_pi0 and cut_eta and cut_chic and cut_angle_gamgam):

        # chisq on chic2
        # if (cut_ngam and cut_egam and cut_pi0 and cut_eta and cut_chic and cut_chisq_2):

        # veto
        # if (cut_ngam and cut_egam and cut_pi0 and cut_eta and cut_chic):
        
        # cos
        # if (cut_ngam and cut_egam and cut_pi0 and cut_eta and cut_chic and cut_cos):
        
        # n
        # if (cut_ngam and cut_egam):
            
            gam1_E.push_back(t.raw_ge.at(gam1_index))
            gam2_E.push_back(t.raw_ge.at(gam2_index))
            angle_gamgam.push_back(theta_gamgam)

            h_Mgamgam_d.Fill(Mgamgam)
            h_Mgamgam_n.Fill(Mgamgam)
            h_mrec_gam1_d.Fill(mrec_gam1_raw)
            h_mrec_gam1_n.Fill(mrec_gam1_raw)
            h_mrec_gamgam_d.Fill(mrec_gamgam_raw)
            h_mrec_gamgam_n.Fill(mrec_gamgam_raw)
            h_gam1_costhe.Fill(t.raw_costheta.at(gam1_index))
            h_gam1_E_d.Fill(t.raw_ge.at(gam1_index))
            h_gam1_E_n.Fill(t.raw_ge.at(gam1_index))
            h_gam2_E.Fill(t.raw_ge.at(gam2_index))
            h_gam2_costhe.Fill(t.raw_costheta.at(gam2_index))
            h_chic2_1c_d.Fill(t.m_chic2_1c.at(0))
            h_chic2_1c_n.Fill(t.m_chic2_1c.at(0))
            h_angle_gamgam.Fill(gam1_p4_raw.Angle(gam2_p4_raw.Vect()))
            
            
#            print t.run
            if (t.run < 0):   # judge whether this run is MonteCarlo
                n_run[0] = t.run
                n_event[0] = t.event
                n_indexmc[0] = t.m_indexmc
                for ii in range(t.m_indexmc):
                    n_pdgid[ii] = t.m_pdgid[ii]
                    n_motheridx[ii] = t.m_motheridx[ii]
            else:
                n_run[0] = t.run
                n_event[0] = t.event
                h_trigger.Fill(t.raw_trigger.at(0))

            t_out.Fill()
            gam1_E.clear()
            gam2_E.clear()
            angle_gamgam.clear()
  
t_out.Write()
h_evtflw.Write()
h_mrec_gam1_d.Write()
h_mrec_gam1_n.Write()
h_mrec_gamgam_d.Write()
h_mrec_gamgam_n.Write()
h_Mgamgam_d.Write()
h_Mgamgam_n.Write()
h_gam1_costhe.Write()
h_gam1_E_d.Write()
h_gam1_E_n.Write()
h_gam2_E.Write()
h_gam2_costhe.Write()
h_ngam.Write()
h_chic2_1c_d.Write()
h_chic2_1c_n.Write()
h_angle_gamgam.Write()
h_trigger.Write()
fout.Close()
pbar.finish()
                
    
dur = duration(time()-time_start)
sys.stdout.write(' \nDone in %s. \n' % dur)
