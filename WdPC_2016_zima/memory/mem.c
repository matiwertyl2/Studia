#include <gtk/gtk.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

typedef struct Gracz {
    GtkWidget * label_pkt;
    int pkt;
    char imie[100];
}gracz;

typedef struct Pole {
    int x, y;
    GtkWidget * button;
    bool uzyte;
    int label;
}pole;

void pierwszy_ruch (pole * P);
void drugi_ruch (pole * P);
void init_players ();
void zmiana_ruchu ();
gboolean zakonczenie_ruchu ();
bool koniec_gry();
void losuj_permutacje(int k);
static void pole_klik (GtkWidget * widget, gpointer data);
GtkWidget * new_pole (int x, int y, bool wczytane);
GtkWidget * generuj_plansze_gry (bool wczytane);
static void save (GtkWidget * widget, gpointer data);
static void back_to_main (GtkWidget * widget, gpointer data);
static void start_game (GtkWidget * widget, gpointer data);
static void load_game (GtkWidget * widget, gpointer data);
static void settings_panel (GtkWidget * widget, gpointer data);
static void set_size4x4 (GtkWidget * widget, gpointer data);
static void set_size6x6 (GtkWidget * widget, gpointer data);
static void set_size8x8 (GtkWidget * widget, gpointer data);
static void set_easy (GtkWidget * widget, gpointer data);
static void set_medium (GtkWidget * widget, gpointer data);
static void set_hard (GtkWidget * widget, gpointer data);
GtkWidget * generuj_okienko_glowna ();
GtkWidget * generuj_okienko_gry (bool od_zera);
void basic_settings();

gracz * A = NULL;
gracz * B = NULL;
GtkWidget * aktywne_okienko;
GtkWidget * czyj_ruch;
pole * plansza[100][100];
int ruch;
int size1, size2, hard_level;
int permutacja[1000];
long long czas;
bool gra;
char map[32][100]={{"0.png"}, {"1.png"}, {"2.png"}, {"3.png"}, {"4.png"}, {"5.png"}, {"6.png"}, {"7.png"}, {"8.png"},};

pole * pierwszy; // pierwszy klikniety
pole * drugi; // drugi klikniety

void losuj_permutacje(int k)
{
    for(int i=0; i<1000; i++)
        permutacja[i]=0;
    for(int i=0; i<k; i++)
        permutacja[i]=i+1;
    for (int i = k-1; i >= 0; --i)
    {
        int j = rand() % (i+1);
        int temp = permutacja[i];
        permutacja[i] = permutacja[j];
        permutacja[j] = temp;
    }
}

bool koniec_gry()
{
    for(int i=0; i<size1; i++)
        for(int j=0; j<size2; j++)
            if(plansza[i][j]->uzyte == false)
                return false;
            return true;
}

void init_players () {
    pierwszy=NULL;
    drugi=NULL;
    A= (gracz*)malloc(sizeof (gracz));
    B= (gracz*)malloc(sizeof (gracz));
    sprintf (A->imie, "gracz 1");
    sprintf (B->imie, "gracz 2");
    A->pkt=0;
    B->pkt=0;
}

void zmiana_ruchu (){
    char tekst[100];
    if(!koniec_gry()){
        sprintf(tekst, "ruch: %s", (ruch % 2 == 0 ? A->imie : B->imie));
        gtk_label_set_text(GTK_LABEL(czyj_ruch), tekst);
    }
    else{
        if(A->pkt == B->pkt){
            sprintf(tekst, "remis");
            gtk_label_set_text(GTK_LABEL(czyj_ruch), tekst);
        }
        else if(A->pkt > B->pkt){
            sprintf(tekst, "wygrał %s", A->imie);
            gtk_label_set_text(GTK_LABEL(czyj_ruch), tekst);
        }
        else{
            sprintf(tekst, "wygrał %s", B->imie);
            gtk_label_set_text(GTK_LABEL(czyj_ruch), tekst);
        }
    }
    
    char tekst1[100];
    sprintf(tekst1, "punkty %s: %d", A->imie, A->pkt);
    
    char tekst2[100];
    sprintf(tekst2, "punkty %s: %d", B->imie, B->pkt);
    
    gtk_label_set_text(GTK_LABEL(A->label_pkt), tekst1);
    gtk_label_set_text(GTK_LABEL(B->label_pkt), tekst2);
}

