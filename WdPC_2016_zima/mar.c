#include <stdio.h>
#include <stdbool.h>

char convert (char x) {
  if (x-'a' >= 0 && x-'z'<=0) return x;
  if (x-'A'>=0 && x-'Z'<=0) {
    int c=x-'A';
    return 'a'+c;
  }
  return x;
}


int main () {
  char a, b, c, d, x;
  int n;
  scanf ("%d", &n);
  a=getchar();
  int ile=0;
  while (n--) {
    bool ok=false;
    a='#';
    b='#';
    c='#';
    d='#';
    while (a!='\n' && a!=EOF) {
      x=getchar();
      if (ok==false) {
	//x= convert (x);
	if (x=='b' || x=='p') x='d';
	else if (x=='s') x='g';
	else if (x=='c') x='y';
	d=c;
	c=b;
	b=a;
	a=x;
	if (b==c && a==d) ok=true;
	if (a==c) ok=true;
      }
      else a=x;
    }
    if (ok==true) ile++;
  }
  printf ("%d\n", ile);
}