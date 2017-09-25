#include <stdio.h>
#include <stdbool.h>


#define MAX_SET_SIZE 8000


typedef int zbior[MAX_SET_SIZE+1];


void wczytaj (zbior S);
void wypisz (const zbior S);
void suma (const zbior S1, const zbior S2, zbior W);
void  przekroj (const zbior S1, const zbior S2, zbior W);
void czysc (zbior S);
void dodaj (zbior S, int x);
void usun (zbior S, int x);
