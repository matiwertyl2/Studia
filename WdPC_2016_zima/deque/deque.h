//Mateusz Hazy
#include <stdbool.h>

typedef struct vertex {
    struct vertex * prev;
    struct vertex * next;
    double x;
}wezel;

typedef wezel* Kolejka;

wezel * create_node ();
Kolejka Q_create ();
void Push_back (Kolejka * Q, double x);
void Push_front (Kolejka *Q, double x);
bool Empty (Kolejka Q);
double Front (Kolejka * Q);
double Back (Kolejka * Q);
void Pop_back (Kolejka *Q);
void Pop_front (Kolejka *Q);
int length (Kolejka *Q);
Kolejka Merge (Kolejka * A, Kolejka * B);
Kolejka Copy (Kolejka *A);
void Insert (Kolejka *Q, double a);
void wypisz (Kolejka * Q);
void Clear (Kolejka *Q);









