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
from tools import duration, check_outfile_path

#global histogram
h_run = ROOT.TH1D('h_run','run',100, -27120, -25330)
h_event = ROOT.TH1D('h_event', 'event', 100, 0, 20 )
h_indexmc = ROOT.TH1D('h_indexmc', 'indexmc',100, 5, 15 )
h_ncharged = ROOT.TH1D('h_ncharged', 'ncharged', 100, 1, 5)
h_ngoodcharged = ROOT.TH1D('h_ngoodcharged', 'ngoodcharged',100, 1, 4)
h_ngoodneutral = ROOT.TH1D('h_ngoodneutral', 'ngoodneutral',100, 1, 5)
h_nlepton = ROOT.TH1D('h_nlepton', 'nlepton',100, 1, 5)
h_nneutral = ROOT.TH1D('h_nneutral', 'nneutral',100, 1.5, 10)
h_inv_mass_electron1 = ROOT.TH1D('h_inv_mass_electron1', 'mass_electron1(GeV)',100,0, 0.001)
h_inv_mass_electron2 = ROOT.TH1D('h_inv_mass_electron2', 'mass_electron2(GeV)',100,0, 0.001)
h_inv_mass_electron12 = ROOT.TH1D('h_inv_mass_electron12', 'mass_electron12(GeV)',100,-1, 4)
h_transverse_momentum1 = ROOT.TH1D('h_transverse_momentum1', 'transverse_momentum1',100, -1, 2)
h_transverse_momentum2 = ROOT.TH1D('h_transverse_momentum2', 'transverse_momentum2',100, -1, 2)
h_transverse_momentum12 = ROOT.TH1D('h_transverse_momentum12', 'transverse_momentum12',100, -1, 2)
h_inv_mass_gam1 = ROOT.TH1D ('h_inv_mass_gam1','inv_mass_gam1',100, -0.1, 0.1)
h_inv_mass_gam2 = ROOT.TH1D ('h_inv_mass_gam2','inv_mass_gam2',100, -0.1, 0.1)
h_inv_mass_chicj = ROOT.TH1D ('h_inv_mass_chicj','inv_mass_chicj',100, 0,5)
h_rec_mass_gam12 = ROOT.TH1D('h_rec_mass_gam12', 'rec_mass_gam12',100, -0.5, 3)
h_energy_gamma1 = ROOT.TH1D('h_energy_gamma1', 'energy_gamma1', 100, 0, 2)
h_energy_gamma2 = ROOT.TH1D('h_energy_gamma2', 'energy_gamma2', 100, 0, 1)

def main ():

    args = sys.argv[1:]

    if (len(args) < 2):
        print 'input error'



    infile = args[0]
    outfile = args[1]
    check_outfile_path(outfile)

    #infile = 'dat.bak/chi2gll_gen_mc.root'
    fin = ROOT.TFile(infile)
    t = fin.Get('ana')
    #outfile = 'dat.bak/chi2gll_selection_001.root'
    fout = ROOT.TFile(outfile,"RECREATE")
    entries = t.GetEntriesFast()
    pbar = ProgressBar(widgets=[Percentage(), Bar()], maxval=entries).start()
    time_start = time()

    for k in range(entries):
    
        pbar.update(k+1)
        t.GetEntry(k)
        #if not (t.ncharged == 2 and t.ngoodcharged == 2 and t.nlepton == 2):
            #continue
        h_run.Fill(t.run)
        h_event.Fill(t.event)
        h_ncharged.Fill(t.ncharged)
        h_ngoodcharged.Fill(t.ngoodcharged)
        h_ngoodneutral.Fill(t.ngoodneutral)
        h_nlepton.Fill(t.nlepton)
        h_nneutral.Fill(t.nneutral)

        #h_inv_mass_electron.Fill(t.inv_mass_electron)
        #h_transverse_momentum.Fill(t.transverse_momentum)
        for elements in t.p4trk:
            print('>>>>>', t.p4trk[5])
            print('0:electron, 1:muon, 2:pion, 3:kaon, 4:proton')

        p4trk_lep1 = ROOT.TLorentzVector(t.p4trk[0],t.p4trk[1],t.p4trk[2],t.p4trk[3])
        p4trk_lep2 = ROOT.TLorentzVector(t.p4trk[10],t.p4trk[11],t.p4trk[12],t.p4trk[13])
        p4trk_lep12 = p4trk_lep1 + p4trk_lep2

        inv_mass_electron1 = p4trk_lep1.M()
        inv_mass_electron2 = p4trk_lep2.M()
        inv_mass_electron12 = p4trk_lep12.M()

        h_inv_mass_electron1.Fill(inv_mass_electron1)
        h_inv_mass_electron2.Fill(inv_mass_electron2)
        h_inv_mass_electron12.Fill(inv_mass_electron12)
        
        transverse_momentum1 = p4trk_lep1.Perp()
        transverse_momentum2 = p4trk_lep2.Perp()
        transverse_momentum12 = p4trk_lep12.Perp()

        h_transverse_momentum1.Fill(transverse_momentum1)
        h_transverse_momentum2.Fill(transverse_momentum2)
        h_transverse_momentum12.Fill(transverse_momentum12)
        

        p4shw_gam1 = ROOT.TLorentzVector(t.p4shw[0],t.p4shw[1],t.p4shw[2],t.p4shw[3])
        p4shw_gam2 = ROOT.TLorentzVector(t.p4shw[4],t.p4shw[5],t.p4shw[6],t.p4shw[7])

        energy_gamma1 = p4shw_gam1.E()
        energy_gamma2 = p4shw_gam2.E()
        
        h_energy_gamma1.Fill(energy_gamma1)
        h_energy_gamma2.Fill(energy_gamma2)
                
        #mass of chicj reconstruction by adding e+ , e- and gamma from the final state
        p4_chicj = p4trk_lep12 + p4shw_gam1
        inv_mass_chicj = p4_chicj.M()
        h_inv_mass_chicj.Fill(inv_mass_chicj)

        inv_mass_gam1 = p4shw_gam1.M()
        inv_mass_gam2 = p4shw_gam2.M()
        p4shw_gam12 = p4shw_gam1 + p4shw_gam2
        rec_mass_gam12 = p4shw_gam12.M()
        
        h_inv_mass_gam1.Fill(inv_mass_gam1)
        h_inv_mass_gam2.Fill(inv_mass_gam2)
        h_rec_mass_gam12.Fill(rec_mass_gam12)

        #print(p4shw_gam1, p4shw_gam1[3])
        #exit()

        #print(p4trk_lep1, p4trk_lep1[0])
        
        
    h_run.Write()
    h_event.Write()
    h_indexmc.Write()
    h_ncharged.Write()
    h_ngoodcharged.Write()
    h_ngoodneutral.Write()
    h_nlepton.Write()
    h_nneutral.Write()
    h_inv_mass_electron1.Write()
    h_inv_mass_electron2.Write()
    h_inv_mass_electron12.Write()
    h_transverse_momentum1.Write()
    h_transverse_momentum2.Write()
    h_transverse_momentum12.Write()
    h_inv_mass_gam1.Write()
    h_inv_mass_gam2.Write()
    h_inv_mass_chicj.Write()
    h_rec_mass_gam12.Write()
    h_energy_gamma1.Write()
    h_energy_gamma2.Write()

    fout.Close()
    pbar.finish()
    dur = duration(time()-time_start)
    sys.stdout.write(' \nDone in %s. \n' % dur)

if __name__ =='__main__':
    main()