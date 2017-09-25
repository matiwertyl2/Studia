#include "sort_check.h"


int cmp (const void * a, const void * b) {
   return ( *(double*)a - *(double*)b );
}

double mini ( double a, double b) {
    if (a<b) return a;
    return b;
}

double maks (double a, double b) {
    if (a>b) return a;
    return b;
}

void test_gen (int n, double T[]) {
    for (int i=0; i<n; i++) {
        T[i]= rand() % max_size;
    }
}

bool sort_valid (int n, const double IN[], void (* sorting)(int N,  const double IN[], double OUT[])) {
    double T[n+1];
    double sorted[n+1];
    for (int i=0; i<n; i++) sorted[i]=T[i]=IN[i];
    qsort (&T, n, sizeof (double), cmp);
    sorting (n, IN, sorted);
    for (int i=0; i<n; i++)  {
        if (sorted[i]!=T[i]) return false;
    }
    return true;
}

times time_checking (int n, int s, void (* sorting)(int N,  const double IN[], double OUT[])) {
    double T[s];
    double sorted[s];
    times res;
    res.shortest=max_size+1;
    for (int i=1; i<=n; i++) {
        test_gen (s, T);
        double pre=clock();
        sorting (s, T, sorted);
        double post= clock();
        res.shortest = mini (res.shortest, (double)(post-pre)/CLOCKS_PER_SEC);
        res.longest= maks (res.longest, (double)(post-pre)/CLOCKS_PER_SEC);
        res.average+= (double)(post-pre)/CLOCKS_PER_SEC;
    }
    res.average/=n;
    return res;
}