void pierwszy_ruch (pole * P) {//zmiana
	printf ("pierwszy ruch\n");
    pierwszy=P;
    char label[100];
    sprintf (label, "%d", P->label);
  //  gtk_button_set_label(GTK_BUTTON(P->button), label);
    
    GtkWidget *button_image = gtk_image_new_from_file(map[P->label]);
	printf ("przed\n");
    gtk_button_set_image(GTK_BUTTON(P->button), button_image);
	printf ("po\n");
    gtk_button_set_always_show_image(GTK_BUTTON(P->button), true);
    
}

void drugi_ruch (pole * P) {//zmiana
    if (P!=pierwszy) {
	printf ("drugi ruch\n");
        char label[100];
        sprintf (label, "%d", P->label);
      //  gtk_button_set_label(GTK_BUTTON(P->button), label);
       
        GtkWidget *button_image = gtk_image_new_from_file(map[P->label]);
	printf ("1\n");
	printf ("%p\n", P->button);
	printf ("%d\n", P->label);
	printf ("%s\n", map[P->label]);
        gtk_button_set_image(P->button, button_image);
	printf ("2\n");
        gtk_button_set_always_show_image(GTK_BUTTON(P->button), true);
        printf ("nie zjebalo sie\n");
 //       gtk_widget_show_all(P->button);
        drugi=P;
        czas=time(0);
    }
    
    ruch++;
}

static void pole_klik (GtkWidget * widget, gpointer data) {
    pole * P= (pole *)data;
    if(P->uzyte==false) {
        if (pierwszy==NULL) {
            pierwszy_ruch(P);
        }
        else if (pierwszy!=NULL && drugi==NULL){
            drugi_ruch(P);
        }
    }
}

GtkWidget * new_pole (int x, int y, bool wczytane) {//zmiana
    if (wczytane && plansza[x][y]->uzyte)
        sprintf(napis, "%d", plansza[x][y]->label);
    
    GtkWidget * button = gtk_button_new_with_label(NULL);
    gtk_widget_set_size_request(button, 80, 80);
    pole * P= (pole*)malloc(sizeof (pole));
    P->x=x;
    P->y=y;
    P->button=button;
    P->uzyte= wczytane ? plansza[x][y]->uzyte : false;
    P->label=(permutacja[x*size1+y]+hard_level-1)/hard_level;
    
    GtkWidget *button_image = gtk_image_new_from_file(map[0]);
    gtk_button_set_image(GTK_BUTTON(button), button_image);
  //  gtk_button_set_always_show_image(GTK_BUTTON(button), true);
    
    plansza[x][y]=P;
    g_signal_connect (GTK_BUTTON(button), "pressed", G_CALLBACK(pole_klik), (gpointer)P);
    return button;
}

GtkWidget * generuj_plansze_gry (bool wczytane) {
    GtkWidget * board= gtk_grid_new();
    GtkWidget * pole;
    for (int i=0; i<size1; i++) {
        for (int j=0; j<size2; j++) {
            pole= new_pole (i, j, wczytane);
            gtk_grid_attach (GTK_GRID(board), pole, j, i, 1, 1);
        }
    }
    return board;
}

