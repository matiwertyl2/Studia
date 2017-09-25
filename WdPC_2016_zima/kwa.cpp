#include <bits/stdc++.h>
using namespace std;

vector <int> V;
int S;

bool sprawdz (int n) {
  //poziome 
  int sum=V[0];
  for (int i=1; i<n*n; i++) {
    if (i % n ==0) {
      if (sum!=S) return false;
      sum=0;
    }
    sum+=V[i];
  }
  //pionowe
  for (int i=0; i<n; i++) {
    sum=0;
    for (int j=i; j<n*n; j+=n) sum+=V[j];
    if (sum!=S) return false;
  }
  // skos 
  sum=0;
  for (int i=0; i<n*n; i+=n+1) sum+=V[i];
  if (sum!=S) return false;
  sum=0;
  for (int i=n-1; i<n*n-1; i+=n-1) sum+=V[i];
  if (sum!=S) return false;
  return true;
}

void wypisz (int n) {
  cout << V[0] << " ";
  for (int i=1; i<n*n; i++) {
    if (i% n==0) cout << "\n";
    cout << V[i] << " ";
  }
}


int main () {
  int n, k;
  cin >> n >> k;
  S= n*(n*n+1) /2;
  for (int i=1; i<=n*n; i++) V.push_back (i);
  while (k>0) {
    random_shuffle (V.begin(), V.end());
    if (sprawdz (n)==true) {
      wypisz (n);
      k--;
    }
  }
}