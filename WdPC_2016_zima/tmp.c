#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

char * wsk;
char *buf;
int n;
long L;
char C;

char zmien (char c) {
  if (c-'a'>=0 && c-'a'<26) {
    return 'A'+ c-'a';
  }
  return c;
}

void Print_Buffer () {
    for (int i=0; i<n; i++) putchar (*(buf+i));
    printf ("\n");
}

void Clear_Buffer (char *b) {
    for (int i=0; i<n; i++) {
        *(b+i)='0';
    }
}

char * Assign_Block (long l) {
    if (l>n || l<=0) {
      printf ("\nAssign_Block: wrong input data\n");
      exit (0);
    }
    char * pos=wsk;
    char * res= wsk;
    long d=0;
    for (int i=0; i<n; i++){
        if (*pos=='0')  d++;
        else {
            d=0;
            res=pos+1;
            if (res== buf+n) res=buf;
        }
        if (d==l) return res;
        pos++;
        if (pos==buf+n) {
	  pos=buf;
	  d=0;
	}
    }
    return NULL;

}

char * Find_Block (char c, long l) {
    if (l>n || l<=0) {
      printf ("\nFind_Block: wrong input data\n");
      exit (0);
    }
    char * pos=wsk;
    char * res= wsk;
    long d=0;
    for (int i=0; i<n; i++){
        if (*pos==c)  d++;
        else {
            d=0;
            res=pos+1;
            if (res== buf+n) res=buf;
        }
        if (d==l) return res;
        pos++;
        if (pos==buf+n) {
	  pos=buf;
	  d=0;
	}
    }
    return NULL;
}

void Set_Block (char *b, long l, char c) {
    if (l>n || b==NULL || l<=0) {
      printf ("\nSet_Block: wrong input data\n");
      exit (0);
    }
    while (l>0) { 
        *b=c;
        b++;
        l--;
        if (b== buf+n) b=buf;
    }
}

void Release_Block (char *b, long l) {
    if (l>n || b==NULL || l<=0) {
      printf ("\nRelease_Block: wrong input data\n");
      exit (0);
    }
    while (l>0) {
        *b='0';
        b++;
        l--;
        if (b==buf+n) b=buf;
    }
}

char * Relocate () {
    char * free= buf;
    for (int i=0; i<n; i++) {
        if (*(buf+i)!='0') {
            *free=*(buf+i);
            if (free!=(buf+i)) *(buf+i)='0';
            free++;
        }
    }
    if (free==buf+n) return NULL;
    return free;
}

void Output_Buffer_State () {
  char c= *buf;
  int d=1;
  for (int i=1; i<n; i++) {
    if (*(buf+i)==c) d++;
    else {
      printf ("%d", d);
      if (c!='0') putchar (c);
      else putchar ('*');
      printf (" ");
      d=1;
      c=*(buf+i);
    }
  }
  printf ("%d", d);
  if (c!='0') putchar (c);
  else putchar ('*');
}

void Process_Request () {
    if (scanf ("%ld", &L)==-1) {
      Output_Buffer_State ();
      exit(0);
    }
    else {
      C=getchar();
      C= zmien (C);
      if (L<0) {
	  wsk= Find_Block (C, -L);
	  if (wsk==NULL) {
	    printf ("\nFind_Block: wrong input data\n");
	    exit (0);
	  } 
	  Release_Block (wsk, -L);
      }
      else if (L>0) {
	  wsk=Assign_Block (L);
	  if (wsk==NULL) {
	    wsk=Relocate();
	    wsk=Assign_Block(L);
	  }
	  if (wsk==NULL) {
	    printf ("\nAssign_Block: wrong input data\n");
	    exit (0);
	  } 
	  Set_Block (wsk, L, C);
      }
      else {
	printf ("\nProcess_Request: zero length blocks not allowed\n");
	exit (0);
      }
    }
}


int main (){

    scanf ("%d", &n);
    char bufor[n];
    wsk= &bufor[0];
    buf=wsk;
    Clear_Buffer (wsk);
    while (true) {
        Process_Request ();
  }
}