void zmien_stan(){//zmiana
    for (int i = 0; i < size1; i++){
        for (int j = 0; j < size2; j++){
            char text[100] = "";
            if (plansza[i][j]->uzyte){
                //sprintf(text, "%d.png", plansza[i][j]->label);
                GtkWidget *button_image = gtk_image_new_from_file(map[plansza[i][j]->label]);
                gtk_button_set_image(GTK_BUTTON(plansza[i][j]->button), button_image);
                gtk_button_set_always_show_image(GTK_BUTTON(plansza[i][j]->button), true);
            }// w ifie byl tylko sprintf
                
            
            //gtk_button_set_label(plansza[i][j]->button, text);
            //GtkWidget *button_image = gtk_image_new_from_file(map[text]);
            //gtk_button_set_image(GTK_BUTTON(P->button), button_image);
            //gtk_button_set_always_show_image(GTK_BUTTON(P->button), true);
        }
    }
}

gboolean zakonczenie_ruchu () {//zmiana
	//printf ("moze\n");
	//printf ("%p %p %d\n", pierwszy, drugi, time(0)-czas);
    if (pierwszy!=NULL && drugi !=NULL && time(0)- czas >=1) {
	printf ("zakonczenie\n");
        if (pierwszy->label!=drugi->label) {
           // gtk_button_set_label (GTK_BUTTON(pierwszy->button), "");
           // gtk_button_set_label (GTK_BUTTON(drugi->button), "");
            
            GtkWidget *button_image = gtk_image_new_from_file(map[0]);
            gtk_button_set_image(GTK_BUTTON(pierwszy->button), button_image);
            gtk_button_set_image(GTK_BUTTON(drugi->button), button_image);
         //   gtk_button_set_always_show_image(GTK_BUTTON(pierwszy->button), true);
         //   gtk_button_set_always_show_image(GTK_BUTTON(drugi->button), true);
        }
        else {
            pierwszy->uzyte=true;
            drugi->uzyte=true;
            (ruch % 2 ? A->pkt++ : B->pkt++);
        }
        pierwszy=NULL;
        drugi=NULL;
        zmiana_ruchu();
    }
    if(gra==true)
        return TRUE;
}

GtkWidget * generuj_okienko_gry (bool od_zera) {
    gra=true;
    GtkWidget * okienko= gtk_window_new(GTK_WINDOW_TOPLEVEL);
    g_timeout_add_seconds (1, zakonczenie_ruchu, NULL);
    
    gtk_window_set_title (GTK_WINDOW(okienko), "GRA");
    gtk_window_set_position(GTK_WINDOW(okienko), GTK_WIN_POS_CENTER);
    g_signal_connect (G_OBJECT (okienko), "destroy", G_CALLBACK (gtk_main_quit), NULL);
    gtk_container_set_border_width (GTK_CONTAINER(okienko), 30);
    
    GtkWidget * box= gtk_box_new (GTK_ORIENTATION_VERTICAL, 0);
    
    GtkWidget * nowa_glowna;
    nowa_glowna=gtk_button_new_with_label ("wróć do głównej");
    gtk_widget_set_size_request(nowa_glowna,  100, 50);
    g_signal_connect (GTK_BUTTON(nowa_glowna), "clicked", G_CALLBACK(back_to_main), NULL);
    
    GtkWidget * zapis;
    zapis=gtk_button_new_with_label ("zapisz");
    gtk_widget_set_size_request(zapis,  100, 50);
    g_signal_connect (GTK_BUTTON(zapis), "clicked", G_CALLBACK(save), NULL);
    
    GtkWidget * board = generuj_plansze_gry(!od_zera);
    
    GtkWidget * box_pkt= gtk_box_new (GTK_ORIENTATION_HORIZONTAL, 0);
    
    char tekst1[100];
    sprintf(tekst1, "punkty %s: %d", A->imie, A->pkt);
    
    char tekst2[100];
    sprintf(tekst2, "punkty %s: %d", B->imie, B->pkt);
    
    GtkWidget * pkt1=gtk_label_new(tekst1);
    GtkWidget * pkt2=gtk_label_new(tekst2);
    
    A->label_pkt=pkt1;
    B->label_pkt=pkt2;
    
    gtk_box_pack_start (GTK_BOX(box_pkt), pkt1, TRUE, TRUE, 10);
    gtk_box_pack_start (GTK_BOX(box_pkt), pkt2, TRUE, TRUE, 10);
    
    char tekst[100];
    sprintf(tekst, "ruch: %s", (ruch % 2 == 0 ? A->imie : B->imie));
    
    czyj_ruch=gtk_label_new(tekst);
    gtk_widget_set_size_request(zapis,  100, 50);
    
    gtk_box_pack_start (GTK_BOX(box), box_pkt, TRUE, TRUE, 10);
    gtk_box_pack_start (GTK_BOX(box), czyj_ruch, TRUE, TRUE, 10);
    gtk_box_pack_start (GTK_BOX(box), board, TRUE, TRUE, 10);
    gtk_box_pack_start (GTK_BOX(box), nowa_glowna, TRUE, TRUE, 10);
    gtk_box_pack_start (GTK_BOX(box), zapis, TRUE, TRUE, 10);
    
    gtk_container_add (GTK_CONTAINER(okienko), box);
    
    modify_bg(okienko, "darkgrey");
    
    return okienko;
}

