//Mateusz Hazy
#include "deque.h"
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>


wezel * create_node () {
    wezel * res= (wezel *)malloc (sizeof (wezel));
    res->prev=NULL;
    res->next=NULL;
    return res;
}

Kolejka  Q_create () {
    return NULL;
}

bool Empty (Kolejka Q) {
    if (Q==NULL) return true;
    return false;
}

void Push_back (Kolejka * Q, double x) {
    if (Empty (*Q)==false) {
        wezel * back= (*Q)->prev;
        back->next= create_node ();
        if (back->next==NULL) {
            printf ("nie przydzielono pamieci\n");
            exit (1);
        }
        wezel * nowy= back->next;
        nowy->next= *Q;
        nowy->prev= back;
        nowy->x=x;
        (*Q)->prev=nowy;
    }
    else {

        (*Q)=create_node();
         if ((*Q)==NULL) {
            printf ("nie przydzielono pamieci\n");
            exit (1);
        }
        (*Q)->next=*Q;
        (*Q)->prev=*Q;
        (*Q)->x=x;
    }
}

void Push_front (Kolejka *Q, double x) {
    if (Empty (*Q)==false) {
        wezel * glowa= (*Q);
        wezel * back = (*Q)->prev;
        glowa->prev= create_node ();
        if (glowa->prev==NULL) {
            printf ("nie przydzielono pamieci\n");
            exit (1);
        }
        wezel * nowy= glowa->prev;
        nowy->x=x;
        nowy->next=glowa;
        nowy->prev=back;
        back->next=nowy;
        (*Q)=nowy;
    }
    else {
        (*Q)=create_node();
        if ((*Q)==NULL) {
            printf ("nie przydzielono pamieci\n");
            exit (1);
        }
        (*Q)->next=*Q;
        (*Q)->prev=*Q;
        (*Q)->x=x;
    }
}

void Pop_back (Kolejka *Q) {
    if (Empty (*Q)==false) {
        wezel * back = (*Q)->prev;
        if (back==(*Q)) {
            (*Q)=NULL;
        }
        else {
            (*Q)->prev=back->prev;
            back->prev->next=(*Q);
        }
        free (back);

    }
}

void Pop_front (Kolejka *Q) {
    if (Empty(*Q)==false) {
        wezel * glowa= (*Q);
        if (glowa->prev==glowa) {
            (*Q)=NULL;
        }
        else {
            glowa->next->prev=glowa->prev;
            glowa->prev= glowa->next;
            (*Q)=glowa->next;
        }
        free (glowa);
    }
}

double Front (Kolejka * Q) {
    if (Empty (*Q)) return NAN;
    return (*Q)->x;
}


double Back (Kolejka * Q) {
    if (Empty (*Q)) return NAN;
    return (*Q)->prev->x;
}

int length (Kolejka *Q) {
    if (Empty(*Q)==true) return 0;
    wezel * tu= (*Q)->next;
    int res=1;
    while (tu!=(*Q)) {
        res++;
        tu=tu->next;
    }
    return res;
}

void Clear (Kolejka *Q) {
    while (Empty(*Q)==false ) Pop_back (Q);
}
Kolejka Merge (Kolejka * A, Kolejka * B) {
    if (Empty (*B)==true) return (*A);
    if (Empty (*A)==true) return (*B);
    wezel * f1= (*A);
    wezel * f2= (*B);
    wezel * b1= f1->prev;
    wezel * b2= f2->prev;
    f1->prev= b2;
    b1->next= f2;
    f2->prev= b1;
    b2->next= f1;
    Kolejka Q= f1;
    return Q;
}

Kolejka Copy (Kolejka * A) {
    Kolejka Q= Q_create();
    int d= length (A);
    if (d==0) return Q;
    Q= create_node ();
    wezel * pos= Q;
    wezel * nowy;
    wezel * a= (*A);
    pos->x= a->x;
    for (int i=1; i<d; i++) {
        a=a->next;
        nowy= create_node();
        nowy->x= a->x;
        pos->next=nowy;
        nowy->prev=pos;
        pos=nowy;
    }
    nowy->next=Q;
    Q->prev=nowy;
    return Q;
}

void Insert (Kolejka *Q, double a) {
    if (Empty (*Q)==true) {
        Push_back (Q, a);
    }
    else if (a>= (*Q)->prev->x) {
        Push_back (Q, a);
    }
    else if (a<(*Q)->x) {
        Push_front (Q, a);
    }
    else {
        wezel *pos=(*Q);
        while (true) {
            if (pos->x>a) break;
            pos=pos->next;
        }
        wezel * nast= pos;
        pos=pos->prev;
        pos->next= create_node();
        wezel * nowy= pos->next;
        nowy->x=a;
        nowy->prev=pos;
        nowy->next=nast;
        nast->prev=nowy;
    }
}

void wypisz (Kolejka * Q) {
    if (Empty (*Q)==false) {
        wezel * pos= (*Q);
        printf ("%lf ", pos->x);
        pos=pos->next;
        while (pos!=(*Q)) {
            printf ("%lf ", pos->x);
            pos=pos->next;
        }
        printf ("\n");
    }
    else printf ("empty\n");
}

























