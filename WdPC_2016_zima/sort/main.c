#include <stdio.h>
#include "sort_check.h"

void select_sort (int n, const double IN[], double OUT[]) {
    double T[n];
    for (int i=0; i<n; i++) T[i]=IN[i];
    for (int i=0; i<n; i++) {
        double x= max_size;
        int pos=0;
        for (int j=0; j<n; j++) {
            if (T[j]<x) {
                x=T[j];
                pos=j;
            }
        }
        OUT[i]=x;
        T[pos]=max_size+1;

    }
}



void scal (int n, int p1, int k1, int p2, int k2, double OUT[]) {
    int pocz=p1;
    int kon=k2;
    int pos=p1;
    double T[n+1];
    while (p1<=k1 && p2<=k2) {
        if (OUT[p1]<OUT[p2]) {
            T[pos]=OUT[p1];
            p1++;
            pos++;
        }
        else {
            T[pos]=OUT[p2];
            p2++;
            pos++;
        }
    }
    while (p1<=k1) {
        T[pos]=OUT[p1];
        p1++;
        pos++;
    }
    while (p2<=k2) {
        T[pos]=OUT[p2];
        p2++;
        pos++;
    }
    for (int i=pocz; i<=kon; i++) OUT[i]=T[i];
}


void merge_sort (int n, int pocz, int kon, const double IN[], double OUT[]) {
    if (pocz==kon) OUT[pocz]=IN[pocz];
    else if (pocz+1==kon) {
        OUT[pocz]=IN[pocz];
        OUT[kon]=IN[kon];
        if (OUT[pocz]>OUT[kon]) {
            double x=OUT[kon];
            OUT[kon]=OUT[pocz];
            OUT[pocz]=x;
        }
    }
    else {
        int s= (pocz+kon)/2;
        merge_sort (n, pocz, s, IN, OUT);
        merge_sort (n, s+1, kon, IN, OUT);
        scal (n, pocz, s, s+1, kon, OUT);
    }
}

void merge_sort_test (int n, const double IN[], double OUT[]) {
    merge_sort (n, 0, n-1, IN, OUT);
}

void qsort_test (int n, const double IN[], double OUT[]) {
    for (int i=0; i<n; i++) OUT[i]=IN[i];
    qsort (&OUT, n, sizeof (double), cmp);
}

double T[1000];

int main()
{
    int t;
    scanf ("%d", &t);
    for (int i=1; i<=t; i++ ){
        int n, s;
        scanf ("%d%d", &n, &s);
        times select= time_checking (n, s, select_sort);
        printf ("select sort dla s=%d\n %lf\n %lf\n %lf \n", s, select.shortest, select.longest, select.average);
        times merge= time_checking (n, s, merge_sort_test);
        printf ("merge sort dla s=%d\n %lf\n %lf\n %lf \n", s, merge.shortest,  merge.longest, merge.average);
        times quick= time_checking (n, s, qsort_test);
        printf ("quick sort dla s=%d\n %lf\n %lf\n %lf \n", s, quick.shortest,  quick.longest, quick.average);
    }
}








