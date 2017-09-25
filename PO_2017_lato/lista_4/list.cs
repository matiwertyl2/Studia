using System;
using System.Collections;

public class Element {
  public int val;
  public Element next;
  public Element(int x) {
    this.val=x;
  }
  public Element klonuj () {
    Element res= new Element (this.val);
    res.next=this.next;
    return res;
  }
}

class Lista : IEnumerable  {
  public Element lista;
  public Lista () {
      lista=null;
  }
  public void Add (int val) {
    if (this.lista==null) {
      this.lista= new Element(val);
    }
    else {
      Element X= this.lista;
      while (X.next!=null) {
        X= X.next;
      }
      X.next=new Element(val);
    }
  }
  public void wypisz() {
    if (this.lista!=null) {
      Element X= this.lista;
      while(X.next!=null) {
        Console.WriteLine("{0}", X.val);
        X= X.next;
      }
      Console.WriteLine("{0}", X.val);
      Console.WriteLine("===============");
    }
  }
   IEnumerator IEnumerable.GetEnumerator(){
    return  (IEnumerator) GetEnumerator();
  }
  public ListEnum GetEnumerator() {
    return new ListEnum(lista);
  }
}

public class ListEnum : IEnumerator
{
    public Element current;
    public Element pocz;
    // Enumerators are positioned before the first element
    // until the first MoveNext() call.

    public ListEnum(Element lista)
    {
        this.pocz= new Element(0);
        this.pocz.next=lista;
        this.current=this.pocz;
    }

    public bool MoveNext()
    {
        current=current.next;
        return (current!=null);
    }

    public void Reset()
    {
        current=pocz;
    }
    public object Current
    {
        get
        {
          return current;
        }
    }

}



class Prog {
  public static void Main() {
    Lista L= new Lista();
    for (int i=1; i<=10; i++) {
      L.Add(i);
      foreach(Element e in L) {
        Console.WriteLine(e.val);
      }
      Console.WriteLine("================");
    }
  }
}
