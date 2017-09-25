#include <stdio.h>
#include <stdlib.h>
#include "zespolone.h"

int main () {
  Zespolone * X;
  Zespolone * Y;
  int n=0;
  double a1, a2, b1, b2;
  char znak;
  scanf ("%d", &n);
  for (int i=1; i<=n; i++) {
    scanf ("%lf %lf %c %lf %lf", &a1, &b1,&znak, &a2, &b2);
    X=init (a1, b1);
    Y= init (a2, b2);
    if (znak=='+') wypisz (dodaj (X, Y));
    else if (znak=='-') wypisz (odejmij (X,Y));
    else if (znak=='*') wypisz (mnoz (X,Y));
    else if (znak=='/') wypisz (dziel(Y,X));
  } 
}