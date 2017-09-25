import java.io.*;
import javax.swing.*;
import java.awt.*;
import java.awt.event.*;


class Pojazd implements java.io.Serializable{
  private static final long serialVersionUID = 123456;
  protected String marka;
  protected String rejestracja;
  protected int rok_prod;
  Pojazd(String marka, String rejestracja, int rok_prod) {
    this.marka=marka;
    this.rejestracja=rejestracja;
    this.rok_prod=rok_prod;
  }
  public String toString() {
    return "marka : " + this.marka + "\n" + "rejestracja : " + this.rejestracja + "\n" + "rok produkcji : " + this.rok_prod;
  }
}

class Tramwaj extends Pojazd {
  protected int liczba_pasazerow;
  Tramwaj (String marka, String rejestracja, int rok_prod, int liczba_pasazerow) {
    super(marka, rejestracja, rok_prod);
    this.liczba_pasazerow=liczba_pasazerow;
  }
  public String toString() {
    return super.toString() + "\n" + "liczba_pasazerow :" + this.liczba_pasazerow;
  }
  public void save(String filename) {
    try {
    FileOutputStream fos = new FileOutputStream(filename);
    ObjectOutputStream oos = new ObjectOutputStream(fos);
    oos.writeObject(this);
    oos.close();
    }
    catch (Exception e) {
      System.out.println("Unable to save");
    }
  }
  public void load(String filename) {
    try{
      FileInputStream fis = new FileInputStream(filename);
      ObjectInputStream ois = new ObjectInputStream(fis);
      Tramwaj tmp= (Tramwaj) ois.readObject();
      this.marka = tmp.marka;
      this.rejestracja= tmp.rejestracja;
      this.rok_prod= tmp.rok_prod;
      this.liczba_pasazerow= tmp.liczba_pasazerow;
      ois.close();
    }
    catch (Exception e) {
      System.out.println("Unable to load");
    }
  }
}

class Samochod extends Pojazd {
  protected int moc_silnika;
  Samochod (String marka, String rejestracja, int rok_prod, int moc_silnika) {
    super(marka, rejestracja, rok_prod);
    this.moc_silnika=moc_silnika;
  }
  public String toString() {
    return super.toString() + "\n" + "moc silnika : " + this.moc_silnika;
  }
}

class okienko {
  JFrame frame;
  okienko (Tramwaj T) {
    this.frame=new JFrame("Pojazd");
    this.frame.setDefaultCloseOperation(close);
    Container kontener = frame.getContentPane();
    GridLayout layout = new GridLayout(4, 2);
    kontener.setLayout(layout);
    JLabel marka_etykieta = new JLabel("Marka");
    kontener.add(marka_etykieta);
    JTextField marka = new JTextField(T.marka, 40);
    kontener.add(marka);
    frame.pack();
    this.frame.setVisible(true);

  }
  private void close() {
    JFrame.EXIT_ON_CLOSE();
  }
}

class zad {
  public static void main(String [] args) {
    Tramwaj T= new Tramwaj("skoda", "DW12345", 2011, 56);
    System.out.println(T);
    T.save("tramwaj.ser");
    Tramwaj W= new Tramwaj("kn", "JSn", 12, 32);
    W.load("tramwaj.ser");
    System.out.println(W);
    Samochod S= new Samochod("mercedes", "DW222", 2010, 15);
    System.out.println(S);
    okienko O= new okienko(T);
  }
}
