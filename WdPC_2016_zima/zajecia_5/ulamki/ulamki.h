#include <stdio.h>
#include <limits.h>
#include <stdbool.h>

#define bitow_w_int (CHAR_BIT * sizeof ( int))

typedef long long int ulamek;

long long int gcd (long long int a, long long int b);
ulamek konstruktor (const long long int a, const long long int b);
long long int licznik (const ulamek X);
long long int mianownik (const ulamek X);
ulamek wczytaj ();
void wypisz (const ulamek W);
ulamek dodaj (const ulamek A, const ulamek B);
ulamek odejmij (const ulamek A, const ulamek B);
ulamek pomnoz (const ulamek A, const ulamek B);
ulamek podziel (const ulamek A, const ulamek B);
