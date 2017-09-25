#include "queue.h"

int main()
{
    Kolejka Q= inicjuj (3);
    while (true) {
        char c= getchar();
        if (c=='t') printf ("%lf\n", top (&Q));
        else if (c=='p') {
            double x;
            scanf ("%lf", &x);
            push (x, &Q);
        }
        else if (c=='P') pop (&Q);
        else if (c=='c') Clear (&Q);
        else if (c=='e') printf (Empty (&Q) ? "empty\n" : "not empty\n");
    }
}
