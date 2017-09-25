#include <bits/stdc++.h>
using namespace std;

vector <int> V;
vector <int> W;

int main () {
  int n, m, a;
  cin >> n >> m;
  for (int i=1; i<=n; i++) {
    cin >> a;
    V.push_back (a);
    W.push_back (a);
  }
  sort (W.begin(), W.end());
  cout << "Tablica nieposortowana:\n\n";
  for (int i=0; i<n; i++) cout << V[i] << " ";
  cout << "\n\nTablica posortowana:\n\n";
  for (int i=0; i<n; i++) cout << W[i] << " ";
  cout << "\n";
}