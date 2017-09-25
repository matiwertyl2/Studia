#include <cmath>
#include "fifteen.h"


fifteen::fifteen( ) {
  for (size_t i=0; i<dimension; i++) {
    for (size_t j=0; j<dimension; j++) {
      table[i][j]=i*dimension+j+1;
      if (table[i][j]==dimension*dimension) table[i][j]=0;
    }
  }
  open_i=dimension-1;
  open_j=dimension-1;
}

fifteen::fifteen( std::initializer_list< std::initializer_list< size_t >> init ) {
  size_t i=0;
  for (auto list : init) {
    size_t j = 0;
    for( auto p : list) {
      table[i][j]=p;
      if (p==0) {
        open_i=i;
        open_j=j;
      }
      j++;
    }
    i++;
  }
}

std::ostream& operator << ( std::ostream& stream, const fifteen& f ) {
  for (size_t i=0; i<f.dimension; i++) {
    for (size_t j=0; j<f.dimension; j++) {
      stream << std::setw(3) << f.table[i][j];
    }
    stream << "\n";
  }
  return stream;
}


fifteen::position fifteen::solvedposition(size_t value) {
  if (value==0) return {dimension-1, dimension-1};
  size_t row= value/dimension;
  if (value % dimension==0) row--;
  size_t column=(value-1) % dimension;
  return {row, column};

}

size_t fifteen::hashvalue () const  {
  size_t h=0, mod=1234567891, p=91, p0=91;
  for (size_t i=0; i<dimension; i++) {
    for (size_t j=0; j<dimension; j++) {
      h= (h+ table[i][j]*p) % mod;
      if (h>=mod) h%=mod;
      p*=p0;
      if (p>=mod) p%=mod;
    }
  }
  return h;
}

bool fifteen::equals( const fifteen& other ) const {
  for (size_t i=0; i<dimension; i++) {
    for (size_t j=0; j<dimension; j++) {
      if (table[i][j]!=other.table[i][j]) return false;
    }
  }
  return true;
}

void fifteen::makemove(move m) {
  switch(m)
  {
  case move::up :
    if (open_i==0) throw illegalmove(m);
    std::swap(table[open_i][open_j], table[open_i-1][open_j]);
    open_i--;
    break;
  case move::left :
    if (open_j==0) throw illegalmove(m);
    std::swap(table[open_i][open_j], table[open_i][open_j-1]);
    open_j--;
    break;
  case move::right:
    if (open_j+1==dimension) throw illegalmove(m);
    std::swap(table[open_i][open_j], table[open_i][open_j+1]);
    open_j++;
    break;
  case move::down :
    if (open_i+1==dimension) throw illegalmove(m);
    std::swap(table[open_i][open_j], table[open_i+1][open_j]);
    open_i++;
    break;
  }
}

bool fifteen::issolved() const {
  for (size_t i=0; i<dimension; i++) {
    for (size_t j=0; j<dimension; j++) {
      fifteen::position p= solvedposition(table[i][j]);
      if (p.first!=i || p.second!=j) return false;
    }
  }
  return true;
}

size_t fifteen::distance( ) const {
  size_t dist=0;
  for (size_t i=0; i<dimension; i++) {
    for (size_t j=0; j<dimension; j++) {
      fifteen::position p= solvedposition(table[i][j]);
      dist+= abs(i-p.first)+ abs(j-p.second);
    }
  }
  return dist;
}
