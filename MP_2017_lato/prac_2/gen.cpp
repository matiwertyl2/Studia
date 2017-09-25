#include <bits/stdc++.h>
using namespace std;


int main () {
  int n;
  scanf("%d", &n);
  printf("prove_tests(singletons1, performance, [");

  for (int i=1; i<=n; i++){
    printf ("~p%d, ", i);
  }
  for (int i=1; i<=n; i++) {
    printf ("p%d", i);
    if (i!=n) printf(" v ");
  }
  printf("] , unsat).\n");
}
