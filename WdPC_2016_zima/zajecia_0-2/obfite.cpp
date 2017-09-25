#include <bits/stdc++.h>
using namespace std;


vector <pair <int, int> > dzielniki; // dzielnik i jego krotnosc

long long f (long long x, int pos) {
   if (pos== dzielniki.size()) return x;
   long long res=0;
   res+= f (x, pos+1);
   for (int i=1; i<= dzielniki[pos].second; i++) {
      x*=dzielniki[pos].first;
      res+= f (x, pos+1);
   }
   return res;
}

bool pierwsze[1000000];
vector <int> P;

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
    if (pierwsze[i]==false) P.push_back (i);
  }
}

void faktor (int x) {
  dzielniki.clear();
  for (int i=0; i<P.size(); i++) {
    int ile=0;
    while ((x % P[i]) == 0) {
      ile++;
      x/= P[i];
    }
    if (ile!=0) dzielniki.push_back (make_pair (P[i], ile));
    if (x==1) break;
  }
  if (x!=1) dzielniki.push_back (make_pair (x, 1));
}

int main () {
  int maks=2147483647;
  int n, x;
  int obfitap=0, obfitan=0; // wyniki
  cin >> n;
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
  if (obfitap!=0) cout << obfitap << " ";
  else cout << "BRAK ";
  if (obfitan!=0) cout << obfitan << "\n";
  else cout << "BRAK\n";
}



