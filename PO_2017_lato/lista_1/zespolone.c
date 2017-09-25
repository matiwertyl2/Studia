#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "zespolone.h"

Zespolone * dodaj (Zespolone *X, Zespolone * Y) {
  Zespolone * wyn= (Zespolone*) malloc (sizeof (Zespolone));
  wyn->a=X->a+Y->a;
  wyn->b=X->b + Y->b;
  return wyn;
}

void dodaj_do (Zespolone *X, Zespolone *Y) {
  Y->a+=X->a;
  Y->b+=X->b;
}

Zespolone * odejmij (Zespolone *X, Zespolone * Y) {
  Zespolone * wyn= (Zespolone*) malloc (sizeof (Zespolone));
  wyn->a=X->a - Y->a;
  wyn->b=X->b - Y->b;
  return wyn;
}

void odejmij_od (Zespolone *X, Zespolone *Y) {
  Y->a-=X->a;
  Y->b-=X->b;
}

Zespolone * mnoz (Zespolone *X, Zespolone *Y) {
  Zespolone * wyn=(Zespolone *) malloc(sizeof(Zespolone));
  wyn->a= X->a*Y->a - X->b*Y->b;
  wyn->b= X->a*Y->b + X->b*Y->a;
  return wyn;
}

void mnoz_do (Zespolone *X, Zespolone *Y) {
  double a,b;
  a= X->a*Y->a - X->b*Y->b;
  b=X->a*Y->b + X->b*Y->a;
  Y->a=a;
  Y->b=b;
}

Zespolone * dziel (Zespolone * X, Zespolone *Y) {  // Y dzielone na X
  Zespolone * sprzezenie = (Zespolone *) malloc (sizeof (Zespolone));
  sprzezenie->a= X->a;
  sprzezenie ->b= -X->b;
  Zespolone * licznik= mnoz (Y, sprzezenie);
  Zespolone * mianownik= mnoz (X, sprzezenie);
  if (mianownik->a==0) {
    printf ("nie wolno dzielic przez zero\n");
    exit(0);
  }
  licznik->a/=mianownik->a;
  licznik->b/=mianownik->a;
  free (mianownik);
  free (sprzezenie);
  return licznik;
}

Zespolone * dziel_przez (Zespolone * X, Zespolone *Y) {
  Zespolone * sprzezenie = (Zespolone *) malloc (sizeof (Zespolone));
  sprzezenie->a= X->a;
  sprzezenie ->b= -X->b;
  Zespolone * licznik= mnoz (Y, sprzezenie);
  Zespolone * mianownik= mnoz (X, sprzezenie);
  if (mianownik->a==0) {
    printf ("nie wolno dzielic przez zero\n");
    exit(0);
  }
  licznik->a/=mianownik->a;
  licznik->b/=mianownik->a;
  Y->a=licznik->a;
  Y->b=licznik->b;
  free (sprzezenie);
  free (licznik);
  free (mianownik);
}

Zespolone * init (double a, double b) {
  Zespolone * res= (Zespolone *) malloc (sizeof (Zespolone));
  res->a=a;
  res->b=b;
  return res;
}

double modul (double x) {
  if (x<0) return -x;
  return x;
}

void wypisz (Zespolone *X) {
  char *znak;
  if (X->b<0) {
    znak="-";
  }
  else znak="+";
  printf ("%.2lf %s %.2lf", X->a,znak, modul( X->b));
  printf ("i\n");
}




