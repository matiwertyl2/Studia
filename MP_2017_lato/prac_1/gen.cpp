#include<bits/stdc++.h>
using namespace std;

bool tab[1001];

int main (int argc, char *argv[]) {
  srand(atoi(argv[1]));
  int n;
  scanf("%d", &n);
  for (int i=1; i<=n; i++) {
    if (rand() % 2==1) tab[i]=true;
  }
  printf( "tests(per, performance, [");
  for (int i=1; i<=n; i++) {
    if (tab[i]==0) printf("~");
    printf( "q%d", i);
    if (i!=n) printf(", ");
  }
  printf("], 10000, solution([");

  for (int i=1; i<=n; i++){
    char znak='t';
    if (tab[i]==0) znak='f';
   printf ("(q%d, %c)", i, znak);
   if (i!=n) printf(", " );
 }
  printf ("])).");
}