static void save (GtkWidget * widget, gpointer data) {
    
    FILE *zapis;
    zapis = fopen("zapis.txt", "w+");
    
    fprintf(zapis, "%d %d\n", size1, size2);
    fprintf(zapis, "%d\n", hard_level);
    fprintf(zapis, "%d\n", ruch);
    fprintf(zapis, "%d\n", A->pkt);
    fprintf(zapis, "%d\n", B->pkt);
    fprintf(zapis, "%s\n", A->imie);
    fprintf(zapis, "%s\n", B->imie);
    for(int i=0; i<size1*size2; i++)
        fprintf(zapis, "%d ", permutacja[i]);
    fprintf(zapis, "\n");
    for(int i=0; i<size1; i++)
        for(int j=0; j<size2; j++)
            fprintf(zapis, "%d ", plansza[i][j]->uzyte);
        fprintf(zapis, "\n");
    
    fclose(zapis);
}

static void load_game (GtkWidget * widget, gpointer data) {
    if (A == NULL)
        init_players();
    
    FILE *zapis;
    zapis = fopen("zapis.txt", "r");
    char strInput[100];
    
    fscanf(zapis, "%d %d\n", &size1, &size2);
    fscanf(zapis, "%d\n", &hard_level);
    fscanf(zapis, "%d\n", &ruch);
    fscanf(zapis, "%d\n", &A->pkt);
    fscanf(zapis, "%d\n", &B->pkt);
    fgets(strInput, 100, zapis);
    strInput[strlen(strInput) - 1] = '\0';
    sprintf(A->imie, strInput);
    
    fgets(strInput, 100, zapis);
    strInput[strlen(strInput) - 1] = '\0';
    sprintf(B->imie, strInput);
    
    for(int i=0; i<size1*size2; i++)
        fscanf(zapis, "%d ", &permutacja[i]);
    fscanf(zapis, "\n");
    
    pierwszy=NULL;
    drugi=NULL;
    GtkWidget * okienko_gry = generuj_okienko_gry (true);
    
    for(int i=0; i<size1; i++)
        for(int j=0; j<size2; j++)
            fscanf(zapis, "%d ", &plansza[i][j]->uzyte);
        fscanf(zapis, "\n");
    
    zmien_stan();
    fclose(zapis);
    
    gtk_widget_show_all(okienko_gry);
    if (aktywne_okienko!=NULL) gtk_widget_hide(aktywne_okienko);
    aktywne_okienko=okienko_gry;
}

static void back_to_main (GtkWidget * widget, gpointer data) {
    gra=false;
    GtkWidget * okienko = generuj_okienko_glowna ();
    gtk_widget_show_all(okienko);
    if (aktywne_okienko!=NULL) gtk_widget_hide(aktywne_okienko);
    aktywne_okienko=okienko;
}


