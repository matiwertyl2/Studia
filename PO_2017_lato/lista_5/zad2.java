import java.io.*;
import java.util.HashMap;


class wyrazenie {
  protected String op;
  protected wyrazenie L;
  protected wyrazenie P;
  wyrazenie (String op, wyrazenie L, wyrazenie P) {
    this.op=op;
    this.L=L;
    this.P=P;
  }
  public String toString () {
    return "( " + this.L.toString() + " " + op + " " + this.P.toString() + " )";
  }
  public int oblicz(){
    return 0;
  }
  public String wypisz () {
    return   this + " = " + this.oblicz();
  }
}

class Stala extends wyrazenie  {
  int value;
  Stala (int x) {
    super("const", null, null);
    this.value=x;
  }
  public String toString () {
    String res ="" + this.value;
    return res;
  }
  public int oblicz () {
    return this.value;
  }
}

class Zmienna extends wyrazenie {
  String value;
  Zmienna (String x) {
    super("variable", null, null);
    this.value=x;
  }
  public String toString() {
    String res="" + this.value;
    return res;
  }
  public int oblicz () {
    return Static.Map.get(this.value);
  }
}

class Dodaj extends wyrazenie {
  Dodaj(wyrazenie L, wyrazenie P) {
    super("+", L, P);
  }
  public int oblicz() {
    return this.L.oblicz() + this.P.oblicz();
  }
}

class Odejmij extends wyrazenie {
  Odejmij(wyrazenie L, wyrazenie P) {
    super("-", L, P);
  }
  public int oblicz() {
    return this.L.oblicz() - this.P.oblicz();
  }
}

class Pomnoz extends wyrazenie {
  Pomnoz(wyrazenie L, wyrazenie P) {
    super("*", L, P);
  }
  public int oblicz () {
    return this.L.oblicz() * this.P.oblicz();
  }
}

class Podziel extends wyrazenie {
  Podziel (wyrazenie L, wyrazenie P) {
    super("/", L, P);
  }
  public int oblicz () {
    return this.L.oblicz() / this.P.oblicz();
  }
}

class Static {
  public static HashMap<String, Integer> Map= new HashMap<String, Integer>();
}

class zad2 {
  public static void main (String[] args) {
      Static.Map.put("x", 10);
      wyrazenie W= new Dodaj( new Odejmij(new Zmienna("x"),new Stala(4)), new  Stala(2));
      System.out.println(W.wypisz());
      wyrazenie P = new Pomnoz(new Dodaj(new Stala(2), new Stala(3)), new Stala(4));
      System.out.println(P.wypisz());
      wyrazenie Q= new Pomnoz(W, P);
      System.out.println(Q.wypisz());
      wyrazenie R= new Podziel(P, W);
      System.out.println(R.wypisz());

  }
}
