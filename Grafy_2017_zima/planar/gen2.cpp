#include <bits/stdc++.h>
using namespace std;

int main () {
  int n;
  cin >> n;
  cout << n << " " << (n-1)+(n-1) << "\n";
  for (int i=2; i<=n; i++) cout << i << " " << i/2 << "\n" << i << " " << i-1 << "\n";
}
