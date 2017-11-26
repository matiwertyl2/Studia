#include<bits/stdc++.h>
using namespace std;

const int INF=1000000000;


struct edge {
  bool back;
  int a, b;
  int lowpoint;
  int nr;
  int direction;
  int nesting;
  edge (int a=0, int b=0, int nr=0, bool back=false, int lowpoint=INF)
    : a(a), b(b), back(back), lowpoint(lowpoint), nr(nr), direction(0), nesting(0)
  {}

  bool operator = (edge e) {
    back=e.back;
    a=e.a;
    b=e.b;
    lowpoint= e.lowpoint;
    nr= e.nr;
    direction=e.direction;
    nesting = e.nesting;
  }

  bool operator == (edge e) {
    return nr == e.nr;
  }

  bool operator != (edge e) {
    return !(nr == e.nr);
  }

  bool operator < (edge e) {
    return nr < e.nr;
  }

};



int branching_point(edge e1, edge e2);

vector<edge> edges; // directed edges of GD
vector<int> G[10000]; // input graph
bool usedG[10000]; // used for count-lowpoints
int depth[10000]; // depth of vertex in dfs tree
int lowpoints[10000]; // lowpoint for vertex
int parents[10000]; // parent in dfs tree
map < pair <int, int>, bool > DFStree; // whether edge a b belogs to dfs tree
map < pair <int, int>, edge > edgesMap; // map of edges

edge edge_parent (edge e) {
  return edgesMap[make_pair(parents[e.a], e.a)];
}

bool same_constraint(edge b1, edge b2) {
  int inter_start = max (b1.lowpoint, b2.lowpoint); // depth of beginning of cycles intersection
  int low = min(b1.lowpoint, b2.lowpoint);
  int vprev = branching_point(b1, b2);
  int v = parents[vprev];
  while (depth[v] > inter_start) { // conditions says that we have to check each vertex on the intersection
    for (auto u : G[v]) {
      if (u != vprev && u != parents[v] && edgesMap.find({v, u})!= edgesMap.end()) { // each node that is not son in the intersection path or parent in dfs tree
        edge e = edgesMap[make_pair(v, u)];
        if (e.lowpoint < low) {
          return true;
        }
      }
    }
    vprev = v;
    v = parents[v];
  }
  return false;
}

bool different_constraint(edge e1, edge e2, edge b1, edge b2) { // condition from article
  if (e2.lowpoint < b1.lowpoint && e1.lowpoint < b2.lowpoint) {
    cout << "DIFFERENT CONSTRAINT --------------------------------\n";
    return true;
  }
  return false;
}

bool cycle_overlap(const edge b1, const edge b2) {
  edge e1 = edgesMap[make_pair(parents[b1.a], b1.a)];
  edge e2 = edgesMap[make_pair(parents[b2.a], b2.a)];
  while (true) {
    int src1 = e1.a;
    int src2 = e2.a;
    if (depth[src1]==0 || depth[src2]==0) return false;
    if (depth[src1]< depth[b1.b]) return false;
    if (depth[src2]< depth[b2.b]) return false;
    if (src1 == src2) return true;
    if (depth[src1] > depth[src2] ) e1 = edge_parent(e1);
    else e2 = edge_parent(e2);
  }
}

edge fork_edge(edge e, int branch) {
  while (e.a != branch) e = edge_parent(e);
  return e;
}

int branching_point(edge e1, edge e2) {
  while (true) {
    int src1=e1.a;
    int src2=e2.a;
    if (src1==src2) return src1;
    if (depth[src1]>depth[src2]) e1 = edge_parent(e1);
    else e2 = edge_parent(e2);
  }
}

void calculate_lowpoints(int v, int par, int d) {
  usedG[v]=true;
  depth[v]=d;
  parents[v]=par;
  for (auto u : G[v]) {
    if (usedG[u]==false) { // lowpoint of tree edge
      DFStree[make_pair(v, u)]=true;
      calculate_lowpoints(u, v, d+1);
      int lowp= min (depth[par], lowpoints[u]);
      edge e(v, u, edges.size(), false, lowp);
      edgesMap[make_pair(v, u)]= e;
      edges.push_back(e);
    }
    else if (u != par && edgesMap.find(make_pair(u, v)) ==edgesMap.end() ) { // lowpoint of back edge
       edge e(v, u, edges.size(), true, depth[u]);
       edgesMap[make_pair(v, u)]=e;
       edges.push_back(e);
    }
  }
  int lowp = depth[v];
  for (auto u : G[v]) {
      if (DFStree[make_pair(v, u)]) lowp = min (lowp, lowpoints[u]);
      else lowp = min(lowp, depth[u]);
  }
  lowpoints[v]=lowp;
}


