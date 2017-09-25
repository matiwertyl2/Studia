
#include "listtest.h"

#include <random>
#include <chrono>
#include <algorithm>
#include<vector>

void listtest::sort_assign( std::list< std::string> & L) {
  for( auto p=L.begin(); p!=L.end(); ++p )
    for( auto q= L.begin(); q!=p; ++q )  {
        if( *q > *p ) {
          std::string s = *q;
          *q = *p;
          *p = s;
        }
    }
}

void listtest::sort_move( std::list< std::string > & L ) {
  for( auto p=L.begin(); p!=L.end(); ++p ) {
    for( auto q=L.begin(); q!=p; ++q ) {
      if( *q > *p )  std::swap( *q, *p );
    }
  }
}

std::ostream& operator << ( std::ostream& stream , const std::list< std::string > & L) {
  for (auto x : L) stream << x << " ";
  return stream;
}

std::list<std::string> listtest::vector_to_list(const std::vector<std::string> & v ) {
  std::list<std::string> L;
  for (auto x : v) L.push_front(x);
  return L;
}
