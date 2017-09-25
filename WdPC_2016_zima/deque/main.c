//Mateusz Hazy
#include <stdio.h>
#include <stdlib.h>
#include "deque.h"
#include <stdbool.h>

Kolejka Quick_sort (Kolejka *A) {
    if (Empty (*A)==true) return (*A);
    if ((*A)==(*A)->next) return (*A);
    wezel * piwot= (*A);
    Kolejka X= Q_create();
    Kolejka Y= Q_create();
    wezel * pos= piwot->next;
    while (pos!=piwot ) {
        if (pos->x<=piwot->x) {
            Push_back (&X, pos->x);
        }
        else Push_back (&Y, pos->x);
        pos=pos->next;
    }
    X= Quick_sort (&X);
    Y= Quick_sort (&Y);
    Clear (A);
    Kolejka P= Q_create();
    Push_back (&P, piwot->x);
    Kolejka Q= Merge (&X, &P);
    Q= Merge (&Q, &Y);
    return Q;
}

// Dodatkowa funkcja, żeby Kolejka z wejścia została zachowana
// Jeśli Kolejka wejściowa ma się kasować, wystarczy funkcja Quick_sort
Kolejka quick_sort (Kolejka *A ) {
    Kolejka Q= Copy (A);
    return Quick_sort (&Q); // procedura sortowania
}

Kolejka Insert_sort (Kolejka *A) {
    Kolejka Q= Q_create();
    wezel * pos= (*A);
    Insert (&Q, pos->x);
    pos=pos->next;
    while (pos!=(*A)) {
        Insert (&Q, pos->x);
        pos=pos->next;
    }
    return Q;
}

int main()
{
    Kolejka Q= Q_create();
    Kolejka X= Q_create();
    double x;

    while (true) {
        char c= getchar();
        if (c=='b') {
            double x;
            scanf ("%lf", &x);
            Push_back (&Q, x);
        }
        if (c=='f') {
            double x;
            scanf ("%lf", &x);
            Push_front (&Q, x);
        }
        if (c=='B') {
            Pop_back (&Q);
        }
        if (c=='F') {
            Pop_front (&Q);
        }
        if (c=='x') {
            printf ("%lf\n", Front (&Q));
        }
        if (c=='y') printf ("%lf\n", Back (&Q));
        if (c=='d') printf ("%d\n", length (&Q));
        if (c=='I') {
            scanf ("%lf", &x);
            Insert (&Q, x);
        }
        if (c=='S') {
            Q= Insert_sort (&Q);
        }
        if (c=='k') {
            break;
        }
        if (c=='Q') {
            Q= quick_sort (&Q);
        }
        if (c=='W') wypisz (&Q);
    }
}













