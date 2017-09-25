#include <stdio.h>
#include <math.h>
#include <string.h>


#define ILOSCF 6

static char * nazwa[ILOSCF]= { "sin", "cos", "sqrt", "exp", "log", "sinh"};
static double (*funkcja[ILOSCF])(double x)= {sin, cos, sqrt, exp, log, sinh};


#define MAXX 80
#define MAXY 20

static char wykres[MAXY][MAXX+1];

static void wyznacz_wykres (double (*funkcja)(double x), double a, double b, double * miny, double * maxy);
static void rysuj_wykres (char *nazwaf, double a, double b, double miny, double maxy);


int main (void ) {
    int nr;
    double a, b, miny, maxy;

    printf ("ryowanie wykresuj wybranej funkcji w zadanym przedziale:\n");
    for (int i=0; i<ILOSCF; ++i){
        printf ("% 3 i) %5s(x) \n ", i+1, nazwa[i]);
    }
    do {
        printf ("Wybierz numer funkcji (1-%i) : ", ILOSCF);
        scanf ("%d", &nr);
    } while (nr<1 || nr>ILOSCF);
    do {
        printf ("Podaj przedzial [a,b], dla x : ");
        scanf ("%lf %lf", &a, &b);
    } while (a>=b);
}
