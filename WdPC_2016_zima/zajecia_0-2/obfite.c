#include <stdio.h>
#include <stdbool.h>
#include <limits.h>
#include <math.h>

int  dzielniki[10000]; // dzielnik i jego krotnosc
int krotnosc[10000];
int iledziel=0; // dzielniki.size()

long long f (long long x, int pos, int n) {
   if (pos== n) return x;
   long long res=0;
   res+= f (x, pos+1, n);
   for (int i=1; i<= dzielniki[pos].second; i++) {
      x*=dzielniki[pos].first;
      res+= f (x, pos+1, m);
   }
   return res;
}

bool pierwsze[1000000];
int P[100000];
int ilep=0; // P.size()

void sito (int n) {
  int skok=2;
  while (skok*skok <=n) {
    for (int i=skok*skok; i<=n; i+=skok) pierwsze[i]=true;
    for (int i=skok+1; i<=n; i++) {
      if (pierwsze[i]==false) {
	skok=i;
	break;
      }
    }
  }
  for (int i=2; i<=n; i++) {
    if (pierwsze[i]==false) {
      P[ilep]=i;
      ilep++;
     
    }
  }
}

void faktor (int x) {
  for (int i=0; i<100; i++) {
    dzielniki[i]=0;
    krotnosc[i]=0;
    iledziel=0;
  }
  for (int i=0; i<ilep; i++) {
    int ile=0;
    while ((x % P[i]) == 0) {
      ile++;
      x/= P[i];
    }
    if (ile!=0) {
      dzielniki[iledziel]=P[i];
      krotnosc[iledziel]=ile;
      iledziel++;
      
    }
    if (x==1) break;
  }
  if (x!=1){
    dzielniki[iledziel]=x;
    krotnosc[iledziel]=1;
    iledziel++;
    
  }
}

int main () {
  int maks=2147483647;
  int n, x;
  int obfitap=0, obfitan=0; // wyniki
  scanf ("%d", &n);
  int pier= sqrt (maks);
  sito (pier);
  if (n<maks) {
    for (int k=n+1; k< maks; k++) {
    // cout << k << " : \n";
      if ( (k % 2==0 && obfitap==0) || (k%2==1 && obfitan==0) ) {
	faktor (k);
    //   for (int i=0; i<dzielniki.size(); i++) cout << dzielniki[i].first << " " << dzielniki[i].second << "\n";
	long long sum= f (1, 0) -k;
	if (sum> k) {
	  if ( (k % 2) ==0) obfitap=k;
	  else obfitan=k;
	}
      }
      if (obfitap!=0 && obfitan!=0) break;
    }
  }
  if (obfitap!=0) printf ("%d ", obfitap)
  else printf ("BRAK ");
  if (obfitan!=0) printf ("%d\n" obfitan); 
  else printf ("BRAK\n");
}



