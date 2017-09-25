#include "ulamki.h"

long long int gcd (long long int a, long long int b) {
    int c;
    if (a<0) a*=-1;
    if (b<0) b*=-1;
    while (b!=0) {
        c=a;
        a=b;
        b= c % b;
    }
    return a;
}

ulamek konstruktor (const long long int p, const long long int q) {
    long long int a=p, b=q;
    if (b<0) a*=-1, b*=-1;
    int d= gcd (a, b);
    a/=d, b/=d;
    ulamek res;
    res= (a<< (bitow_w_int))  | b;
    return res;
}

long long int licznik (const ulamek X) {
    return X>> bitow_w_int;
}

long long int mianownik (const ulamek X) {
    long long int d=1;
    d=d << bitow_w_int;
    return X & (d-1);
}

ulamek wczytaj () {
    long long int a, b;
    scanf ("%lld/%lld", &a, &b);
    ulamek res= konstruktor (a, b);
    return res;
}

void wypisz (const ulamek W) {
     long long int a, b;
     long long int d=1;
     a= licznik (W);
     b= mianownik (W);
     printf ("%lld/%lld\n", a, b);
}

ulamek dodaj (const ulamek A, const ulamek B) {
    long long p1, p2, q1, q2;
    p1= licznik (A);
    p2= licznik (B);
    q1= mianownik (A);
    q2= mianownik (B);
    long long int x= p1*q2 + p2*q1;
    long long int y= q1*q2;
    return konstruktor (x, y);
}

ulamek odejmij (const ulamek A, const ulamek B) {
    long long p1, p2, q1, q2;
    p1= licznik (A);
    p2= licznik (B);
    q1= mianownik (A);
    q2= mianownik (B);
    long long int x= p1*q2 - p2*q1;
    long long int y= q1*q2;
    return konstruktor (x, y);
}

ulamek pomnoz (const ulamek A, const ulamek B) {
    long long p1, p2, q1, q2;
    p1= licznik (A);
    p2= licznik (B);
    q1= mianownik (A);
    q2= mianownik (B);
    long long int x= p1*p2;
    long long int y= q1*q2;
    return konstruktor (x, y);
}

ulamek podziel (const ulamek A, const ulamek B) {
    long long p1, p2, q1, q2;
    p1= licznik (A);
    p2= licznik (B);
    q1= mianownik (A);
    q2= mianownik (B);
    long long int x= p1*q2;
    long long int y= q1*p2;
    return konstruktor (x, y);
}













