#include<bits/stdc++.h>
using namespace std;

const int INF=1000000000;


struct edge {
  bool back;
  int a, b;
  int lowpoint;
  int nr;
  edge (int a=0, int b=0, int nr=0, bool back=false, int lowpoint=INF)
    : a(a), b(b), back(back), lowpoint(lowpoint), nr(nr)
  {}

  bool operator = (edge e) {
    back=e.back;
    a=e.a;
    b=e.b;
    lowpoint= e.lowpoint;
    nr= e.nr;
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
      if (u != vprev && u != parents[v] ) { // each node that is not son in the intersection path or parent in dfs tree
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
  if (e2.lowpoint < b1.lowpoint && e1.lowpoint < b2.lowpoint) return true;
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
      cout << e.a << " " << e.b << " " << e.lowpoint << "\n";
  }
}

void printBack() {
  cout << "BACK\n";
  for (auto e : edges) {
    if (e.back) cout << e.a << " " << e.b << " " << e.lowpoint << "\n";
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
  if (succ) cout << "TAK\n";
  else cout << "NIE\n";
}
