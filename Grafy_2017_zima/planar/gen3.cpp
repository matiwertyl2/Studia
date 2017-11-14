#include<bits/stdc++.h>
using namespace std;

int main () {
  int n;
  cin >> n;
  cout << 4*n << " " << 8*n-4 << "\n";
  for (int i=1; i<=4*n; i+=4) {
    cout << i << " " << i+1 << "\n";
    cout << i+1 << " " << i+2 << "\n";
    cout << i+2 << " " << i+3 << "\n";
    cout << i+3 << " " << i << "\n";
  }
  for (int i=5; i<=4*n; i++) {
    cout << i << " " << i-4 << "\n";
  }
}
