#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>


int K[10][10];
bool used[100];
int S;
int n, k;
int ile=0;
bool juz=false;

void wypisz () {
    ile++;
    for (int i=1; i<=n; i++) {
        for (int j=1; j<=n; j++) printf ("%d ", K[i][j]);
        printf ("\n");
    }
    printf ("\n");
}

bool sprawdz () {
    int s1=0, s2=0;
    for (int i=1; i<=n; i++) {
        s1+=K[i][i];
        s2+=K[i][n-i+1];
    }
    if (s1!=S || s2!=S) return false;
    return true;
}

bool sprawdzkol (int x) {
    int sum=0;
    for (int i=1; i<=n; i++) sum+=K[i][x];
    if (sum!=S) return false;
    return true;

}

bool kwadrat (int x, int y, bool used[], int sum) {
    if (juz==true) return false;
    if (y==n && sum<S) return false;
    if (sum>S) return false;
    if (x==n) {
        if ( sprawdzkol (y)==false) return false;
    }
    if (x==n && y==n) return sprawdz();
    if (y==n) {
        sum=0;
        x++;
        y=0;
    }
    for (int i=1; i<=n*n; i++) {
        if (used[i]==false) {
            used[i]=true;
            K[x][y+1]=i;
            sum+=i;
            bool ok= kwadrat (x, y+1, used, sum);
            if (ok==true) {
		printf ("%d %d\n", x, y);
                wypisz ();
                if (ile==k) juz=true;
            }
            used[i]=false;
            K[x][y+1]=0;
            sum-=i;
        }
    }
    return false;
}


int main (int argc, char *argv[]) {
    if (argc<3) {
        printf ("podaj n i k");
        return 0;
    }
    n= atoi (argv[1]);
    k= atoi (argv[2]);
    S= n* (n*n+1)/2;
    bool res= kwadrat (1, 0, used, 0);
    if (res==true) printf ("koniec\n");
}



