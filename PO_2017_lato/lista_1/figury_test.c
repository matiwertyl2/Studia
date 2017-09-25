#include <stdio.h>
#include <stdlib.h>
#include "figury.h"

int main () {
  Figura * A= Punkt (0, 0);
  Figura * B= Kwadrat (0, 0, 1, 1);
  Figura * C= Kolo (0, 0, 2);
  narysuj (A);
  narysuj (B);
  narysuj (C);
  przesun (A, 1, 2);
  narysuj (A);
  printf ("%d\n", zawiera (A, 1, 1));
  przesun (B, 10, 10);
  narysuj (B);
  printf ("%d\n", zawiera (B, 10.5, 10.5));
  przesun (C, -1, -1);
  narysuj (C);
}