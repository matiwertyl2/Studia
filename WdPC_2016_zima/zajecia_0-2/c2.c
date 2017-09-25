#include <stdio.h>

int main () {
  int n;
  scanf ("%d", &n);
  if (n==1) printf ("1^1\n");
  else if (n==0) printf ("0^1\n");
  else {
   int bylo=0;
   int i=2;
   while (i*i<=n) {
     int pot=0;
     while (n % i ==0) {
       pot++;
       n/=i;
     }
     if (pot>0) {
      if (bylo==1) printf ("*");
      bylo=1;
      printf ("%d^%d", i, pot);
     }
     if (n==1) break;
     i++;
   }
   if (n>1) {
     if (bylo==1) printf ("*");
     printf ("%d^1", n);
   }
   printf ("\n");
    
  }
}