static void start_game (GtkWidget * widget, gpointer data) {
    init_players();
    ruch=0;
    losuj_permutacje(size1*size2);
    GtkWidget * okienko_gry = generuj_okienko_gry (true);
    gtk_widget_show_all(okienko_gry);
    if (aktywne_okienko!=NULL) gtk_widget_hide(aktywne_okienko);
    aktywne_okienko=okienko_gry;
}

static void set_size4x4 (GtkWidget * widget, gpointer data) {
    size1=size2=4;
}

static void set_size6x6 (GtkWidget * widget, gpointer data) {
    size1=size2=6;
}

static void set_size8x8 (GtkWidget * widget, gpointer data) {
    size1=size2=8;
}

static void set_easy (GtkWidget * widget, gpointer data) {
    hard_level=8;
}

static void set_medium (GtkWidget * widget, gpointer data) {
    hard_level=4;
}

static void set_hard (GtkWidget * widget, gpointer data) {
    hard_level=2;
}

static void settings_panel (GtkWidget * widget, gpointer data){
    
    GtkWidget * okienko= gtk_window_new(GTK_WINDOW_TOPLEVEL);
    gtk_window_set_title (GTK_WINDOW(okienko), "Ustawienia");
    gtk_widget_set_size_request(okienko, 250, 100);
    gtk_window_set_position(GTK_WINDOW(okienko), GTK_WIN_POS_CENTER);
    g_signal_connect (G_OBJECT (okienko), "destroy", G_CALLBACK (gtk_main_quit), NULL);
    gtk_container_set_border_width (GTK_CONTAINER(okienko), 30);
    
    GtkWidget * box= gtk_box_new (GTK_ORIENTATION_VERTICAL, 0);
    GtkWidget * boxh= gtk_box_new (GTK_ORIENTATION_HORIZONTAL, 0);
    GtkWidget * box1= gtk_box_new (GTK_ORIENTATION_VERTICAL, 0);
    GtkWidget * box2= gtk_box_new (GTK_ORIENTATION_VERTICAL, 0);
    
    GtkWidget * nowa_glowna;
    nowa_glowna=gtk_button_new_with_label ("wróć do głównej");
    gtk_widget_set_size_request(nowa_glowna,  100, 50);
    g_signal_connect (GTK_BUTTON(nowa_glowna), "clicked", G_CALLBACK(back_to_main), NULL);
    
    GtkWidget * wielkosc_planszy;
    wielkosc_planszy=gtk_label_new ("wielkość planszy:");
    gtk_widget_set_size_request(wielkosc_planszy,  100, 50);
    
    GtkWidget * cztery;
    cztery=gtk_button_new_with_label ("4x4");
    gtk_widget_set_size_request(cztery,  100, 50);
    g_signal_connect (GTK_BUTTON(cztery), "clicked", G_CALLBACK(set_size4x4), NULL);
    
    GtkWidget * szesc;
    szesc=gtk_button_new_with_label ("6x6");
    gtk_widget_set_size_request(szesc,  100, 50);
    g_signal_connect (GTK_BUTTON(szesc), "clicked", G_CALLBACK(set_size6x6), NULL);
    
    GtkWidget * osiem;
    osiem=gtk_button_new_with_label ("8x8");
    gtk_widget_set_size_request(osiem,  100, 50);
    g_signal_connect (GTK_BUTTON(osiem), "clicked", G_CALLBACK(set_size8x8), NULL);
    
    
    GtkWidget * trudnosc;
    trudnosc=gtk_label_new ("trudność:");
    gtk_widget_set_size_request(trudnosc,  100, 50);
    
    GtkWidget * easy;
    easy=gtk_button_new_with_label ("łatwa");
    gtk_widget_set_size_request(easy,  100, 50);
    g_signal_connect (GTK_BUTTON(easy), "clicked", G_CALLBACK(set_easy), NULL);
    
    GtkWidget * medium;
    medium=gtk_button_new_with_label ("średnia");
    gtk_widget_set_size_request(medium,  100, 50);
    g_signal_connect (GTK_BUTTON(medium), "clicked", G_CALLBACK(set_medium), NULL);
    
    GtkWidget * hard;
    hard=gtk_button_new_with_label ("trudna");
    gtk_widget_set_size_request(hard,  100, 50);
    g_signal_connect (GTK_BUTTON(hard), "clicked", G_CALLBACK(set_hard), NULL);
    
    
    gtk_box_pack_start (GTK_BOX(box), nowa_glowna, TRUE, TRUE, 10);
    gtk_box_pack_start (GTK_BOX(box), boxh, TRUE, TRUE, 10);
    gtk_box_pack_start (GTK_BOX(boxh), box1, TRUE, TRUE, 10);
    gtk_box_pack_start (GTK_BOX(boxh), box2, TRUE, TRUE, 10);
    gtk_box_pack_start (GTK_BOX(box1), wielkosc_planszy, TRUE, TRUE, 10);
    gtk_box_pack_start (GTK_BOX(box1), cztery, TRUE, TRUE, 10);
    gtk_box_pack_start (GTK_BOX(box1), szesc, TRUE, TRUE, 10);
    gtk_box_pack_start (GTK_BOX(box1), osiem, TRUE, TRUE, 10);
    gtk_box_pack_start (GTK_BOX(box2), trudnosc, TRUE, TRUE, 10);
    gtk_box_pack_start (GTK_BOX(box2), easy, TRUE, TRUE, 10);
    gtk_box_pack_start (GTK_BOX(box2), medium, TRUE, TRUE, 10);
    gtk_box_pack_start (GTK_BOX(box2), hard, TRUE, TRUE, 10);
    
    gtk_container_add (GTK_CONTAINER(okienko), box);
    
    modify_bg(okienko, "darkgrey");
    
    gtk_widget_show_all(okienko);
    if (aktywne_okienko!=NULL) gtk_widget_hide(aktywne_okienko);
    aktywne_okienko=okienko;
}

