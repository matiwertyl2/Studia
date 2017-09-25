//Mateusz Hazy
#include <gtk/gtk.h>

double x=0;
char X[100];
double y=0;
char Y[100];
double z=0;
char Z[100];
int proba=1;

GtkWidget *za;
GtkWidget *przeciw;
GtkWidget *nie_wie;
GtkWidget *sum;

void uaktualnij () {
    sprintf (X, "Suma %.2lf", (x+y+z));
    gtk_label_set_text (GTK_LABEL(sum), X);
    sprintf (X, "Za %.2lf procent", x/(x+y+z)*100);
    gtk_label_set_text (GTK_LABEL(za), X);
     sprintf (Y, "Przeciw %.2lf procent ", y/(x+y+z)*100);
    gtk_label_set_text (GTK_LABEL(przeciw), Y);
    sprintf (Z, "Nie wiem %.2lf procent", z/(x+y+z)*100);
    gtk_label_set_text (GTK_LABEL(nie_wie), Z);
}


void dodaj_za (GtkWidget *widget,gpointer data) {
    x++;
    uaktualnij ();
}

void dodaj_przeciw (GtkWidget *widget,gpointer data) {
    y++;
    uaktualnij ();
}

void dodaj_nie_wiem (GtkWidget *widget,gpointer data) {
    z++;
    uaktualnij ();
}

int main (int argc, char * argv[]) {
    gtk_init(&argc, &argv);
    for (int i=1; i<=10; i++) proba++;
    GtkWidget *window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
    gtk_window_set_title(GTK_WINDOW(window),"Ankieta");
    gtk_window_set_position(GTK_WINDOW(window),GTK_WIN_POS_CENTER);
    g_signal_connect(G_OBJECT(window), "destroy",G_CALLBACK(gtk_main_quit), NULL);

    gtk_container_set_border_width(GTK_CONTAINER(window), 100);
    GtkWidget *box1 = gtk_box_new(GTK_ORIENTATION_VERTICAL, 0);
    gtk_container_add(GTK_CONTAINER(window), box1);
    GtkWidget *pytanie = gtk_label_new("Jestes Polakiem?");


    GtkWidget *box2 = gtk_box_new(GTK_ORIENTATION_HORIZONTAL, 0);

    GtkWidget *a = gtk_button_new_with_label("TAK");

    GtkWidget *b = gtk_button_new_with_label("NIE");

    GtkWidget *c = gtk_button_new_with_label("NIE WIEM");

    gtk_box_pack_start(GTK_BOX(box2), a, TRUE, TRUE, 0);
    gtk_box_pack_start(GTK_BOX(box2), b, TRUE, TRUE, 0);
    gtk_box_pack_start(GTK_BOX(box2), c, TRUE, TRUE, 0);
    gtk_box_pack_start(GTK_BOX(box1), pytanie, TRUE, TRUE, 0);
    gtk_box_pack_start(GTK_BOX(box1), box2, TRUE, TRUE, 0);
    GtkWidget *box3 = gtk_box_new(GTK_ORIENTATION_VERTICAL, 0);
    GtkWidget *stat = gtk_label_new("Statystyki");

     za = gtk_label_new("Za 0");
    przeciw = gtk_label_new("Przeciw 0");
    nie_wie = gtk_label_new("Nie wiem 0");
    sum= gtk_label_new ("Suma 0");

    g_signal_connect(G_OBJECT(a), "clicked",G_CALLBACK(dodaj_za), NULL);
    g_signal_connect(G_OBJECT(b), "clicked",G_CALLBACK(dodaj_przeciw), NULL);
    g_signal_connect(G_OBJECT(c), "clicked",G_CALLBACK(dodaj_nie_wiem), NULL);

    gtk_box_pack_start(GTK_BOX(box3), sum, TRUE, TRUE, 0);
    gtk_box_pack_start(GTK_BOX(box3), za, TRUE, TRUE, 0);
    gtk_box_pack_start(GTK_BOX(box3), przeciw, TRUE, TRUE, 0);
    gtk_box_pack_start(GTK_BOX(box3), nie_wie, TRUE, TRUE, 0);
    gtk_box_pack_start(GTK_BOX(box1), box3, TRUE, TRUE, 0);

    gtk_widget_show_all(window);
    gtk_main();
}
