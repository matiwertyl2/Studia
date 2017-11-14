#include <bits/stdc++.h>
using namespace std;


int main () {
  int n;
  cin >> n;
  cout << n << " " << n*(n-1)/2 << "\n";
  for (int i=1; i<=n; i++) {
    for (int j=i+1; j<=n; j++) cout << i << " "<< j << "\n";
  }
}
