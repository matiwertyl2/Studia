
#include <iostream>

#include "units.h"

// Useful if you want to compute the yield of an atomic bomb:

const auto c= 300000.0_km / 1.0_sec;
const auto tnt = 4184.0_joule / 0.001_kg;


#if 1
quantity::energy mc2( quantity::mass m )
{
   auto C = 299792458.0_mps;
   return m * C * C;
}
#endif


int main( int argc, char* argv [ ] )
{

  std::cout << 1.0_m << "\n";
  std::cout << 1.0_m * 2.0_m << "\n";
  std::cout << 9.81 * 1.0_m / ( 1.0_sec * 1.0_sec ) << "\n";
  std::cout << "Battery ENERGY " << 1.2_V * 0.008_A * 1.0_hr << "\n";
  si<0, 1, -1, 0> V1= 100.0_km / 1.0_hr;
  si<0, 1, -1, 0> V2 = 30.0_km / 1.0_hr;
  std::cout << "CAR KINETIC ENERGY " << V1*V1 * 1200.0_kg /2 << "\n";
  std::cout << "SPEED NORMAL " << (V1+V2) << "\n";
  std::cout << "SPEED RELATIVISTIC " << (V1+V2)/(1+ V1*V2/(c*c)) << "\n";
  std::cout << "TSAR BOMB ENERGY " << mc2(2.3_kg) << "\n";
  std::cout << "MASS OF TNT-equivalent " << mc2(2.3_kg) / tnt << "\n";

  // std::cout << 1.0_m << "\n";
   //std::cout << 2.0_hr << "\n";

//   std::cout << 1000.0_watt << "\n";

   return 0;

}
