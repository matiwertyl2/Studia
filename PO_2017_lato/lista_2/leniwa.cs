using System;
using System.Collections.Generic;



class ListaLeniwa {
  protected List <int> list;
  protected int inf=1000000000;
  public ListaLeniwa () {
    list = new List<int>();
  }
  public int size () {
    return this.list.Count;
  }
  virtual public int element (int i) {
    while (this.list.Count<i) {
      Random rnd= new Random();
      int randomnumber= rnd.Next(-inf, inf);
      this.list.Add (randomnumber);
    }
    return this.list[i-1];
  }
}

class Pierwsze : ListaLeniwa {
  protected int ostatnia;
  public Pierwsze (): base() {
    ostatnia=1;
  }
  static bool czy_pierwsza (int x) {
    if (x==1) return false;
    for (int i=2; i<x; i++) {
      if (x % i==0) return false;
    }
    return true;
  }
  int nastepna () {
    for (int i=this.ostatnia+1; i<=inf; i++) {
      if (czy_pierwsza (i) ) {
	this.ostatnia=i;
	return i;
      }
    }
    return 0;
  }
  override public int element (int i) {
    while (this.list.Count<i) {
      this.list.Add (this.nastepna());
    }
    return this.list[i-1];
  }
}

class MojProgram {
  public static void Main () {
    Pierwsze P= new Pierwsze ();
    Console.WriteLine ("Size {0}", P.size());
    Console.WriteLine ("Element 3: {0}", P.element(3));
    Console.WriteLine("Size {0}", P.size());
    Console.WriteLine ("Element 100: {0}", P.element(100));
    Console.WriteLine ("Size {0}", P.size());
  }
}
