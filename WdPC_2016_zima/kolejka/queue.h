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
