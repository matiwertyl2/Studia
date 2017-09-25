#include <stdio.h>
#include <stdbool.h>


int A[10011];
int B[10011];
int ile[10000001];

int main () {
    int n, m;
    bool ok=true;
    scanf ("%d%d", &n, &m);
    if (n>10000) {
        ok=false;
        printf ("\nError: size of input table out of range;\n");
        printf (" must be between 1 and %d (inclusive).\n", 10000);
    }
    else if (m>n) {
        ok=false;
        printf ("\nError: cardinality of key set out of range;\n");
        printf (" must be between 1 and %d (inclusive).\n", n);
    }
    if (ok==true) {
        for (int i=1; i<=n; i++) {
             scanf ("%d", &A[i]);
        }
        if (ok==true) {
            for (int i=1; i<=n; i++) {
                if (A[i]>=m) {
                    ok=false;
                    printf ("\nError: value of element of input data out of range;\n");
                    printf (" must be between 0 and %d (inclusive).\n", m-1);
                    break;
                }
            }
            if (ok==true) {
                for (int i=1; i<=n; i++) {
                    ile[A[i]]++;
                }

                int pos=1;
                for (int i=0; i<m; i++) {
                    for (int j=1; j<=ile[i]; j++) {
                        B[pos]=i;
                        pos++;
                    }
                }

                printf ("Tablica nieposortowana:\n\n");
                for (int i=1; i<=n; i++) printf ("%d ", A[i]);
                printf ("\n\nTablica posortowana:\n\n");
                for (int i=1; i<=n; i++) printf ("%d ", B[i]);
            }
        }
    }
}
