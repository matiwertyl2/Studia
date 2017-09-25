#include <stdio.h>
#include <stdbool.h>

char kolumna;
char wiersz;
char kolor;
char plansza[30][30];
char c='a';
int n;

int wczytaj () {
  //printf (" wczytuje \n");
  kolor= getchar();
  if (kolor!= 'B' && kolor!='W') {
    c=kolor;
    return 0;
  }
  char nawias=getchar ();
  if (nawias!='[') {
    c=nawias;
    return 0;
  }
  kolumna= getchar();
  wiersz=getchar();
  nawias=getchar();
  if (nawias!=']') {
    c=nawias;
    return 0; 
  }
  return 1;
}

int czytaj_size() {
  char z= getchar ();
  if (z!='Z') {
    c=z;
    return 0;
  }
  char nawias=getchar ();
  if (nawias!='[') {
    c=nawias;
    return 0;
  }
  scanf ("%d", &n);
  return 1;
}


int main () {
  int jest=0;
  while (jest==0) {
    if (c=='S') {
      jest = czytaj_size ();
    }
    else c=getchar();
  }
  c=getchar();
  int szablon=1;
  for (int i=0; i<n; i++) {
    for (int j=0; j<n; j++) plansza[i][j]='.';
  }
 // printf ("\n\n");
  while (c!=EOF) {
    //putchar (c);
    if (szablon==0) szablon=1;
    else c=getchar();
    if (c==';') {
      szablon= wczytaj ();
      if (szablon==1) {
	char znak;
	if (kolor=='W') znak='O';
	else znak='X';
	plansza[wiersz-'a'][kolumna-'a']=znak;
      }
    }
  }
  printf (" ");
  
  for (int i=0; i<n; i++) {
    printf (" ");
    putchar ('A'+i);
  }
  printf ("\n");
  for (int i=0; i<n; i++) {
    putchar ('A'+i);
    printf (" ");
    for (int j=0; j<n; j++){
      putchar (plansza[i][j]);
      printf (" ");
    }
    printf ("\n");
  }
  int maxb=0, maxc=0;
  for (int i=0; i<n; i++) {
    int mb=0, mc=0;
    for (int j=0; j<n; j++) {
      if (plansza[i][j]=='X') mc++;
      if (plansza[i][j]=='O') mb++;
    }
    if (mc>maxc) maxc=mc;
    if (mb>maxb) maxb=mb;
  }
  printf ("%d %d\n", maxc, maxb);
}




