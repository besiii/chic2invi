#ifndef Physics_Analysis_GammaConv_H
#define Physics_Analysis_GammaConv_H

#include "VertexFit/HTrackParameter.h"
#include "VertexFit/WTrackParameter.h"
#include "CLHEP/Matrix/Vector.h"
using CLHEP::HepVector;
#ifndef CLHEP_THREEVECTOR_H
#include "CLHEP/Vector/ThreeVector.h"
using CLHEP::Hep3Vector;
#endif
#include "CLHEP/Vector/LorentzVector.h"
using CLHEP::HepLorentzVector;
#ifndef CLHEP_POINT3D_H
#include "CLHEP/Geometry/Point3D.h"
#ifndef ENABLE_BACKWARDS_COMPATIBILITY
   typedef HepGeom::Point3D<double> HepPoint3D;
#endif
#endif

class GammaConv
{

public:

  GammaConv(HepVector helixp, HepVector helixe, HepPoint3D ip);
  ~GammaConv();

public:
  //get the four parameters
  double getLenthep() {return m_lenthep;} //add on 2011.5.20
  double getSumrerp() {return m_sumrerp;} //add on 2011.5.20
  double getDeltaXY() {return m_deltaxy;}
  double getDeltaZ()  {return m_deltaz;}
  double getDGamma()  {return m_dgamma;}
  double getRX() {return m_rx;}
  double getRY() {return m_ry;}
  double getRZ() {return m_rz;}
  double getRXY(){return m_rxy;}
  double getR()  {return m_R;}
  double getCthe() {return m_cthe;}
  void GetCoordi(HepPoint3D &coordip, HepPoint3D &coordie);
  HepPoint3D getXv() {return m_xv;}
  void getPhi0(double &phi0p, double &phi0e){ phi0p = m_phi0p; phi0e = m_phi0e; }
  void getTheta0(double &theta0p, double &theta0e){ theta0p = m_theta0p; theta0e = m_theta0e; }
  double getDeltaphi0() {return m_deltaphi0;}
  double getDeltatheta0() {return m_deltatheta0;}
  double getXiep() {return m_xiep;}
  double getPsipair() {return m_psipair;}
  HepPoint3D center(HepVector helix);
  double radius(HepVector helix);
private:
  void DeltaXY(HepVector helixp, HepVector helixe);
  void DeltaZ(HepVector helixp, HepVector helixe);
  void DGamma(HepVector helixp, HepVector helixe, HepPoint3D ip);
  void GGeom(HepPoint3D ip);
  void Deltaphitheta(HepVector helixp, HepVector helixe);
  Hep3Vector p3(HepVector helix);
  HepPoint3D x3(HepVector helix);
private:
  double m_lenthep;//add on 2011.5.20
  double m_sumrerp;//for re + rp ,add on 2011.5.20
  double m_deltaxy;
  double m_deltaz;
  double m_dgamma;
  double m_rx;
  double m_ry;
  double m_rz;
  double m_rxy;
  double m_R;
  double m_cthe; 
  HepPoint3D _coordip, _coordie;
  HepPoint3D m_xv;
  double m_phi0p;
  double m_phi0e;
  double m_theta0p;
  double m_theta0e;
  double m_deltaphi0;
  double m_deltatheta0;
  double m_xiep;
  double m_psipair;
};
#endif
