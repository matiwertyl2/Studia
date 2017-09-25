#include <bits/stdc++.h>
using namespace std;


int main () {
  int n;
  cin >> n;
  cout << "P1\n";
  cout << n << " " << n << "\n";
  for (int i=1; i<=n; i++) {
    for (int j=1; j<=n; j++){
      if ((j+i)%2==1) cout << 1;
      else cout << 0;
    }
    cout << "\n";
  }
  cout << "=\n";
  cout << "#\n";
  cout << ".\n";
}