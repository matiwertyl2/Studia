#include <stdio.h>
#include <stdlib.h>


typedef struct z {
  double a, b;
}Zespolone;


Zespolone * dodaj (Zespolone *X, Zespolone * Y);
void dodaj_do (Zespolone *X, Zespolone *Y);
Zespolone * odejmij (Zespolone *X, Zespolone * Y);
void odejmij_od (Zespolone *X, Zespolone *Y);
Zespolone * mnoz (Zespolone *X, Zespolone *Y);
void mnoz_do (Zespolone *X, Zespolone *Y);
Zespolone * dziel (Zespolone * X, Zespolone *Y);  // Y dzielone na X
Zespolone * dziel_przez (Zespolone * X, Zespolone *Y);
Zespolone * init (double a, double b);
void wypisz (Zespolone *X);



