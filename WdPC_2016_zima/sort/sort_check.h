#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <stdbool.h>

#define max_size 1000000000
#define max_length 50001

typedef struct times {
    double  average;
    double longest;
    double shortest;
}times;

double mini (double a, double b);
double maks (double a, double b);
void test_gen (int n, double T[]);
//sprawdzanie poprawnosci algorytmu sortujacego dla zestawu danych w tablicy IN
bool sort_valid (int n, const double IN[], void (* sorting)(int N,  const double IN[], double OUT[]) );
int cmp (const void * a, const void * b);
// minimalny, maksymalny i sredni czas dla n zestawow danych o wielkosci s dla algorytmu sorting
times time_checking (int n, int s, void (* sorting)(int N,  const double IN[], double OUT[]));