void printT() {
  cout << "TREE\n";
  for (auto e : edges) {
    if (e.back==false)
      cout << e.a << " " << e.b << " " << e.direction << "\n";
  }
}

void printBack() {
  cout << "BACK\n";
  for (auto e : edges) {
    if (e.back) cout << e.a << " " << e.b << " " << e.direction << "\n";
  }
}

void printG(int n) {
  cout<< "GRAPH\n";
  for (int i=1; i<=n; i++) {
    cout << i << " : ";
    for (auto u : G[i]) cout << u << " ";
    cout << "\n";
  }
}

vector< pair<int, int> > C[10000]; // first - nr, second - +/- 1, edge label - graph of constraints

bool create_graph_C () {
  for (auto b1 : edges) {
    for (auto b2 : edges) { // for each pair of back edges checking constraints
      if (b1 < b2  && b1.back && b2.back ) {
          if (cycle_overlap(b1, b2)) {
            // as described in article
            int b = branching_point(b1, b2);
            edge e1 = fork_edge(b1, b);
            edge e2 = fork_edge(b2, b);
            // conditions from article
            bool same = same_constraint(b1, b2);
            bool different = different_constraint(e1, e2, b1, b2);
            if (same && different) { // then graph is not planar
              return false;
            }
            if (same) {
              C[b1.nr].push_back(make_pair(b2.nr, 1));
              C[b2.nr].push_back(make_pair(b1.nr, 1));
            }
            else if (different) {
              C[b1.nr].push_back(make_pair(b2.nr, -1));
              C[b2.nr].push_back(make_pair(b1.nr, -1));
            }
          }
      }
    }
  }
  return true;
}


bool usedC[10000];
int color[10000];

bool is_C_balanced(int v, int c) { // almost like 2-coloring
  usedC[v]=true;
  color[v]=c;
  bool res=true;
  for (auto e : C[v]) {
    int u =e.first;
    int sign= e.second;
    if (usedC[u]==false) {
      if (sign==1) {
        if (is_C_balanced(u, c)==false) return false;
      }
      else {
        if (is_C_balanced(u, (c+1)% 2)==false) return false;
      }
    }
    else {
      if (sign==1 && color[u]!=color[v]) return false;
      if (sign==-1 && color[u]==color[v]) return false;
    }
  }
  return true;
}


//////////////////////////////////////////

// tree dir jest zle - to ma byc najnizszy cykl przez zadana krawedz
// nesting order of

bool belongs_to_cycle(edge dest, edge b) {
  edge e = edgesMap[{parents[b.a], b.a}];
  while (e.a != b.b) {
    if (e == dest) return true;
    e = edge_parent(e);
  }
  return e == dest;
}

pair<int,int> tree_dir (edge e) { // first - depth, second - direction
  pair<int, int> res = make_pair(0, 0);
/*  for (auto u : G[e.b]) {
    if (edgesMap.find({e.b, u})!= edgesMap.end()) {
      edge e1 = edgesMap[{e.b, u}];
      if (e1.back == false) {
        res= max (res, tree_dir(e1));
      }
      else {
        res = max (res, make_pair(e1.lowpoint, e1.direction));
      }
    }
  } */
  for (auto b : edges) {
    if (b.back && belongs_to_cycle(e, b)) {
      res = max (res, make_pair(b.lowpoint, b.direction));
    }
  }
  return res;
}

void assign_direction() {
  for (size_t i=0; i<edges.size(); i++) {
    edge e = edges[i];
    if (e.back) {
      e.direction=color[e.nr];
    }
    edgesMap[{e.a, e.b}]=e;
    edges[i]=e;
  }
  for (size_t i=0; i<edges.size(); i++) {
    edge e = edges[i];
    if(e.back==false) e.direction= tree_dir(e).second;
    edgesMap[{e.a, e.b}]=e;
    edges[i]=e;
  }
  for (auto e : edges)     cout << "e " << e.back << " " <<   e.a << " " << e.b << " " << e.direction << "\n";
}

