#include <bits/stdc++.h>
using namespace std;

int main () {
  int n;
  cin >> n;
  cout << n << " " << n+(n-2) << "\n";
  for (int i=1; i<n; i++) {
    cout << i <<  " " << i+1 << "\n";
  }
  cout << 1 << " " << n << "\n";
  for (int i=3; i<=n; i++) cout << i << " " << i-2 << "\n";
}
