#!/usr/bin/env python

"""
Event Selection
"""

__author__="AMIT PATHAK <amit@ihep.ac.cn>"
__copyright__="Copyright (c) AMIT PATHAK"
__created__="[2018-12-17]"
import sys
import ROOT
from progressbar import Bar, Percentage, ProgressBar
from time import time
from tools import duration

#global histogram
h_run = ROOT.TH1D('h_run','run',100, -27120, -25330)
h_event = ROOT.TH1D('h_event', 'event', 100, 0, 20 )
h_indexmc = ROOT.TH1D('h_indexmc', 'indexmc',100, 5, 15 )
h_ncharged = ROOT.TH1D('h_ncharged', 'ncharged', 100, 1, 5)
h_ngoodcharged = ROOT.TH1D('h_ngoodcharged', 'ngoodcharged',100, 1, 4)
h_ngoodneutral = ROOT.TH1D('h_ngoodneutral', 'ngoodneutral',100, 1, 5)
h_nlepton = ROOT.TH1D('h_nlepton', 'nlepton',100, 1, 5)
h_nneutral = ROOT.TH1D('h_nneutral', 'nneutral',100, 1.5, 10)
h_inv_mass_electron = ROOT.TH1D('h_inv_mass_electron','mass_electron(GeV)',100,0,0.001)
#h_transverse_momentum = ROOT.TH1D('h_transverse_momentum', 'transverse_momentum',100, 0, 5)


def main ():

    infile = 'dat/chi2gll_gen_mc.root'
    fin = ROOT.TFile(infile)
    t = fin.Get('ana')
    outfile = 'dat/chi2gll_selection_001.root'
    fout = ROOT.TFile(outfile,"RECREATE")
    entries = t.GetEntriesFast()
    pbar = ProgressBar(widgets=[Percentage(), Bar()], maxval=entries).start()
    time_start = time()

    for k in range(entries):
    
        pbar.update(k+1)
        t.GetEntry(k)
        h_run.Fill(t.run)
        h_event.Fill(t.event)
        h_ncharged.Fill(t.ncharged)
        h_ngoodcharged.Fill(t.ngoodcharged)
        h_ngoodneutral.Fill(t.ngoodneutral)
        h_nlepton.Fill(t.nlepton)
        h_nneutral.Fill(t.nneutral)
        #h_inv_mass_electron.Fill(t.inv_mass_electron)
        #h_transverse_momentum.Fill(t.transverse_momentum)

        p4trk_lep1 = ROOT.TLorentzVector(t.p4trk[0],t.p4trk[1],t.p4trk[2],t.p4trk[3])
        inv_mass_electron = p4trk_lep1.M()
        h_inv_mass_electron.Fill(inv_mass_electron)
        #transverse_momentum = p4trk_lep1.Perp()
        
        #print(inv_mass_electron)
        #print(transverse_momentum)
        #print(p4trk_lep1, p4trk_lep1[0])
        
        
    h_run.Write()
    h_event.Write()
    h_indexmc.Write()
    h_ncharged.Write()
    h_ngoodcharged.Write()
    h_ngoodneutral.Write()
    h_nlepton.Write()
    h_nneutral.Write()
    h_inv_mass_electron.Write()
    #h_transverse_momentum.Write()



    fout.Close()
    pbar.finish()
    dur = duration(time()-time_start)
    sys.stdout.write(' \nDone in %s. \n' % dur)

if __name__ =='__main__':
    main()