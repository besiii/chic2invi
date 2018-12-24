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
    
    h_run.Write()
    fout.Close()
    pbar.finish()
    dur = duration(time()-time_start)
    sys.stdout.write(' \nDone in %s. \n' % dur)

if __name__ =='__main__':
    main()