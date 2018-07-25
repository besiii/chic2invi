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

class Chic02ee : public Algorithm {
  
public:
  Chic02ee(const std::string&, ISvcLocator*);
  ~Chic02ee(); 
  StatusCode initialize();
  StatusCode execute();
  StatusCode finalize();

private:
}; 

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
return StatusCode::SUCCESS; 
}

StatusCode Chic02ee::finalize() {
  return StatusCode::SUCCESS;
}


Chic02ee::~Chic02ee() {
}