vector<int> get_edge_return_points(edge e) {
  vector<int> res;
  for (auto u : G[e.b]) {
    if (edgesMap.find({e.b, u})!= edgesMap.end()) {
      edge e1 = edgesMap[{e.b, u}];
      if (e1.back) res.push_back(e1.b);
      else {
        vector<int> restmp= get_edge_return_points(e1);
        for (auto r : restmp) res.push_back(r);
      }
    }
  }
  return res;
}

bool is_chordal(edge e) { // has more than one return points
  vector<int> return_points = get_edge_return_points(e);
  sort(return_points.begin(), return_points.end());
  for (size_t i=1; i<return_points.size(); i++) {
    if (return_points[i]!=return_points[i-1]) return true;
  }
  return false;
}

void count_nesting_numbers() {
  for (size_t i=0; i<edges.size(); i++) {
    edge e= edges[i];
    if (e.back) {
      e.nesting= e.lowpoint*2;
    }
    else {
      e.nesting= e.lowpoint*2;
      if (is_chordal(e)) e.nesting++;
    }
    edges[i]=e;
    edgesMap[{e.a, e.b}]=e;
  }
  cout << "NESTING NUMBERS\n";
  for (auto e : edges) {
    cout << e.a << " " << e.b << " " << e.nesting << "\n";
  }
}

vector<int> get_incoming_edges(int src, edge e, int dir) {
  vector<int> res;
  res.clear();
  if (e.back) return res;
  for (auto u : G[e.b]) {
    if (edgesMap.find({e.b, u}) != edgesMap.end()) {
      edge e1 = edgesMap[{e.b, u}];
      if (e1.back) {
        if (e1.b == src && e1.direction == dir) res.push_back(e1.a);
      }
      else {
        vector<int> restmp = get_incoming_edges(src, e1, dir);
        for (auto r : restmp ) res.push_back(r);
      }
    }
  }
  return res;
}

bool cmp(edge b1, edge b2) { // comparing list of incoming edges for sorting L and R in Nest
  int branch = branching_point(b1, b2);
  edge e1 = fork_edge(b1, branch);
  edge e2 = fork_edge(b2, branch);
  // moze to naprawi
  if (e1.direction != e2.direction ) {
    return e1.direction > e2.direction;
  }
  return e1.nesting < e2.nesting;
}

struct Nest {
  int src;
  int nest;
  int v;
  vector<int> L;
  vector<int> R;

  Nest (int src, int v, int nest, vector<int>& EL, vector<int>& ER )
    : src(src), v(v), nest(nest)
  {
    vector<edge> EdgeL;
    vector<edge> EdgeR;
    for (auto p : EL) EdgeL.push_back(edgesMap[{p, src}]);
    for (auto p : ER) EdgeR.push_back(edgesMap[{p, src}]);
    sort (EdgeL.begin(), EdgeL.end(), cmp);
    sort(EdgeR.begin(), EdgeR.end(), cmp);
    reverse(R.begin(), R.end());
    for (auto e : EdgeL) L.push_back(e.a);
    for (auto e : EdgeR) R.push_back(e.a);
  }

  bool operator = (Nest n) {
    src= n.src;
    v=n.v;
    nest = n.nest;
    L.clear();
    R.clear();
    for (auto p : n.L) L.push_back(p);
    for (auto p : n.R) R.push_back(p);
  }

  bool operator < (Nest n) const {
    return nest < n.nest;
  }
};

void add_nest_to_sorted(Nest n, vector<int>& sorted) {
  for (auto v : n.L) sorted.push_back(v);
  sorted.push_back(n.v);
  for (auto v : n.R ) sorted.push_back(v);
}

void clockwise_sort(int v) {
  // first - nesting order, second - node number
  vector<Nest> L; // left edges
  vector<Nest > R; // right edges
  vector<int> sorted;
  cout << "SORT OF " << v << "\n";
  for (auto u : G[v]) {
    if (edgesMap.find({v, u}) != edgesMap.end()) {
      edge e = edgesMap[{v, u}];
      vector<int> EL = get_incoming_edges(v, e, 0);
      vector<int> ER = get_incoming_edges(v, e, 1);
      cout << EL.size() << " " << ER.size() << "\n";
      if (e.direction == 0) {
        L.push_back(Nest(v, u, e.nesting, EL, ER));
      }
      else {
        R.push_back(Nest(v, u, e.nesting, EL, ER));
      }
    }
    else { // soruce edge
      if (u == parents[v]) sorted.push_back(u);
    }
  }
  cout << L.size() << " " << R.size() << "\n";
  sort(L.begin(), L.end());
  reverse(L.begin(), L.end());
  sort(R.begin(), R.end());
  for (auto p : L) add_nest_to_sorted(p, sorted);
  for (auto p : R) add_nest_to_sorted(p, sorted);
  G[v].clear();
  for (auto u : sorted) G[v].push_back(u);
}

