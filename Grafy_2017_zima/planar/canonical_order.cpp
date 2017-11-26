#include <bits/stdc++.h>
using namespace std;


vector<int> G[10000];
bool cutCanonical[10000];
bool usedCanonical[10000];

bool belongs(int x, const vector<int>& V ) {
  for (auto v : V) {
    if (x == v) return true;
  }
  return false;
}

struct Slope {
  vector<int> V;

  Slope() {}

  Slope(int a, int b) {
    V.push_back(a);
    V.push_back(b);
  }

  Slope(Slope S, int p, int k) { // part of slope inside
    for(int i=p; i<=k; i++) V.push_back(S.V[i]);
  }

  Slope(Slope S, int p, int k, int v) { // slope created by adding new vertex
    for (size_t i=0; i<=p; i++) V.push_back(S.V[i]);
    V.push_back(v);
    for (size_t i=k; i<S.V.size(); i++) V.push_back(S.V[i]);
  }

  void operator = (Slope S) {
    V.clear();
    for (auto v : S.V) V.push_back(v);
  }

  int get_most_left_vertex_position(int v) {
    for (size_t i=0; i< V.size(); i++) {
      if (belongs(V[i], G[v])) return i;
    }
    return -1;
  }

  int get_most_right_vertex_position(int v) {
    for (size_t i=V.size()-1; i>=0; i--) {
      if (belongs(V[i], G[v])) return i;
    }
    return -1;
  }

  void print() {
    cout << "SLOPE ";
    for (auto v : V) cout << v << " ";
    cout << "\n";
  }

};

struct Vset {
  vector<int> V;

  Vset() {}

  Vset(int x) {
    V.push_back(x);
  }

  Vset(vector<int>& vec) {
    for (auto v : vec) V.push_back(v);
    sort(V.begin(), V.end());
  }

  Vset( const Vset& S) {
    for (auto v : S.V) V.push_back(v);
    sort(V.begin(), V.end());
  }

  bool operator = (Vset S) {
    V.clear();
    for (auto v : S.V) V.push_back(v);
  }

  void operator + (Vset S) {
    for (auto v : S.V) V.push_back(v);
    sort(V.begin(), V.end());
    V.erase( unique( V.begin(), V.end() ), V.end() );
  }

  void operator + (vector<int>& vec) {
    for (auto v : vec) V.push_back(v);
    sort(V.begin(), V.end());
    V.erase( unique( V.begin(), V.end() ), V.end() );
  }

  void operator + (int x) {
    if (belongs(x, V)==false) V.push_back(x);
    sort(V.begin(), V.end());
  }

  void operator += (int x) {
    if (belongs(x, V)==false) V.push_back(x);
    sort(V.begin(), V.end());
  }

  void print() {
    cout << "VSET ";
    for (auto v : V) cout << v << " ";
    cout << "\n";
  }

  bool empty() {
    if (V.empty()) return true;
    return false;
  }

};

Vset operator - (Vset S1, Vset S2) {
  int pos = 0;
  vector<int> vec;
  for (size_t i=0; i<S1.V.size(); i++) {
    while (pos < S2.V.size() && S2.V[pos] < S1.V[i] ) pos++;
    if (pos >= S2.V.size() ||  S2.V[pos]!=S1.V[i]) vec.push_back(S1.V[i]);
  }
  return Vset(vec);
}

Vset operator - (Vset S, int x) {
  vector<int> vec;
  for (auto y : S.V) {
    if (y!=x) vec.push_back(y);
  }
  return Vset(vec);
}


int get_cut_vertex(Vset Set, Slope slope) {
  for (auto v : Set.V) {
    for (auto u : G[v]) {
      if (belongs(u, slope.V)) return v;
    }
  }
  return -1;
}

Vset get_inner_set(Vset Set, Slope slope) {
  Vset res;
  for (auto v : Set.V) usedCanonical[v]=false;
  queue<int> Q;
  for (size_t i=1; i+1 < slope.V.size(); i++) {
    int v = slope.V[i];
    Q.push(v);
  }
  while (!Q.empty()) {
    int v = Q.front();
    Q.pop();
    if (belongs(v, slope.V)==false) res += v;
    usedCanonical[v]=true;
    for (auto u : G[v]) {
      if (usedCanonical[u]==false && cutCanonical[u]==false) Q.push(u);
    }
  }
  return res;
}

vector<int> canonical_order(Vset Set, Slope slope) {
  cout << "CANONICAL\n";
  slope.print();
  Set.print();
  vector<int> res;
  if (Set.empty()) return res;
  int v = get_cut_vertex(Set, slope);
  cout << "CUT " << v << endl;
  cutCanonical[v]=true;
  int p = slope.get_most_left_vertex_position(v);
  int k = slope.get_most_right_vertex_position(v);

  Slope inner_slope = Slope(slope, p, k);
  Slope outer_slope = Slope(slope, p, k, v);
  Vset inner_set = get_inner_set(Set, inner_slope);
  Vset outer_set = (Set - inner_set) - v;

  vector<int> res_inner = canonical_order(inner_set, inner_slope);
  vector<int> res_outer = canonical_order(outer_set, outer_slope);
  for (auto x : res_inner) res.push_back(x);
  res.push_back(v);
  for (auto x : res_outer) res.push_back(x);
  return res;
}


int main () {
  int n, m, a,b;
  cin >> n >> m;
  for (int i=1; i<=m; i++) {
    cin >> a >> b;
    G[a].push_back(b);
    G[b].push_back(a);
  }
  int v = 1;
  int u = G[1][0];
  Slope slope = Slope(v, u);
  vector<int> V;
  for (int i=1; i<=n; i++) {
    if (i != v && i != u) V.push_back(i);
  }
  Vset Set = Vset(V);
  cutCanonical[u]=true;
  cutCanonical[v]=true;
  vector<int> Canonical = canonical_order(Set, slope);
  cout << v << " " << u << " ";
  for (auto x : Canonical) cout << x << " ";
  cout << "\n";
}