static void show_rules (GtkWidget * widget, gpointer data) {
    
    GtkWidget * okienko= gtk_window_new(GTK_WINDOW_TOPLEVEL);
    gtk_window_set_title (GTK_WINDOW(okienko), "Zasady");
    gtk_widget_set_size_request(okienko, 250, 100);
    gtk_window_set_position(GTK_WINDOW(okienko), GTK_WIN_POS_CENTER);
    g_signal_connect (G_OBJECT (okienko), "destroy", G_CALLBACK (gtk_main_quit), NULL);
    gtk_container_set_border_width (GTK_CONTAINER(okienko), 30);
    
    GtkWidget * box= gtk_box_new (GTK_ORIENTATION_VERTICAL, 0);
    
    GtkWidget * nowa_glowna;
    nowa_glowna=gtk_button_new_with_label ("wróć do głównej");
    gtk_widget_set_size_request(nowa_glowna,  100, 50);
    g_signal_connect (GTK_BUTTON(nowa_glowna), "clicked", G_CALLBACK(back_to_main), NULL);
    
    GtkWidget * zasady=gtk_label_new("Gra w memory jest bardzo prosta.\nGracze na zmianę wybierają po dwa kartoniki ze stosu wszystkich możliwych.\nJeśli kartoniki są takie same, to pozostają one odkryte i gracz otrzymuje punkt.\nJeśli nie, to zostają one zakryte i następuje tura drugiego gracza.");
    gtk_widget_set_size_request(zasady,  100, 100);
    
    gtk_box_pack_start (GTK_BOX(box), nowa_glowna, TRUE, TRUE, 10);
    gtk_box_pack_start (GTK_BOX(box), zasady, TRUE, TRUE, 10);
    
    gtk_container_add (GTK_CONTAINER(okienko), box);
    
    modify_bg(okienko, "darkgrey");
    
    gtk_widget_show_all(okienko);
    if (aktywne_okienko!=NULL) gtk_widget_hide(aktywne_okienko);
    aktywne_okienko=okienko;
}

