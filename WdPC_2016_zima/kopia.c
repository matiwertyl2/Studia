#include <gtk/gtk.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <math.h>

const int SIZE_OF_BOARD =20;
const int SIZE_OF_GRID= 13;
const int INIT_WALLS= 3;

typedef struct Pole {
  int x, y;
  GtkWidget* button;
}pole;

typedef struct Gracz {
  int sciany; // ile zostalo scian
  pole * pozycja; // pozycja gracza na planszy
  char znak[100]; // nazwa gracza
  int win; // rzad wygrywajacy dla gracza
  GtkWidget * label_sciany; // label informujacy o stanie scian
}gracz;

pole * plansza[100][100];
bool sciany[100][100];
bool used[100][100];
pole * zajete;
gracz * A;
gracz * B;
GtkWidget * tytul;
GtkWidget * polecenia_rozgrywki;
GtkWidget * scianyA;
GtkWidget * scianyB;

void init_players () {
  A= (gracz*)malloc (sizeof (gracz));
  B= (gracz*)malloc (sizeof (gracz));
  sprintf (A->znak, "A");
  sprintf (B->znak, "B");
  A->sciany=INIT_WALLS;
  B->sciany=INIT_WALLS;
  A->pozycja= plansza[0][SIZE_OF_GRID/2];
  B->pozycja=plansza[SIZE_OF_GRID-1][SIZE_OF_GRID/2];
  A->win=SIZE_OF_GRID-1;
  B->win=0;
  A->label_sciany= scianyA;
  B->label_sciany= scianyB;
  gtk_button_set_label (GTK_BUTTON(A->pozycja->button), A->znak);
  gtk_button_set_label (GTK_BUTTON(B->pozycja->button), B->znak);
}

int mini (int x, int y) {
  if(x<y) return x;
  return y;
}

bool miedzy_sciana (pole * P1, pole * P2) {
  if (P1->x==P2->x) {
    if (sciany[P1->x][mini (P1->y, P2->y)+1]==false) return false;
    return true;
  }
  else {
    if (sciany[mini (P1->x, P2->x)+1][P1->y]==false) return false;
    return true;
  }
}

bool pola_sasiednie (pole * P1, pole * P2) {
  if (abs (P1->x-P2->x)==2 && abs (P1->y-P2->y)==0) return true;
  if (abs (P1->x-P2->x)==0 && abs (P1->y-P2->y)==2) return true;
  return false;
}

bool zwyciestwo () {
  if (A->pozycja->x== A->win) return true;
  return false;
}

void clear_used () {
  for (int i=0; i<SIZE_OF_GRID+2; i++) {
    for (int j=0; j<SIZE_OF_GRID+2; j++) {
      used[i][j]=false;
    }
  }
}

void wypelnij () {
  for (int i=0; i<SIZE_OF_GRID+2; i++) {
    for (int j=0; j<SIZE_OF_GRID+2; j++) {
      sciany[i][j]=true;
    }
  }
}

bool dfs (pole * P, gracz * player) { // sprawdza czy gracz moze dojsc do sowjej pozycji wygrywajacej
  used[P->x][P->y]=true;
  if (P->x== player->win) return true;
  pole *gora, *dol, *lewo, *prawo;
  if (P->x-2>=0) {
    gora= plansza[P->x-2][P->y];
    if (miedzy_sciana (P, gora)==false &&  used[gora->x][gora->y]==false) {
	if (dfs (gora, player)==true) return true;
    }
  }
  if (P->y+2<SIZE_OF_GRID) {
    prawo=plansza[P->x][P->y+2];
    if (miedzy_sciana (P, prawo)==false && used[prawo->x][prawo->y]==false ){
      if (dfs (prawo, player)==true) return true;
    }
  }
  if (P->x+2<SIZE_OF_GRID) {
    dol=plansza[P->x+2][P->y];
    if (miedzy_sciana (P, dol)==false && used[dol->x][dol->y]==false) {
      if (dfs (dol, player)==true) return true;
    }
  }
  if (P->y-2>=0) {
    lewo= plansza[P->x][P->y-2];
    if (miedzy_sciana (P, lewo)==false && used[lewo->x][lewo->y]==false) {
      if (dfs (lewo, player)==true) return true;
    }
  }
  return false;
}

bool czy_blokuje (pole * P1, pole * P2) { // czy postawienie sciany uniemozliwi zwyciestwo ktoremukolwiek z graczy
  sciany[P1->x][P1->y]=true;
  sciany[P2->x][P2->y]=true;
  bool a= dfs (A->pozycja, A);
  clear_used();
  bool b= dfs (B->pozycja, B);
  clear_used();
  sciany[P1->x][P1->y]=false;
  sciany[P2->x][P2->y]=false;
  if (a==true && b==true) return false;
  return true;
}

