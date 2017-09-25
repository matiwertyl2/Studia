#include "ulamki.h"

int main() {
    char znak;
    while (true) {
        ulamek A, B;
        A=wczytaj ();
        znak= getchar();
        znak=getchar();
        B= wczytaj ();
        if (znak=='+') wypisz (dodaj (A, B));
        if (znak=='-') wypisz (odejmij (A, B));
        if (znak=='*') wypisz (pomnoz (A, B));
        if (znak =='/') wypisz (podziel (A, B));
    }
}
