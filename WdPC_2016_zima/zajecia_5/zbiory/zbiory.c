#include "zbiory.h"


void wczytaj (zbior S) {
    int n;
    scanf ("%d", &n);
    S[0]=n;
    for (int i=1; i<=n; i++) scanf ("%d", &S[i]);
    bool bylo=true;
    while (bylo==true) {
        bylo=false;
        for (int i=2; i<=n; i++) {
            if (S[i]<S[i-1]) {
                bylo=true;
                int a=S[i];
                S[i]=S[i-1];
                S[i-1]=a;
            }
        }
    }
}

void wypisz (const zbior S) {
    int n= S[0];
    for (int i=1; i<=n; i++) printf ("%d ",  S[i]);
    printf ("\n");
}


void suma (const zbior A, const zbior B, zbior S) {
    int pos1=1, pos2=1, n1=A[0], n2=B[0], pos=1;
    while (pos1<=n1 || pos2<=n2) {
        if (pos1>n1) {
            S[pos]=B[pos2];
            pos2++;
            pos++;
        }
        else if (pos2>n1) {
            S[pos]=A[pos1];
            pos1++;
            pos++;
        }
        else {
            if (A[pos1]<B[pos2]) {
                S[pos]=A[pos1];
                pos1++;
                pos++;
            }
            else if (B[pos2]<A[pos1]) {
                S[pos]=B[pos2];
                pos2++;
                pos++;
            }
            else {
                S[pos]=A[pos1];
                pos1++;
                pos2++;
                pos++;
            }
        }
    }
    S[0]=pos-1;
}


void przekroj (const zbior A, const zbior B, zbior S) {
    int pos1=1, pos2=1, n1=A[0], n2=B[0], pos=1;
    while (pos1<=n1 && pos2<=n2) {
        if (A[pos1]<B[pos2]) {
            pos1++;
        }
        else if (B[pos2]<A[pos1]) {
            pos2++;
        }
        else {
            S[pos]=A[pos1];
            pos1++;
            pos2++;
            pos++;
        }

    }
    S[0]=pos-1;
}


void czysc (zbior S) {
    int n= S[0];
    for (int i=1; i<=n; i++) S[i]=0;
    S[0]=0;
}

void dodaj (zbior S, int x) {
    int n=S[0];
    bool jest=false;
    for (int i=1; i<=n; i++) {
        if (x<S[i]) {
            int p=S[i];
            S[i]=x;
            x=p;
        }
        else if (x==S[i]) {
            jest=true;
            break;
        }
    }
    if (jest==false) {
        S[n+1]=x;
        S[0]++;
    }

}


void usun (zbior S, int x) {
    int n=S[0];
    bool jest=false;
    for (int i=1; i<=n; i++) {
        if (S[i]==x) {
            jest=true;
            S[0]=n-1;
        }
        if (jest==true) {
            S[i]=S[i+1];
        }
    }

}






