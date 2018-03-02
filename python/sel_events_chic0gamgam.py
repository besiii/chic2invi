#!/usr/bin/env python

"""
Event Selection
"""

__author__="YANG Yuzhen <yangyz@ihep.ac.cn>"
__copyright__="Copyright (c) YANG Yuzhen"
__created__="[2018-1-29]"

import ROOT

#global histogram
h_ge = ROOT.TH1D('h_ge','h_ge',100,0,0.4)
h_ngam = ROOT.TH1D('h_ngam','ngam',100,0,20)

#global item
raw_ge = ROOT.vector('double')()
ngam=ROOT.vector('double')()

def main ():

    infile = 'run/chic0gamgam_mc_root/chic0gamgam.root'
    fin = ROOT.TFile(infile)
    t = fin.Get('tree')
    t.SetBranchAddress('raw_ge',raw_ge)
    t.SetBranchAddress('ngam',ngam)
    outfile = 'run/chic0gamgam_mc_root/chic0gamgam_ngam3.root'
    fout = ROOT.TFile(outfile,"RECREATE")
    t_out = ROOT.TTree('tree','tree')
    #mystruct = ROOT.MyTreeStruct()
    #t_out.Branch('raw_ge',raw_ge,'raw_ge/D')
    #t_out.Branch('ngam',ngam,'ngam/D')

    for k in range(6000):
        #t_out.Fill()       
        if t.ngam==3:
            h_ge.Fill(t.raw_ge)
            h_ngam.Fill(t.ngam)
    h_ge.Write()
    h_ngam.Write()    
    t_out.Write()
    fout.Close()

if __name__ =='__main__':
    main()