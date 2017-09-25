#include <limits.h>
#include <stdio.h>
#include <stdbool.h>

#define bitow_w_int (CHAR_BIT * sizeof (unsigned int))

typedef unsigned int zbior[100];

int main () {
  printf ("%lu\n", bitow_w_int );
  printf ("%d\n", CHAR_BIT );
  printf ("%lu\n", sizeof (unsigned int));
  int a= 1 << 10 % 10;
  printf ("%d\n", a);
  zbior x;
  for (int i=0; i<100; i++) x[i]=i;
  for (int i=0; i<100; i++) printf ("%d\n", x[i]);
}