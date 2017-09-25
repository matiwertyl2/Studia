#include <stdio.h>



pair <int, int> proba [100];
int reszty[1000000]; // pozycja danej reszty
int pozycja[10000000]; // jaka reszta jest na danej pozycji
int wartosci[1000000]; // jaka wartosc jest dla danej reszty

int main () {
    int n, m;
    scanf ("%d%d", &n, &m);
    int dziel= n/m;
    printf ("%d", dziel);
    if ((n % m) !=0) printf (",");
    int r= 10* (n% m);
    int okres=0;
    int pocz;
    int pos=1;
    while (okres==0) {
      if (r==0) break;
      int reszta= r % m;
      if (reszty[r]!=0) {
	okres=1;
	pocz=reszty[r]; // tu sie zaczal okres
	break;
      }
      reszty[r]=pos;
      pozycja[pos]=r;
      wartosci[r]= r/m;
      r= reszta *10;
      pos++;
      
    }
    if (okres==0) { // wypisujemy cale rozwiniecie
      for (int i=1; i<=m; i++) {
	if (pozycja[i]==0) break;
	int reszta= pozycja[i];
	printf ("%d", wartosci[reszta]);
      }
    }
    else {
      for (int i=1; i<=m; i++) {
	if (pozycja[i]==0) break; 
	int reszta=pozycja[i];
	if (i==pocz) printf ("(");
	printf ("%d", wartosci[reszta]);
      }
      printf (")");
    }
    printf ("\n");
}














