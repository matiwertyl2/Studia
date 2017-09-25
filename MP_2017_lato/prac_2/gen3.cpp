#include <bits/stdc++.h>
using namespace std;

bool tab[100];

void clause( int d, int n) {
  int ile=0;
  for (int i=1; i<=n; i++) tab[i]=false;
  while (ile!=d) {
    for (int i=1; i<=n; i++) {
      int ok=rand() % 5;
      if (ok==1 && tab[i]==false) {
        tab[i]=true;
        ile++;
      }
      if (ile==d) break;
    }
  }
  int last=0;
  for (int i=1; i<=n; i++) {
    if (tab[i]==true) last=i;
  }
  for (int i=1; i<=n; i++) {
    if (tab[i]==true) {
      bool neg = rand() % 2;
      if (neg==true) printf ("~");
      printf ("p%d", i);
      if (i!=last) printf (" v ");
    }
  }
}

int main (int argc, char* argv[]) {
  srand(atoi(argv[1]));
  int n;
  scanf("%d", &n);
  printf("prove_tests(random, performance, [");
  int mod=(1<<n);
  int k= rand() % (mod/2);
  for (int i=1; i<=n; i++) {
    printf ("p%d", i);
    if (i!=n) printf(" v ");
  }
  printf (", ");
  for (int i=1; i<k; i++) {
    int d= 4 + rand() %(n-6);
    clause(d, n);
    if (i!=k-1) printf (", ");
  }

  printf("], unsat).\n");
}
