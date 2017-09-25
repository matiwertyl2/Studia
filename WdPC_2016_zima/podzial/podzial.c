//Mateusz Hazy
#include <stdio.h>
#include <stdlib.h>
#include <string.h>


char * znajdz_roz (char * s) {
    char * kropka= strrchr (s, '.');
    char * slasz= strrchr (s, '/');
    if (kropka==NULL) return NULL;
    (*kropka)= '\0';
    if (slasz==NULL || slasz<kropka) {
      return kropka+1;
      
    }
    
    return NULL;
}

int main (int argc, char * argv[]) {
    if (argc==1) {
        printf ("nalezy podac argumenty\n");
        return 0;
    }
    char *slowne= argv[1];
    char ch;
    if (strcmp (slowne, "-t")==0) {
        if (argc<4) {
            printf ("za malo argumentow\n");
            return 0;
        }
        char *plik= argv[2];
        int d= atoi (argv[3]);
        FILE * f= fopen(plik, "r");
        if (f==NULL) {
            printf ("Plik sie nie otwiera\n");
            return 0;
        }
        char *rozszerzenie= znajdz_roz (plik);
	char roz[10];
        if (rozszerzenie==NULL) {
	  sprintf (roz, "txt");
	  rozszerzenie=roz;
	}
        ch=getc (f);
        int ile_wierszy=0;
        while (ch!=EOF) {
            if (ch=='\n') ile_wierszy++;
            ch=getc (f);
        }
        rewind (f);
        int n= ile_wierszy/d;
        for (int i=1; i<=d; i++) {
            char nazwa[100];
            sprintf (nazwa, "%s-%02d.%s", plik, i, rozszerzenie);
            FILE * nowy= fopen(nazwa, "w");
            int x= n;
	    if (i<= (ile_wierszy % d)) x++;
            while (x>0) {
                ch= getc (f);
                if (ch==EOF) break;
                if (ch=='\n') x--;
                putc (ch, nowy);
            }
            fclose (nowy);
        }
    }
    else {
        if (argc<3) {
            printf ("za malo argumentow\n");
            return 0;
        }
        char *plik= argv[1];
        int d= atoi (argv[2]);
        FILE * f= fopen (plik, "r");
        if (f==NULL) {
            printf ("Plik sie nie otwiera\n");
            return 0;
        }
        char *rozszerzenie= znajdz_roz (plik);
	char roz[10];
        if (rozszerzenie==NULL) {
	  sprintf (roz, "txt");
	  rozszerzenie=roz;
	}
	
        ch=getc (f);
        int ile_bajtow=0;
        while (ch!=EOF) {
            ile_bajtow++;
            ch=getc (f);
        }
        rewind (f);
        int n=ile_bajtow/d;
        for (int i=1; i<=d; i++) {
            char nazwa[100];
            sprintf (nazwa, "%s-%02d.%s",plik,  i, rozszerzenie);
            FILE * nowy= fopen (nazwa, "w");
            int x=n;
	    if (i<= (ile_bajtow % d)) x++;
            while (x>0) {
                ch= getc (f);
                if (ch==EOF) break;
                putchar (ch);
                x--;
                putc (ch, nowy);
            }
            fclose (nowy);
        }
    }
}










