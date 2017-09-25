#include <stdio.h>
#include <stdlib.h>
#include "figury.h"

void narysuj (Figura *f) {
  if (f->typfig==1) {  // punkt
    printf ("rysuje punkt o wspolrzednych %.2lf %.2lf\n", f->x1, f->y1);
  }
  else if (f->typfig== 2) { // kwadrat
    printf ("rysuje kwadrat o wspolrzednych %2lf %2lf , %2lf %2lf\n", f->x1, f->y1, f->x2, f->y2);
  }
  else if (f->typfig == 3) { //kolo
    printf ("rysuje kolo o wspolrzednych %2lf %2lf i promieniu %2lf\n", f->x1, f->y1, f->r);
  }
}

void przesun (Figura *f, double x, double y) {
  if (f->typfig==1 || f->typfig==3) {
    f->x1+=x;
    f->y1+=y;
  }
  else if (f->typfig==2) {
    f->x1+=x;
    f->x2+=x;
    f->y1+=y;
    f->y2+=y;
  }
}

int zawiera (Figura *f, double x, double y) {
  if (f->typfig==1) {
    if (f->x1==x && f->y1==y) return 1;
    else return -1;
  }
  else if (f->typfig==2) {
    if (x>=f->x1 && x<=f->x2 && y>=f->y1 && y<=f->y2) return 1;
    else return -1;
  }
  else if (f->typfig==3) {
    if ( (x-f->x1)*(x-f->x1)+(y-f->y1)*(y-f->y1) <=f->r*f->r) return 1;
    else return -1;
  }
}

Figura * Kwadrat (double x1, double y1, double x2, double y2) {
  Figura * f=(Figura *)malloc (sizeof (Figura));
  f->typfig=2;
  f->x1=x1;
  f->x2=x2;
  f->y1=y1;
  f->y2=y2;
  return f;
}

Figura * Punkt (double x, double y) {
    Figura * f=(Figura *)malloc (sizeof (Figura));
    f->typfig=1;
    f->x1=x;
    f->y1=y;
    return f;
}

Figura * Kolo (double x, double y, double r) {
  Figura * f=(Figura *)malloc (sizeof (Figura));
  f->typfig=3;
  f->x1=x;
  f->y1=y;
  f->r=r;
  return f;
}










