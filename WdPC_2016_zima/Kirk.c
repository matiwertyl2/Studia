#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>

int used[112][111][4]; // 0 gora 1 prawo 2 dol 3 lewo
int tab[111][111];
bool res[121][111];
char sek[111];

int p, l, n, m;

void dfs (int x, int y, int ruch, int d) {
  if ( x>0 && x<=n && y>0 && y<=m && d<=p) {
    if (ruch==l && d==p) res[x][y]=1;
    else {
      bool ok=false;
      if (sek[ruch]=='?') {
	ok=true;
      }
   //   cout << x << " " << y << " " << ruch << " " << d << "\n";
      if (sek[ruch]=='G' || ok==true) {
	if (tab[x-1][y]==1 && used[x][y][0]==false) {
	  used[x][y][0]=true;
	  dfs (x-1, y, ruch+1, d+1);
	  used[x][y][0]=false;
	}
      }
      if (sek[ruch]=='P' || ok==true) {
	if (tab[x][y+1]==1 && used[x][y][1]==false) {
	  used[x][y][1]=true;
	  dfs (x, y+1, ruch+1, d+1);
	  used[x][y][1]=false;
	}
      }
      if (sek[ruch]=='D' || ok==true) {
	if (tab[x+1][y]==1 && used[x][y][2]==false) {
	  used[x][y][2]=true;
	  dfs (x+1, y, ruch+1, d+1);
	  used[x][y][2]=false;
	}
      }
      if (sek[ruch]=='L' || ok==true) {
	if (tab[x][y-1]==1 && used[x][y][3]==false) {
	  used[x][y][3]=true;
	  dfs (x, y-1, ruch+1, d+1);
	  used[x][y][3]=false;
	}
      }
      if (sek[ruch]=='S' || ok==true) {
	  dfs (x, y, ruch+1, d);
	
      }
    }
  }
}

void clear (int n, int m) {
  for (int i=1; i<=n; i++) {
    for (int j=1; j<=m; j++) {
      used[i][j][0]=false;
      used[i][j][1]=false;
      used[i][j][2]=false;
      used[i][j][3]=false;
    }
  }
}

int main () {
  char c;
  scanf ("%d%d", &m, &n);
  c=getchar();
  for (int i=1; i<=n; i++) {
    for (int j=1; j<=m; j++) {
      c=getchar();
      if (c=='.') tab[i][j]=1;
    }
    c=getchar();
  }
  scanf ("%d%d", &p, &l);
  c=getchar();
  for (int i=0; i<l; i++) {
    c=getchar();
    sek[i]=c;
    
  }
  for (int i=1; i<=n; i++) {
    for (int j=1; j<=m; j++) {
      if (tab[i][j]==1) {
	dfs (i, j, 0, 0);
	clear (n, m);
      }
    }
  }
  for (int i=1; i<=n; i++) {
    for (int j=1; j<=m; j++) {
      if (tab[i][j]==0) printf ("#");
      else {
	if (res[i][j]==true) printf ("X");
	else printf (".");
      }
    }
    printf ("\n");
  }
}







