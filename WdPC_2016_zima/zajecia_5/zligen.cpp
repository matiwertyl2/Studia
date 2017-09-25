#include <bits/stdc++.h>
using namespace std;


int main (int argc, char* argv[]) {
  srand (atoi (argv[1]);
  int n= rand () % 10000 +1;
  int m= rand () % n +1;
  cout << n << " " << m << "\n";
  for (int i=1; i<=n; i++) cout << rand() % m << " ";
}