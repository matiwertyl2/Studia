#include <stdio.h>

int tab[10000];
int res=0;
int x, d , n;


int max (int a, int b) {
  if (a>b) return a;
  return b;
}

int min (int a, int b) {
  if (a<b) return a;
  else return b;
}

void f (int pos, int mini, int maks, int sum) {
    if (sum<=x) {
      if (sum==x && pos==n+1 && maks-mini<=d ) {
	res++;
      // printf ("%d %d %d\n", mini, maks, sum);
      }
      if (pos<=n) {
	for (int i=0; i<=x; i++) {
	  //printf ("rekur %d %d %d %d\n", pos+1, min (mini, i), max (maks, i), sum+i*tab[pos]);
	  f (pos+1, min (mini, i), max (maks, i), sum+i*tab[pos]);
	}
      }
    }
}

int main () {
  scanf ("%d%d%d", &x, &d, &n);
  for (int i=1; i<=n; i++) {
    scanf ("%d", &tab[i]);
  }
  f (1, 1000000, 0, 0);
  printf ("%d\n", res);
}