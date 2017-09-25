#include <bits/stdc++.h>
using namespace std;

long long pot(long long n, long long x) {
  long long res=1;
  for (int i=1; i<=n; i++) res*=x;
  return res;
}

int tab[1000];

void wypisz_klauzule(char znak, int k) {
  for (int i=1; i<=k; i++) {
    if (rand()%2==1) tab[i]=true;
    else tab[i]=false;
  }
  for (int i=1; i<=k; i++) {
    if (tab[i]==false) printf ("~");
    printf("%c%d", znak, i);
    if (i!=k) printf (" v ");
  }
}

int main (int argc, char* argv[]) {
  srand(atoi(argv[1]));
  int n, k;
  scanf("%d%d", &n, &k);
  for (int i=1; i<=n; i++ ) {
    if (rand()%2==1) tab[i]=true;
  }
  printf( "tests(per, performance, [");
  for (int i=1; i<=n; i++) {
    char znak= 'a'+i-1;
    wypisz_klauzule(znak, k);
    if (i!=n) printf (", ");
  }
  printf("], 1000, count(");
  long long ile=pot(k, 2)-1;
  long long res=pot(n, ile);
  printf ("%lld)).", res);
}
