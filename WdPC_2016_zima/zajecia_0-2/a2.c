#include <stdio.h>

char c;

int wczytaj_zbedne (int pos, int pocz) {
  int slowo=0;
  while (pos< pocz) {
    if (c==' ') {
      slowo=0;
    }
    else if (c=='\n') {
      slowo=0;
    }
    else if (c== '	') {
      slowo=0;
    }
    else  {
      if (slowo==0) pos++;
      slowo=1;
      
    }
    if (pos<pocz) c=getchar();
  }
  return pos;
}

int wczytaj_wazne (int pocz, int kon) {
  int pos=pocz;
  int slowo=1;
  while (pos<=kon) {
     if (c==' ') {
      printf ( " ");
      slowo=0;
    }
    else if (c=='\n') {
      printf ("\n");
      slowo=0;
    }
    else if (c=='	') {
      printf ( 	"	");
      slowo=0;
    }
    else  {
      if (slowo==0) pos++;
      slowo=1;
      if (pos<=kon) putchar (c);
    }
   if (pos<=kon) c=getchar();
  }
  return pos-1;
}

int main (int argc, char *argv[]) {
  if (argc<=1) printf ("brak argumentow\n");
  int pocz, kon, pos=0, ile;
  c=getchar();
  for (int i=1; i<argc; i++) {
    ile= sscanf ( argv[i], "%d-%d", &pocz, &kon);
    if (ile==1) kon=pocz;
    pos= wczytaj_zbedne (pos, pocz);
    pos=wczytaj_wazne (pocz, kon);
  }
}

















