#include <bits/stdc++.h>
using namespace std;

bool next_subset(int n, vector<int>& subset) {
  if (subset.empty()) return false;
  int x= subset.back();
  subset.pop_back();
  if (next_subset(x-1, subset) == false) {
    if (x == n ) {
      subset.push_back(x);
      return false;
    }
    int s= subset.size();
    subset.clear();
    for (int i=1; i<=s; i++) subset.push_back(i);
    subset.push_back(x+1);
    return true;
  }
  subset.push_back(x);
  return true;
}

vector<int> create_subset(int k) {
  vector<int> v;
  for (int i=1; i<=k; i++) v.push_back(i);
  return v;
}


int G[12][12];
int deg[12];

bool check(int n, int k) {
  for (int i=1; i<=n; i++) {
    if (deg[i]>k ) return false;
  }
  return true;
}

bool find_regular_graph(int v, int n, int k) {
  vector<int> subset= create_subset(k- deg[v]);
  do {
    int more = k- deg[v];
    deg[v]+=more;
    for (auto x : subset) {
      deg[x]++;
      G[x][v]++;
      G[v][x]++;
    }
    if (check(n, k)) {
      if (v==n) return true;
      if (find_regular_graph(v+1, n, k)) return true;
    }
    deg[v]-=more;
    for (auto x : subset) {
      deg[x]--;
      G[x][v]--;
      G[v][x]--;
    }
  }  while (next_subset(n, subset));
  return false;
}

int main () {
  int n=11;
  int k=3;
  if (find_regular_graph(1, n, k)) {
    for (int i=1; i<=n; i++) {
      for (int j=1; j<=n; j++) {
        cout << G[i][j] << " ";
      }
      cout << "\n";
    }
  }
  else cout << " NIE MA\n";
}
