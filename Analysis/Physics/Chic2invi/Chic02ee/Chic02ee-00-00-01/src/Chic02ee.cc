// -*- C++ -*- //
//
// Description: chic02ee -> e+ e- 
//
// Original Author:  Amit pathak <amitraahul@itp.ac.cn>
//         Created:  [2018-07-25 Mon 16:30] 
//         Inspired by SHI Xin's code 
//         Helped by maoqiang
//


//
// system include files
//


#include "GaudiKernel/Algorithm.h"
#include "GaudiKernel/DeclareFactoryEntries.h"
#include "GaudiKernel/LoadFactoryEntries.h"
#include "GaudiKernel/NTuple.h"
#include "GaudiKernel/Bootstrap.h"

#include "EvtRecEvent/EvtRecEvent.h"
#include "EvtRecEvent/EvtRecTrack.h"

#include "EventModel/EventHeader.h"
#include "EventModel/EventModel.h"
#include "EventModel/Event.h"
#include "TrigEvent/TrigEvent.h"
#include "TrigEvent/TrigData.h"

#include "CLHEP/Vector/ThreeVector.h"

#include "DstEvent/TofHitStatus.h"

#include "VertexFit/IVertexDbSvc.h"
#include "VertexFit/Helix.h"
#include "VertexFit/WTrackParameter.h"
#include "VertexFit/VertexFit.h"

#include "ParticleID/ParticleID.h"
#include "McTruth/McParticle.h"

#include "VertexFit/KalmanKinematicFit.h"

#include <TFile.h>
#include <TH1.h>
#include <TTree.h>
//
// class declaration //
//

class Chic02ee : public Algorithm {
  
public:
  Chic02ee(const std::string&, ISvcLocator*);
  ~Chic02ee(); 
  StatusCode initialize();
  StatusCode execute();
  StatusCode finalize();

private:
}; 


//define Trees
TTree* m_trees;

//common info
int m_run;
int m_event;



DECLARE_ALGORITHM_FACTORY( Chic02ee )
DECLARE_FACTORY_ENTRIES( Chic02ee ) {
  DECLARE_ALGORITHM(Chic02ee);
}

LOAD_FACTORY_ENTRIES( Chic02ee )

Chic02ee::Chic02ee(const std::string& name, ISvcLocator* pSvcLocator) :
  Algorithm(name, pSvcLocator)
{
}



StatusCode Chic02ee::initialize(){ MsgStream log(msgSvc(), name());
  return StatusCode::SUCCESS;
}


StatusCode Chic02ee::execute() {

m_run = eventHeader->runNumber();
m_event = eventHeader->eventNumber();


return StatusCode::SUCCESS; 
}

StatusCode Chic02ee::finalize() {
  return StatusCode::SUCCESS;
}


Chic02ee::~Chic02ee() {
}

void Chic02ee::book_tree(){
m_tree=new TTree("tree", "Chic02ee");
if (!m_tree) return;

// common info
m_tree->Branch("run",&m_run,"run/I");
m_tree->Branch("event",&m_event,"event/I");

}

void Chic02ee::clearVariables(){
m_run=0;
m_event=0;
}

