
#include "powerproduct.h"
#include <algorithm>


std::ostream& operator << ( std::ostream& out, const powvar & p )
{
   if( p.n == 0 )
   {
      out << "1"; // Should not happen, but we still have to print something.
      return out;
   }

   out << p.v;
   if( p.n == 1 )
      return out;

   if( p.n > 0 )
      out << "^" << p.n;
   else
      out << "^{" << p.n << "}";
   return out;
}


std::ostream& operator << ( std::ostream& out, const powerproduct& c )
{
   if( c. isunit( ))
   {
      out << "1";
      return out;
   }

   for( auto p = c. repr. begin( ); p != c. repr. end( ); ++ p )
   {
      if( p != c. repr. begin( ))
         out << ".";
      out << *p;
   }

   return out;
}


int powerproduct::power( ) const
{
   int p = 0;
   for( auto pv : repr )
      p += pv. n;
   return p;
}


bool powvar_cmp (powvar a, powvar b) {
  if (a.v < b.v ) return true;
  return false;
}

void powerproduct::normalize() {
  sort(repr.begin(), repr.end(), powvar_cmp);
  std::vector <powvar> V;
  V.clear();
  if (repr.size()>0) {
    int pos=repr.size()-2;
    std::string var=repr[repr.size()-1].v;
    int p= repr[repr.size()-1].n;
    while (pos>=0) {
      if (repr[pos].v==var) {
        p+=repr[pos].n;
        repr.pop_back();
        pos--;
      }
      else {
        if (p!=0) V.push_back (powvar(var, p));
        var=repr[pos].v;
        p=repr[pos].n;
        repr.pop_back();
        pos--;
      }
    }
    repr.clear();
    if (p!=0) V.push_back (powvar(var, p));
    for (int i=(V.size()-1); i>=0; i--) {
      repr.push_back(V[i]);
    }
  }
}


powerproduct operator * ( powerproduct c1, const powerproduct& c2 ) {
  powerproduct r;
  for (size_t i=0; i<c1.repr.size(); i++) r.repr.push_back(c1.repr[i]);
  for (size_t i=0; i<c2.repr.size(); i++) r.repr.push_back (c2.repr[i]);
  r.normalize();
  return r;
}
