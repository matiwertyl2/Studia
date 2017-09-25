#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

int Posx[26][10000];
int Posy[26][10000];
int konx[100]; // koniec wspolrzednych x dla kazdej literki
int kony[100]; // koniec wspolrzednych y dfla kazdej literki
int dlugosc[100]; // jak dlugie jest slowo

int n;
int ile=0;
char res[100];
char przyp[100]; // jaka literka przypisana danej liczbie
bool uzyte_cyfry[100];
bool uzyte_literki[100];
 
char literki[100]; // jakie literki wystepuja
int konliterki=0;

int dod[100];
int dzialanie[200][200];
char sym[100][100];
int max_len=0;

int maks (int a, int b) {
  if (a>b) return a;
  return b;
}

void wpisz_cyfry (int x, int d) {
  char literka=literki[d];
  for (int i=0; i<konx[literka-'A']; i++) {
    dzialanie[Posx[literka-'A'][i]][Posy[literka-'A'][i]]=x;
  }
}

int sumuj (int kol) {
  int res=0;
  for (int i=0; i<n; i++) res+=dzialanie[i][kol];
  return res+ dod[kol];
}

bool sprawdz_poprawnosc () {
  for (int i=0; i<=n; i++) {
    if (dzialanie[i][dlugosc[i]-1]==0) return false;
  }
  for (int i=0; i<max_len+2; i++) {
    int suma= sumuj (i);
    if (suma %10!= dzialanie[n][i]) return false;
    dod[i+1]=suma/10;
  }
  return true;
}

void wpisz_wynik () {
  for (int i=0; i<10; i++) {
    res[i]=przyp[i];
  }
 // for (int i=0; i<10; i++) {
 //     if (res[i]!='\0') printf ("%d-%c ", i, res[i]);
 // }
 // printf ("\n");
}

void f (int d) {
  if (d==konliterki) {
    if (sprawdz_poprawnosc()==true) {
      ile++;
      wpisz_wynik ();
    }
  }
  else {
    for (int i=0; i<=9; i++) {
      if (uzyte_cyfry[i]==false) {
	wpisz_cyfry (i, d);
	uzyte_cyfry[i]=true;
	przyp[i]=literki[d];
	f (d+1);
	uzyte_cyfry[i]=false;
	przyp[i]='\0';
      }
    }
  }
}


int main () {
  char slowo[100];
  scanf ("%d", &n);
  for (int i=0; i<=n; i++) {
    scanf ("%s", slowo);
    int len= strlen(slowo);
    dlugosc[i]=len;
    max_len= maks(max_len, len);
    for (int j=0; j<100; j++) {
      if (slowo[j]=='\0') break;
      if (uzyte_literki[slowo[j]-'A']==false) {
	literki[konliterki]=slowo[j];
	konliterki++;
	uzyte_literki[slowo[j]-'A']=true;
      }
      sym[i][len-j-1]=slowo[j];
      Posx[slowo[j]-'A'][konx[slowo[j]-'A']]=i;
      konx[slowo[j]-'A']++;
      Posy[slowo[j]-'A'][kony[slowo[j]-'A']]=len-j-1;
      kony[slowo[j]-'A']++;
    }
  }
  f (0);
  if (ile==1) {
    for (int i=0; i<10; i++) {
      if (res[i]!='\0') printf ("%d-%c ", i, res[i]);
    }
  }
  else printf ("%d\n", ile);
}