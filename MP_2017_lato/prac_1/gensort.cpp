#include <bits/stdc++.h>
using namespace std;

long long pot (long long base, long long n) {
  long long res=1;
  for (int i=1; i<=n; i++) res*=base;
  return res;
}

int main() {
  int n, k;
  scanf("%d", &n);
  printf("tests( per, performance, [");

  for (int i=1; i<=n; i++) {
    printf ("p%d v p%d v p%d v q", 3*i, 3*i+1, 3*i+2);
     printf (", ");
  }
  printf("q ");
  long long c= pot(2, n+2);
  printf ("], 10000, count(%lld)).", c);
}