//////////////////////////////////////////////////////////////////////////////
struct face {
  int nr;
  vector<int> V;

  face(int nr, vector<int>& Vec)
    : nr(nr)
  {
    for (auto v : Vec) V.push_back(v);
  }

  void operator = (face f) {
    nr=f.nr;
    V.clear();
    for (auto v : f.V) V.push_back(v);
  }

  void print() {
    cout << nr << " : ";
    for (auto v : V) cout << v << " ";
    cout << "\n";
  }

};

vector<face> faces;
map < pair<int, int> , bool> usedClockwise;
map <pair<int, int>, bool> usedCounterClockwise;

void make_used(int a, int b, int dir) {
  if (a> b) swap(a, b);
  if (dir == 0) {
    usedClockwise[{a, b}]=true;
  }
  else usedCounterClockwise[{a,b}]=true;
}

bool is_used(int a, int b, int dir) {
  if (a> b) swap(a, b);
  if (dir==0) {
    if (usedClockwise[{a, b}]==false) return false;
    else return true;
  }
  else {
    if (usedCounterClockwise[{a, b}]==false) return false;
    return true;
  }
}

int next_face_edge(int v, int u, int dir) {
  int pos;
  for (size_t i=0; i< G[u].size(); i++) {
    if (G[u][i]==v) {
      pos = i;
      break;
    }
  }
  if (dir == 0) {
    return G[u][(pos+1 + G[u].size()) % G[u].size()];
  }
  return G[u][(pos-1+ G[u].size()) % G[u].size()];
}

face get_face(int v, int u, int dir) {
  vector<int> cycle;
  int prew = v;
  cycle.push_back(v);
  //make_used(v, u, dir);
  while (u != v) {
    cycle.push_back(u);

    int utmp = next_face_edge(prew, u, dir);
    prew = u;
    u = utmp;
    //fmake_used(prew, u, dir);
  }
  return face(faces.size(), cycle);
}

void find_faces(int n) {
  for (int v=1; v<=n; v++) {
    for (auto u : G[v]) {
        faces.push_back(get_face(v, u, 0));
        faces.push_back(get_face(v, u, 1));
    }
  }
}

bool is_same_face(face f1, face f2) {
  vector<int> V1, V2;
  for (auto f : f1.V) V1.push_back(f);
  for (auto f : f2.V) V2.push_back(f);
  if (V1.size() != V2.size()) return false;
  sort(V1.begin(), V1.end());
  sort(V2.begin(), V2.end());
  for (size_t i=0; i<V1.size(); i++) {
    if (V1[i]!=V2[i]) return false;
  }
  return true;
}


void remove_duplicates() {
  vector<face> F;
  for (auto f1 : faces) {
    bool ok =true;
    for (auto f2 : F) {
      if (is_same_face(f1, f2)) ok=false;
    }
    if (ok) F.push_back(f1);
  }
  faces.clear();
  for (auto f : F) faces.push_back(f);
}





int main () {
  int n, m, a, b;
  cin >> n >> m;
  for (int i=1; i<=n; i++) lowpoints[i]=INF;
  for (int i=1; i<=m; i++) {
    cin >> a >> b;
    G[a].push_back(b);
    G[b].push_back(a);
  }
  calculate_lowpoints(1, 0, 0);

  bool succ = create_graph_C();
  if (succ) {
    for (int i=0; i<=m; i++) {
      if (C[i].size()!=0 && usedC[i]==false) succ = is_C_balanced(i, 0);
      if (succ==false) break;
    }
  }
  if (succ) {
    cout << "TAK\n";
    assign_direction();
    count_nesting_numbers();
    for (int i=1; i<=n; i++) clockwise_sort(i);
    printT();
    printBack();
    printG(n);
    find_faces(n);
    remove_duplicates();
    cout << "FACES\n";
    for (auto f : faces) {
      f.print();
    }
  }
}
