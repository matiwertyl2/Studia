#include <stdio.h>
#include <stdlib.h>

typedef struct figura {
  int typfig;
  double x1, x2, y1, y2, r;
}Figura;


void narysuj (Figura *f);
void przesun (Figura *f, double x, double y);
int zawiera (Figura *f, double x, double y);
Figura * Kwadrat (double x1, double y1, double x2, double y2);
Figura * Punkt (double x, double y);
Figura * Kolo (double x, double y, double r);

