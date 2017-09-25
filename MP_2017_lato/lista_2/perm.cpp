#include <bits/stdc++.h>
using namespace std;

void perm(vector<int>& V, vector <int>& res) {
  if (V.size()==0) {
    for (int i=0; i<res.size(); i++) cout << res[i] << " ";
    cout << "\n";
  }
  else {
    for (int i=0; i<V.size(); i++) {
      vector <int> Vnowe;
      Vnowe.clear();
      for (int j=0; j<V.size(); j++) {
	if (j!=i) Vnowe.push_back(V[j]);
      }
      res.push_back(V[i]);
      perm(Vnowe, res);
      res.pop_back();
    }
  }
}

int main () {
  vector <int> V;
  V.clear();
  vector <int> res;
  res.clear();
  for (int i=1; i<=5; i++) {
    V.push_back(i);
  }
  perm(V, res);
}