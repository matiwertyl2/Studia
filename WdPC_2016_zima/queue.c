#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

typedef struct kolejka {
    double * pocz;
    double * kon;
    double * tab;
    int rozmiar;
}Kolejka;

void push (double x, Kolejka * Q);
Kolejka inicjuj (int s);
void realokuj ( Kolejka *Q);
void push (double x, Kolejka * Q);
void pop (Kolejka *Q);
double top (Kolejka *Q);
bool Empty (Kolejka *Q);
void Clear (Kolejka *Q);

Kolejka inicjuj (int s) {
    Kolejka Q;
    Q.tab = (double *)malloc (s* sizeof (double));
    Q.pocz= Q.tab;
    Q.kon=Q.tab;
    Q.rozmiar=s;
    return Q;
}

void realokuj ( Kolejka *Q) {
    double * t= Q->tab;
    Q->tab = (double *)realloc (Q->tab, Q->rozmiar*2*sizeof (double));
    Q->pocz= (Q->tab+ (Q->pocz-t));
    if (Q->kon!= t+Q->rozmiar-1 )Q->kon= Q->rozmiar+Q->tab;
    else Q->kon= Q->rozmiar+Q->tab-1;
    Q->rozmiar*=2;
    double * pos= Q->tab;
     while (pos< Q->pocz) {
        push (*pos, Q);
        pos++;
    }
}

void push (double x, Kolejka * Q) {
    if ((Q->kon+1) == Q->pocz) realokuj (Q);
    else if (Q->kon== Q->tab+Q->rozmiar-1 && Q->pocz==Q->tab) realokuj (Q);
    *Q->kon= x;
    Q->kon++;
    if (Q->kon== Q->tab+Q->rozmiar) Q->kon=Q->tab;
}

void pop (Kolejka *Q) {
    if (Empty (Q)==false) {
        Q->pocz++;
        if (Q->pocz== Q->tab+Q->rozmiar) Q->pocz=Q->tab;
    }
}

double top (Kolejka *Q) {
    if (Empty (Q)==true) return -1;
    return *Q->pocz;
}

bool Empty (Kolejka *Q) {
    if (Q->pocz== Q->kon) return true;
    return false;
}


void Clear (Kolejka *Q) {
    while (Empty(Q)==false) pop (Q);
}

int main()
{
    Kolejka Q= inicjuj (3);
    while (true) {
        char c= getchar();
        if (c=='t') printf ("%lf\n", top (&Q));
        else if (c=='p') {
            double x;
            scanf ("%lf", &x);
            push (x, &Q);
        }
        else if (c=='P') pop (&Q);
        else if (c=='c') Clear (&Q);
    }
}


