#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

typedef struct Wezel {
  struct Wezel * A;
  struct Wezel * B;
  struct Wezel * C;
  struct Wezel * D;
  bool mono;
  int kolor; 
  int d;
}wezel;

#define wezel_wsk wezel *

bool czy_szach (wezel * W) {
  if (W->d==1) return false;
  if (W->A->mono==true && W->B->mono==true && W->C->mono==true && W->D->mono==true && W->A->kolor==W->C->kolor && W->B->kolor==W->D->kolor && W->A->kolor!=W->B->kolor) return true;
  return false;
}

bool czy_mono (wezel *W) {
 if (W->d==1) return true;
 if (W->A->mono==true && W->B->mono==true && W->C->mono==true && W->D->mono==true && W->A->kolor==W->C->kolor && W->B->kolor==W->D->kolor && W->A->kolor==W->B->kolor) return true;
 return false;
}

void neguj (wezel_wsk * X) {
  wezel * W= (*X);
  if (W->mono==true) W->kolor= (W->kolor+1) % 2;
  else {
    neguj (&(W->A));
    neguj (&(W->B));
    neguj (&(W->C));
    neguj (&(W->D));
  }
}

void jedynka (wezel_wsk *W) {
  (*W)->mono=true;
  (*W)->kolor=1;
}

void zero (wezel_wsk *W) {
  (*W)->mono=true;
  (*W)->kolor=0;
}

void obrot (wezel_wsk *W) {
  if ((*W)->d >1) {
    wezel * P= (*W)->D;
    (*W)->D=(*W)->C;
    (*W)->C=(*W)->B;
    (*W)->B=(*W)->A;
    (*W)->A=P;
  }
}

wezel * new_wezel (int _d) {
  wezel * W= (wezel *)malloc ( sizeof (wezel));
  W->d=_d;
  W->A=NULL;
  W->B=NULL;
  W->C=NULL;
  W->D=NULL;
  W->kolor=0;
  W->mono=false;
  return W;
}

int tab[1050][1050];

wezel * create_tree (int X, int Y, int D) {
  wezel * W= new_wezel (D);
  if (D==1) {
    W->mono=true;
    W->kolor= tab[X][Y];
    return W;
  }
  W->A= create_tree (X, Y, D/2);
  W->B= create_tree (X, Y+D/2, D/2);
  W->C= create_tree (X+D/2, Y+D/2, D/2);
  W->D= create_tree (X+D/2, Y, D/2);
  if (czy_mono (W)==true) {
    W->kolor=W->A->kolor;
    W->mono=true;
  }
  return W;
}

int rozno (wezel * W, int Mono) {
  if (Mono==1) return 1;
  if (W->mono==true) return 1;
  return rozno (W->A, Mono)+ rozno (W->B, Mono) + rozno (W->C, Mono)+ rozno(W->D, Mono);
}

int ile_szach (wezel *W, int Mono) {
  if (Mono==1) return 0;
  if (W->d==1) return 0;
  if (W->mono==true) return 0;
  if (czy_szach (W)==true) return 1;
  return ile_szach (W->A, Mono)+ ile_szach (W->B, Mono)+ ile_szach (W->C, Mono) + ile_szach (W->D, Mono);
}

void przetworz (wezel_wsk * X, char op, int Mono, int kol) {
  if ((*X)->mono==true) {
    Mono=1;
    kol= (*X)->kolor;
  }
  wezel * P= (*X);
  char c= getchar();
  if (c=='\n') {
    if (op=='=') {
      printf ("%d\n", rozno (*X, Mono));
    }
    else if (op=='#') {
      printf ("%d\n", ile_szach (*X, Mono));
    }
    else if (op=='1') {
      jedynka (X);
    }
    else if (op=='0') zero (X);
    else if (op=='*') obrot (X);
    else if (op=='-') {
      if (Mono==1) {
	(*X)->kolor= (kol+1) % 2;
      }
      else {
	neguj (X);
      }
    }
  } 
  else {
    if (c=='a') przetworz (&(P->A), op, Mono, kol);
    else if (c=='b') przetworz (&(P->B), op, Mono, kol);
    else if (c=='c') przetworz (&(P->C), op, Mono, kol);
    else if (c=='d') przetworz (&(P->D), op, Mono, kol);
    if (czy_mono (*X)==false) {
      (*X)->mono=false;
    }
    if ((*X)->mono==false && czy_mono (*X)==true) {
      (*X)->mono=true;
      (*X)->kolor=(*X)->A->kolor;
    }
  }
}

int main () {
  char c= getchar();
   c=getchar();
  int n;
  scanf ("%d %d", &n, &n);
  c=getchar();
  for (int i=1; i<=n; i++){
    for (int j=1; j<=n; j++) {
      c=getchar();
      if (c=='1') tab[i][j]=1;
    }
    c=getchar();
    
  }
  wezel * W= create_tree (1, 1, n);
  c=getchar();
  while (c!='.') {
    int Mono=0, kol;
    if (W->mono==true) {
      Mono=1;
      kol=W->kolor;
    }
    przetworz (&W, c, Mono, kol );
    c=getchar();
  }
}











