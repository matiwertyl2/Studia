#include <bits/stdc++.h>
using namespace std;

void clause(long long n) {
  for (int i=0; i<n; i++) {
    printf("~p%d v ", i);
  }
  printf ("p%lld", n);
}

int main () {
  long long n;
  scanf("%lld", &n);
  printf ("prove_tests(sat_, performance, [");
  for (long long i=0; i<n; i++) {
    clause(i);
    printf(", ");
  }
  printf("~p%lld", n-1);
  printf ("], unsat).\n");
}