bool dozwolony_ruch (pole * P) {
  if (P==B->pozycja) return false;
  if (pola_sasiednie (P, A->pozycja)==true) {
     if (miedzy_sciana (P, A->pozycja)==false) return true;
     return false;
  }
  //przeskok przeciwnika
  if (pola_sasiednie (P, B->pozycja)==true && pola_sasiednie (A->pozycja, B->pozycja)==true && (P->x==A->pozycja->x || P->y==A->pozycja->y) ) {
    if (miedzy_sciana (P, B->pozycja)==false && miedzy_sciana (B->pozycja, A->pozycja)==false) return true;
    return false;
  }
  return false;
}

bool dozwolona_sciana_pionowa ( pole * P) {
  if (A->sciany==0) return false;
  if (sciany[P->x][P->y]==false && P->x+2<SIZE_OF_GRID && sciany[P->x+2][P->y]==false) {
    pole * Pdolne= plansza[P->x+2][P->y];
    if (czy_blokuje (P, Pdolne)==false) return true;
    return false;
  }
  return false;
}

bool dozwolona_sciana_pozioma (pole * P) {
  if (A->sciany==0) return false;
  if (sciany[P->x][P->y]==false && P->y+2<SIZE_OF_GRID && sciany[P->x][P->y+2]==false) {
    pole * Pbok=plansza[P->x][P->y+2];
    if (czy_blokuje (P, Pbok)==false )return true;
    return false;
  }
  return false;
}

void uaktualnij_labele () {
  char polecenie[100];
  sprintf (polecenie, "Ruch gracza %s", A->znak);
  gtk_label_set_text (GTK_LABEL(polecenia_rozgrywki), polecenie);
  sprintf (polecenie, "Ściany %s: %d", A->znak, A->sciany);
  gtk_label_set_text (GTK_LABEL(A->label_sciany), polecenie);
  sprintf (polecenie, "Ściany %s: %d", B->znak, B->sciany);
  gtk_label_set_text (GTK_LABEL(B->label_sciany), polecenie);
}

void przesun_gracza (pole * P) {
  gtk_button_set_label (GTK_BUTTON(P->button), A->znak);
  gtk_button_set_label (GTK_BUTTON(A->pozycja->button), "");
  A->pozycja=P;
 
}

void postaw_sciane_pionowa (pole * P ) {
  pole * Pdolne= plansza[P->x+2][P->y];
  A->sciany--;
  sciany[P->x][P->y]=true;
  sciany[Pdolne->x][Pdolne->y]=true;
  gtk_button_set_label (GTK_BUTTON(P->button), "|");
  gtk_button_set_label (GTK_BUTTON(Pdolne->button), "|");
}

void postaw_sciane_pozioma (pole * P) {
  pole * Pbok= plansza[P->x][P->y+2];
  A->sciany--;
  sciany[P->x][P->y]=true;
  sciany[Pbok->x][Pbok->y]=true;
  gtk_button_set_label (GTK_BUTTON(P->button), "-");
  gtk_button_set_label (GTK_BUTTON(Pbok->button), "-");
}

void zmiana_ruchu () {
  if (zwyciestwo ()==true) {
    wypelnij ();
    char koniec[100];
    sprintf (koniec, "KONIEC GRY, Wygrał gracz %s", A->znak);
    gtk_label_set_text (GTK_LABEL(polecenia_rozgrywki), koniec);
  }
  else {
    gracz * C= A;
    A=B;
    B=C;
    uaktualnij_labele();
  }
}

static void ruch_sciana_pionowa (GtkWidget *widget, gpointer data) {
  pole * P= (pole*)data;
  if (dozwolona_sciana_pionowa(P)==true) {
    postaw_sciane_pionowa (P);
    zmiana_ruchu ();
  }
}

static void ruch_sciana_pozioma (GtkWidget *widget, gpointer data) {
  pole *P= (pole*)data;
  if (dozwolona_sciana_pozioma (P)==true) {
    postaw_sciane_pozioma (P);
    zmiana_ruchu();
  }
}

static void ruch_pole (GtkWidget *widget, gpointer data) {
  pole * P = (pole*)data;
  if ( dozwolony_ruch (P)==true) {    
    przesun_gracza (P);
    zmiana_ruchu ();
  }
}

GtkWidget * new_button_sciana_pionowa (int x, int y) {
  GtkWidget * sciana;
  sciana= gtk_button_new_with_label ("");
  gtk_widget_set_size_request (sciana, SIZE_OF_BOARD, 4*SIZE_OF_BOARD);
  pole * P= (pole*)malloc(sizeof (pole));
  P->x=x;
  P->y=y;
  P->button=sciana;
  plansza[x][y]=P;
  g_signal_connect (sciana, "clicked", G_CALLBACK(ruch_sciana_pionowa), (gpointer)P);
  return sciana;
}


