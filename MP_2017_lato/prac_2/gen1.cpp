#include <bits/stdc++.h>
using namespace std;

void clause(int mask, int n) {
  for (int i=0; i<n; i++ ) {
    if ((mask & (1<<i))==(1<<i)) printf("~");
    printf ("p%d", i);
    if (i!=n-1) printf (" v ");
  }
}

int main () {
  int n;
  scanf("%d", &n);
  printf ("prove_tests(sat_, performance, [");
  for (int i=0; i<(1<<n); i++) {
    clause(i, n);
    if (i!=(1<<n)-1) printf(", ");
  }
  printf ("], unsat).\n");
}
