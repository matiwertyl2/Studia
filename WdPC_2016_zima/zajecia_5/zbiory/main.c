#include <stdio.h>
#include <stdlib.h>
#include "zbiory.h"

int main()
{
    zbior A,  B;
    char op=getchar();
    while (op!=EOF) {
        if (op=='u') {
            wczytaj (A);
            wczytaj (B);
            zbior sum;
            suma (A, B, sum);
            wypisz (sum);
        }
        else if (op=='n') {
            wczytaj (A);
            wczytaj (B);
            zbior przek;
            przekroj (A, B, przek);
            wypisz (przek);
        }
        else if (op=='+') {
            wczytaj (A);
            int x;
            scanf ("%d", &x);
            dodaj (A, x);
            wypisz (A);
        }
        else if (op=='-') {
            wczytaj (A);
            int x;
            scanf ("%d", &x);
            usun (A, x);
            wypisz (A);
        }
        else if (op=='c') {
            wczytaj (A);
            czysc (A);
            wypisz (A);
        }
        op=getchar();
    }
}
