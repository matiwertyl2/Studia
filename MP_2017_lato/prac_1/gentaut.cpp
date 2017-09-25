#include <bits/stdc++.h>
using namespace std;

long long pot (long long base, long long n) {
  long long res=1;
  for (int i=1; i<=n; i++) res*=base;
  return res;
}

int main() {
  int n, k;
  scanf("%d%d", &n, &k);
  printf("tests( per, performance, [");
  for (int i=1; i<=n; i++) {
    printf ("p%d v ~p%d", i, i);
    if (i!=n || k!=0) printf (", ");
  }
  for (int i=1; i<=k; i++) {
    printf("q%d", i);
    if (i!=k) printf(", ");
  }
  long long c= pot(2, n);
  printf ("], 10000, count(%lld)).", c);
}
