
#include <fstream>
#include <iostream>
#include <random>

#include "listtest.h"
#include "vectortest.h"
#include "timer.h"


int main( int argc, char* argv [] )
{

  std::vector< std::string > vect;
  std::ifstream input{"test.txt"};
  vect= vectortest::readfile(input);
  std::cout << vect << "\n";
  std::list< std::string> L={"ala", "ma", "kota"};
  std::cout << L << "\n";
  std::vector < std::string > V1= vectortest::randomstrings(20000, 50);
  std::vector <std::string> V2= V1;
  std::vector <std:: string> V3=V1;
  std::list<std::string> L1= listtest::vector_to_list(V1);
  std::list<std::string> L2=L1;
  { timer t( "sort_assign", std::cout );
    vectortest::sort_assign(V1);
  };
  { timer t( "sort_move", std::cout );
    vectortest::sort_move(V2);
  };
  { timer t( "sort_std", std::cout );
    vectortest::sort_std(V3);
  };
  std::cout << "=================================\n";
  { timer t( "sort_assign", std::cout );
    listtest::sort_assign(L1);
  };
  { timer t( "sort_move", std::cout );
    listtest::sort_move(L2);
  };
   return 0;
}