GtkWidget * new_button_sciana_pozioma (int x, int y) {
  GtkWidget * sciana;
  sciana= gtk_button_new_with_label ("");
  gtk_widget_set_size_request (sciana, 4*SIZE_OF_BOARD, SIZE_OF_BOARD);
  pole * P= (pole*)malloc(sizeof (pole));
  P->x=x;
  P->y=y;
  P->button=sciana;
  plansza[x][y]=P;
  g_signal_connect (sciana, "clicked", G_CALLBACK(ruch_sciana_pozioma), (gpointer)P);
  return sciana;
}

GtkWidget * new_button_pole (int x, int y) {
  GtkWidget * button;
  button= gtk_button_new_with_label ("");
  gtk_widget_set_size_request (button, 4*SIZE_OF_BOARD, 4*SIZE_OF_BOARD);
  pole * P= (pole*)malloc(sizeof (pole));
  P->x=x;
  P->y=y;
  P->button=button;
  plansza[x][y]=P;
  g_signal_connect (button, "clicked", G_CALLBACK(ruch_pole), (gpointer)P);
 
  return button;
} 

GtkWidget * new_button_puste (int x, int y) {
  GtkWidget * button;
  button= gtk_button_new ();
  gtk_widget_set_size_request (button, SIZE_OF_BOARD, SIZE_OF_BOARD);
  pole * P= (pole*)malloc(sizeof (pole));
  P->x=x;
  P->y=y;
  P->button=button;
  plansza[x][y]=P;
  return button;
}

GtkWidget * generuj_pole () {
  GtkWidget *grid;
  grid=gtk_grid_new();
  GtkWidget *button;
  gtk_grid_set_row_homogeneous (GTK_GRID(grid), FALSE);
  gtk_grid_set_column_homogeneous (GTK_GRID(grid), FALSE);
  for (int i=0; i<SIZE_OF_GRID; i++) {
    for (int j=0; j<SIZE_OF_GRID; j++) {
      if (i%2==0 && j%2==0) button= new_button_pole (i, j);
      else if (i%2==0 && j%2==1) button=new_button_sciana_pionowa (i, j);
      else if (i%2==1 && j%2==0) button=new_button_sciana_pozioma (i, j);
      else button= new_button_puste (i, j);
      gtk_grid_attach (GTK_GRID(grid), button, j, i, 1, 1);
    }
  }
  gtk_grid_set_row_homogeneous (GTK_GRID(grid), FALSE);
  gtk_grid_set_column_homogeneous (GTK_GRID(grid), FALSE);
  return grid;
}

GtkWidget * generuj_interfejs (GtkWidget * pole_do_gry) {
  GtkWidget *interfejs= gtk_box_new (GTK_ORIENTATION_VERTICAL, 0);
  GtkWidget *box_sciany= gtk_box_new (GTK_ORIENTATION_HORIZONTAL, 0);
  
  polecenia_rozgrywki= gtk_label_new ("Ruch gracza A");
  char polecenie[100];
  sprintf (polecenie, "Ściany A: %d", INIT_WALLS);
  scianyA= gtk_label_new (polecenie);
  sprintf (polecenie, "Ściany B: %d", INIT_WALLS);
  scianyB= gtk_label_new (polecenie);
  
  gtk_box_pack_start (GTK_BOX(box_sciany), scianyA, TRUE, TRUE, 0);
  gtk_box_pack_start (GTK_BOX(box_sciany), scianyB, TRUE, TRUE, 0);

  gtk_box_pack_start (GTK_BOX(interfejs), polecenia_rozgrywki, TRUE, TRUE, 0);
  gtk_box_pack_start (GTK_BOX(interfejs), box_sciany, TRUE, TRUE, 0);
  gtk_box_pack_start (GTK_BOX(interfejs), pole_do_gry, TRUE, TRUE, 0);
  return interfejs;
}



int main (int argc, char **argv) {
  gtk_init (&argc, &argv);
  GtkWidget *window = gtk_window_new (GTK_WINDOW_TOPLEVEL);
  gtk_window_set_title (GTK_WINDOW(window), "QUORIDOR");
  g_signal_connect (G_OBJECT (window), "destroy", G_CALLBACK (gtk_main_quit), NULL);
  GtkWidget *pole_do_gry= generuj_pole();
  GtkWidget * interfejs= generuj_interfejs (pole_do_gry);
  gtk_container_add (GTK_CONTAINER(window), interfejs);
  
  init_players ();
  
  
  gtk_widget_show_all(window);
  gtk_main();
}