#!/usr/bin/env python

"""
Event Selection
"""

__author__="AMIT PATHAK <amit@ihep.ac.cn>"
__copyright__="Copyright (c) AMIT PATHAK"
__created__="[2018-12-17]"

import ROOT

#global histogram
h_ncharged = ROOT.TH1D('h_ncharged','h_ncharged',100,0,5)

#global item
ncharged = ROOT.vector('double')()

def main ():

    infile = '../scripts/chic02ee/rootfile_chic02ee/chi2gll_gen_mc.root'
    fin = ROOT.TFile(infile)
    t = fin.Get('ana')
    t.SetBranchAddress('ncharged',ncharged)
    outfile = '../scripts/chic02ee/rootfile_chic02ee/chi2gll_selection_001.root'
    fout = ROOT.TFile(outfile,"RECREATE")
    t_out = ROOT.TTree('ana','ana')
    #mystruct = ROOT.MyTreeStruct()
    t_out.Branch('ncharged',ncharged,'ncharged/D')

    for k in range(6000):

        h_ncharged.Fill(t.ncharged)
    
    h_ncharged.Write()
    t_out.Write()
    fout.Close()

if __name__ =='__main__':
    main()