GtkWidget * generuj_okienko_glowna () {
    
    GtkWidget * okienko;
    okienko= gtk_window_new(GTK_WINDOW_TOPLEVEL);
    gtk_window_set_title (GTK_WINDOW(okienko), "Memory");
    gtk_widget_set_size_request(okienko, 450, 400);
    gtk_window_set_position(GTK_WINDOW(okienko), GTK_WIN_POS_CENTER);
    g_signal_connect (G_OBJECT (okienko), "destroy", G_CALLBACK (gtk_main_quit), NULL);
    gtk_container_set_border_width (GTK_CONTAINER(okienko), 100);
    
    GtkWidget * box= gtk_box_new (GTK_ORIENTATION_VERTICAL, 0);
    
    GtkWidget * play;
    play=gtk_button_new_with_label ("Zagraj");
    gtk_widget_set_size_request(play,  200, 50);
    g_signal_connect (GTK_BUTTON(play), "clicked", G_CALLBACK(start_game), NULL);
    
    GtkWidget * load;
    load=gtk_button_new_with_label ("Wczytaj gre");
    gtk_widget_set_size_request(load,  200, 50);
    g_signal_connect (GTK_BUTTON(load), "clicked", G_CALLBACK(load_game), NULL);
    
    GtkWidget * settings;
    settings=gtk_button_new_with_label ("Ustawienia");
    gtk_widget_set_size_request(settings,  200, 50);
    g_signal_connect (GTK_BUTTON(settings), "clicked", G_CALLBACK(settings_panel), NULL);
    
    GtkWidget * rules;
    rules=gtk_button_new_with_label ("Zasady");
    gtk_widget_set_size_request(rules,  200, 50);
    g_signal_connect (GTK_BUTTON(rules), "clicked", G_CALLBACK(show_rules), NULL);
    
    GtkWidget * exit;
    exit=gtk_button_new_with_label ("Koniec gry");
    gtk_widget_set_size_request(exit,  200, 50);
    g_signal_connect (GTK_BUTTON(exit), "clicked", G_CALLBACK(gtk_main_quit), NULL);
    
    gtk_box_pack_start (GTK_BOX(box), play, TRUE, TRUE, 10);
    gtk_box_pack_start (GTK_BOX(box), load, TRUE, TRUE, 10);
    gtk_box_pack_start (GTK_BOX(box), settings, TRUE, TRUE, 10);
    gtk_box_pack_start (GTK_BOX(box), rules, TRUE, TRUE, 10);
    gtk_box_pack_start (GTK_BOX(box), exit, TRUE, TRUE, 10);
    
    gtk_container_add (GTK_CONTAINER(okienko), box);
    
    //    GtkWidget* image = gtk_image_new();
    //    gtk_image_set_from_file(image, "zyrafa.jpg");
    //    gtk_button_set_image(plansza[i][j]->button, image);
    
    modify_bg(okienko, "darkgrey");
    
    return okienko;
}

void modify_bg(GtkWidget* window, const gchar* colorStr)
{
    GdkColor color;
    gdk_color_parse(colorStr, &color);
    gtk_widget_modify_bg(window, GTK_STATE_FLAG_NORMAL, &color);
}

void basic_settings(){
    ruch=0;
    size1=4;
    size2=4;
    hard_level=2;
    losuj_permutacje(size1*size2);
}

int main (int argc, char **argv) {
    srand (time(0));
    basic_settings();
    gtk_init (&argc, &argv);
    GtkWidget * glowna= generuj_okienko_glowna();
    aktywne_okienko=glowna;
    gtk_widget_show_all(glowna);
    gtk_main();
}
