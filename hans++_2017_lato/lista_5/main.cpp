
#include "tree.h"


int main( int argc, char* argv [ ] )
{
   tree t1( string( "a" ));
   tree t2( string( "b" ));
   tree t3 = tree( string( "f" ), { t1, t2 } );

   std::vector< tree > arguments = { t1, t2, t3 };
   std::cout << tree( "F", std::move( arguments )) << "\n";
   std::cout << subst_new(t3, "b", t3) << "\n";
   tree t4= tree(t3);
   std::cout << t4 << " " << t3 << "\n";
   tree t5= t4;
   tree a(string("a"));
   tree f(string("f"), {a});
   std::cout << f << "\n";
   std::cout << t4 << "\n";
   for (size_t i=1; i<4; i++) {
     tree prew= t3;
     t3= subst_new(t3, "b", prew);
     std::cout << t3 << "\n";
   }
   t4= subst_new(t3, "ccc", t1);
   std::cout << t3.getaddress() << " " << t4.getaddress() << "\n";

}
