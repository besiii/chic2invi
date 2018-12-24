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
        


    h_run.Write()
    h_event.Write()
    h_indexmc.Write()
    h_ncharged.Write()
    h_ngoodcharged.Write()
    h_ngoodneutral.Write()
    h_nlepton.Write()
    h_nneutral.Write()
    
    fout.Close()
    pbar.finish()
    dur = duration(time()-time_start)
    sys.stdout.write(' \nDone in %s. \n' % dur)

if __name__ =='__main__':
    main()