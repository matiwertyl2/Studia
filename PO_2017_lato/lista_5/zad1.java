import java.io.*;

class wezel<T extends Comparable <T>> {
  wezel<T> prev;
  wezel<T> next;
  T value;
  wezel(T value) {
    this.value=value;
    prev=null;
    next=null;
  }
}

class List<T extends Comparable <T>> {
  wezel<T> head;
  List () {
    this.head=null;
  }
  public void Add (T x) {
    if (this.head==null) this.head= new wezel<T>(x);
    else {
        wezel<T> current= this.head;
        while (current.next !=null && current.value.compareTo(x)<0) current=current.next;
        if (current.value.compareTo(x)>=0) {
          current= current.prev;
          wezel<T> nowy= new wezel<T>(x);
          if (current==null) {
            this.head.prev=nowy;
            nowy.next=this.head;

            this.head=nowy;
          }
          else {
            wezel<T> nast=current.next;
            current.next=nowy;
            nast.prev=nowy;
            nowy.prev=current;
            nowy.next=nast;
          }
        }
        else {
          wezel<T> nowy= new wezel<T>(x);
          nowy.prev=current;
          current.next=nowy;
        }
    }
  }
  public T pop () {
    T res = this.head.value;
    this.head=this.head.next;
    if (this.head!=null) this.head.prev=null;
    return res;
  }
  public void Wypisz () {
    System.out.println("-------------------------");
    wezel<T> current= this.head;
    while (current!=null) {
      System.out.println(current.value);
      current= current.next;
    }
    System.out.println("-------------------------");

  }

}

class soldier implements Comparable<soldier> {
  protected int weight;
  protected  String name;
  protected String rank;
  soldier (int w, String name, String rank) {
    this.weight=w;
    this.name=name;
    this.rank=rank;
  }
  public int compareTo (soldier S) {
    if (this.weight<S.weight) return -1;
    if (this.weight==S.weight) {
      if (this.name.compareTo(S.name)<0) return -1;
      if (this.name.compareTo(S.name)==0) return 0;
      return 1;
    }
    return 1;
  }
  public String toString() {
    return this.rank + " " + this.name;
  }
}

class general extends soldier {
  general (String Name) {
    super(100, Name, "general");
  }
}

class colonel extends soldier {
  colonel (String Name) {
    super(90, Name, "colonel");
  }
}

class major extends soldier {
  major (String Name) {
    super(80, Name, "major");
  }
}

class lieutenant extends soldier {
  lieutenant (String Name) {
    super(50, Name, "lieutenant");
  }
}

class zad1 {
  public static void main (String[] args) {
    List<soldier> L = new List<soldier>();
    L.Add(new general("Mateusz"));
    L.Wypisz();
    L.Add(new general("Jan"));
    L.Wypisz();
    L.Add(new major ("Krzys"));
    L.Wypisz();
    general Jan= new general("Jan");
    System.out.println(L.pop() + " emerytura");
    L.Add(new colonel("Aleksandra"));
    L.Add(new lieutenant("Ignacy"));
    L.Wypisz();

  }
}
