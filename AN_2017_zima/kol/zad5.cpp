#include<bits/stdc++.h>
using namespace std;

long long sil(long long n) {
  long long res=1;
  for (long long i =1 ; i<=n; i++) res*= i;
  return res;
}

long long newton(long long n, long long k) {
  return sil(n)/sil(n-k)/sil(k);
}

long long pow(long long a, long long x) {
  long long res=1;
  for (int i=1; i<=x; i++) {
    res*=a;
  }
  return res;
}

long long elem(long long n, long long k) {
  return pow(-1, k)*newton(n-1, k)*pow(n-k, n);
}



int main () {
  long long s=0, n;
  cin >> n;
  for (long long k=0; k<n; k++) {
    s+= elem(n, k);
  }
  cout << 2*s << " " << sil(n+1) << "\n";
}
