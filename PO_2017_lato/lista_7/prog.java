import java.io.*;
import javax.swing.*;
import java.awt.*;
import java.awt.event.*;


class Pojazd implements java.io.Serializable{
  private static final long serialVersionUID = 123456;
  protected String marka;
  protected String rejestracja;
  protected int rok_prod;
  Pojazd () {}
  Pojazd(String marka, String rejestracja, int rok_prod) {
    this.marka=marka;
    this.rejestracja=rejestracja;
    this.rok_prod=rok_prod;
  }
  public String toString() {
    return "marka : " + this.marka + "\n" + "rejestracja : " + this.rejestracja + "\n" + "rok produkcji : " + this.rok_prod;
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
  public void load(String filename) throws Exception {
    try{
      FileInputStream fis = new FileInputStream(filename);
      ObjectInputStream ois = new ObjectInputStream(fis);
      Pojazd tmp= (Pojazd) ois.readObject();
      this.marka = tmp.marka;
      this.rejestracja= tmp.rejestracja;
      this.rok_prod= tmp.rok_prod;
      ois.close();
    }
    catch (Exception e) {
      throw e;
    }
  }
}

class Tramwaj extends Pojazd {
  protected int liczba_pasazerow;
  Tramwaj () {
    super("", "", 0);
    this.liczba_pasazerow=0;
  }
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
  public void load(String filename) throws Exception {
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
      throw e;
    }
  }
}

class Samochod extends Pojazd {
  protected int moc_silnika;
  Samochod () {
    super("", "", 0);
    this.moc_silnika=0;
  }
  Samochod (String marka, String rejestracja, int rok_prod, int moc_silnika) {
    super(marka, rejestracja, rok_prod);
    this.moc_silnika=moc_silnika;
  }
  public String toString() {
    return super.toString() + "\n" + "moc silnika : " + this.moc_silnika;
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
  public void load(String filename) throws Exception {
    try{
      FileInputStream fis = new FileInputStream(filename);
      ObjectInputStream ois = new ObjectInputStream(fis);
      Samochod tmp= (Samochod) ois.readObject();
      this.marka = tmp.marka;
      this.rejestracja= tmp.rejestracja;
      this.rok_prod= tmp.rok_prod;
      this.moc_silnika= tmp.moc_silnika;
      ois.close();
    }
    catch (Exception e) {
      throw e;
    }
  }
}

class PojazdPanel extends JPanel implements ActionListener{
  protected JTextField marka;
  protected JTextField rejestracja;
  protected JTextField rok_prod;
  protected JButton save;
  protected Pojazd pojazd;
  protected String filename;
  PojazdPanel (Pojazd T, String filename) {
    this.filename=filename;
    this.pojazd=T;
    GridLayout layout = new GridLayout(0, 2);
    this.setLayout(layout);
    JLabel marka_label = new JLabel("Marka");
    this.add(marka_label);
    this.marka = new JTextField(T.marka, 40);
    this.add(marka);
    JLabel rej_label = new JLabel("Rejestracja");
    this.add(rej_label);
    this.rejestracja = new JTextField(T.rejestracja, 40);
    this.add(rejestracja);
    JLabel prod_label = new JLabel("Rok produkcji");
    this.add(prod_label);
    this.rok_prod= new JTextField(Integer.toString(T.rok_prod), 40);
    this.add(rok_prod);
    if (T.getClass().equals(Pojazd.class)) {
      this.addSaveButton();
      this.save.addActionListener(this);
    }
  }
  protected void addSaveButton() {
      save= new JButton("SAVE");
      this.add(save);
  }
  protected void getInformations(Pojazd P) {
    P.marka=this.marka.getText();
    P.rejestracja=this.rejestracja.getText();
    P.rok_prod=Integer.parseInt(this.rok_prod.getText());
  }
  public void actionPerformed(ActionEvent e) {
    this.getInformations(this.pojazd);
    this.pojazd.save(this.filename);
  }
}

class TramwajPanel extends PojazdPanel implements ActionListener {
  protected JTextField liczba_pasazerow;
  protected Tramwaj pojazd;
  TramwajPanel(Tramwaj T, String filename) {
    super(T, filename);
    this.pojazd=T;
    JLabel pasazer_label= new JLabel("Liczba pasazerow");
    this.add(pasazer_label);
    this.liczba_pasazerow= new JTextField(Integer.toString(T.liczba_pasazerow), 40);
    this.add(liczba_pasazerow);
    this.addSaveButton();
    this.save.addActionListener(this);
  }
  protected void getInformations(Tramwaj T) {
    T.liczba_pasazerow=Integer.parseInt(this.liczba_pasazerow.getText());
  }
  public void actionPerformed(ActionEvent e) {
    super.getInformations(this.pojazd);
    this.getInformations(this.pojazd);
    this.pojazd.save(this.filename);
  }
}

class SamochodPanel extends PojazdPanel implements ActionListener {
  protected JTextField moc_silnika;
  protected Samochod pojazd;
  SamochodPanel(Samochod S, String filename) {
    super(S, filename);
    this.pojazd=S;
    JLabel silnik_label= new JLabel("Moc silnika");
    this.add(silnik_label);
    this.moc_silnika= new JTextField(Integer.toString(S.moc_silnika), 40);
    this.add(moc_silnika);
    this.addSaveButton();
    this.save.addActionListener(this);
  }
  protected void getInformations(Samochod S) {
    S.moc_silnika=Integer.parseInt(this.moc_silnika.getText());
  }
  public void actionPerformed(ActionEvent e) {
    super.getInformations(this.pojazd);
    this.getInformations(this.pojazd);
    this.pojazd.save(this.filename);
  }
}


class prog {
  public static void main(String [] args) {
    String filename= args[0];
    filename= "obj/" + filename + ".ser";
    String type= args[1];
    Tramwaj tramwaj= new Tramwaj();
    Samochod samochod= new Samochod();
    Pojazd pojazd = new Pojazd();
    PojazdPanel panel=new PojazdPanel(new Pojazd(), "");
    if (type.equals("Tramwaj")) {
      try{
        tramwaj.load(filename);
      }
      catch(Exception e) {
        tramwaj= new Tramwaj();
      }
      panel= new TramwajPanel(tramwaj, filename);
    }
    else if (type.equals("Samochod")) {
      try{
        samochod.load(filename);
      }
      catch(Exception e) {
        samochod= new Samochod();
      }
      panel= new SamochodPanel(samochod, filename);
    }
    else if (type.equals("Pojazd")) {
      try{
        pojazd.load(filename);
      }
      catch(Exception e) {
        pojazd= new Pojazd();
      }
      panel= new PojazdPanel(pojazd, filename);
    }
    JFrame frame=new JFrame("Pojazd");
    frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    Container kontener = frame.getContentPane();
    kontener.add(panel);
    frame.pack();
    frame.setVisible(true);
  }
}
