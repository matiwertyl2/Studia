#include <bits/stdc++.h>
using namespace std;

int main() {
  cout << "szyfr = {\n";
  for (int i=0; i<26; i++) {
    char x= 'a'+i;
    char y= 'a'+i+1;
    cout << "'" << x << "'" << " => " << "'" << y << "'" << ",\n";
  }
  cout << "}\n";
}
