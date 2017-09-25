
#include "powerproduct.h"
#include "polynomial.h"
#include "bigint.h"
#include "rational.h"


template< typename N >
polynomial< N > exptaylor( unsigned int n )
{
   powerproduct v;

   N fact = 1;

   polynomial< N > result;
   for( unsigned int i = 0; i < n; ++ i )
   {
      result[v] += fact;
      v = v * powvar( "x" );
      fact = fact / (i+1);
   }

   return result;
}

rational powder(rational r, int n) {
  rational res(1);
  for (int i=1; i<=n; i++) res*=r;
  return res;
}

rational evaluate (polynomial<rational> p, rational c) {
  rational r;
  for (auto m : p.repr) {
    powerproduct prod= m.first;
    if (prod.repr.size()==0) r+=m.second;
    else {
      r+= m.second*powder (c, prod.repr[0].n);
    }
  }
  return r;
}

bigint decimal (rational r) {
  return r.num*1000/r.denum;
}

int main( int argc, char* argv [] )
{
   polynomial< rational > pol;

   int N = 50;

   pol[ { } ] = 1;
   pol[ { "x" } ] = rational( 1, N );

   powerproduct x("x", 1);
   polynomial<int> test1(x);
   test1+=1;
   std::cout << test1*test1*test1*test1*test1 << "\n";

   powerproduct t2({powvar("x", 2), powvar("z", 3), powvar("y", 1)});
   polynomial<int> test2(t2);
   test2+=1;
   std::cout << test2*test2*test2*test2 << "\n";

   powerproduct t3({powvar("x", 1), powvar("y", 1)});
   polynomial<int> test3(t3);
   test3+=3;
   std::cout << test3*test3*test3*test3*test3*test3 << "\n";

   std::cout << "\n\n............................\n\n";

   polynomial< rational > res = 1;

   for( int i = 0; i < N; ++ i )
      res = res * pol;

   std::cout << "rsult = " << res << "\n";

   std::cout << " taylor expansion = " << exptaylor<rational>(20) << "\n";

   std::cout << "difference = " ;
   std::cout << res - exptaylor<rational> ( 40 ) << "\n";
   std::cout << decimal(evaluate(res-exptaylor<rational>(50), 1)) << "/1000" <<  "\n";
   return 0;
}
