#include <bits/stdc++.h>
using namespace std;



int main () {
  double dx = 0.0000000000001;
  double x=1;
  while (x<2) {
    x+=dx;
    if (x * (1 / x) != 1) {
      printf ("%.25lf\n", x);
      break;
    }
  }
}
