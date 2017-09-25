using System;
using System.Collections;
using Interfaces;
using MyList;
using Dictionary;

namespace  Interfaces {
  public interface IMyCollection {
    // dodaj wg jakiegos klucza wartosc
    void add(object key, object value);
    // usun wg klucza
    void remove(object key);
    // wartosc wg klucza
    object value(object key);
  }
}

namespace MyList {
  public class wezel<T>  {
    public wezel<T> next;
    public wezel<T> prev;
    public T val;
    public wezel (T  x) {
      val= x;
    }
  }

  public class Lista<T>  : IMyCollection, IEnumerable {
    protected wezel<T> first;
    protected wezel<T> last;
    protected int length;
    public Lista () {
      length=0;
    }
    public override string ToString () {
      return String.Format("pierwszy element listy to {0}", this.first.val);
    }
    public int Length {
      get {
        return this.length;
      }
    }
    public T this[int indeks] {
      get {
        wezel<T> W=this.first;
        for (int i=0; i<indeks; i++) {
          W=W.next;
        }
        return W.val;
      }
    }
    IEnumerator IEnumerable.GetEnumerator() {
      return (IEnumerator)  GetEnumerator();
    }
    public ListEnum<T> GetEnumerator() {
      return new ListEnum<T>( first);
    }
    public bool empty() {
      if (this.length==0) return true;
      return false;
    }
    public void add(object key, object value) {
      string S=(string) key;
      T x= (T) value;
      if (S=="front") this.push_front(x);
      else if (S=="back") this.push_back(x);
    }
    public void remove(object A) {
      string S=(string) A;
      if (S=="back") {
        this.pop_back();
      }
      else if (S=="front") this.pop_front();
    }
    public object value(object key){
      string S=(string) key;
      if (S=="front") return (object) first.val;
      else if (S=="back") return (object)last.val;
      return (object) default(T);
    }
    private void push_back (T x) {
      wezel<T> w= new wezel<T> (x);
      if (this.empty()) {
        this.first=w;
        this.last=w;
        this.length++;
      }
      else {
        w.prev=this.last;
        this.last.next=w;
        this.last=w;
        this.length++;
      }
    }
    private void push_front (T x) {
      wezel<T> w= new wezel<T> (x);
      if (this.empty()) {
        this.first=w;
        this.last=w;
        this.length++;
      }
      else {
        w.next=this.first;
        this.first.prev=w;
        this.first=w;
        this.length++;
      }
    }
    private void pop_back () {
      if (!this.empty()) {
        this.last=this.last.prev;
        this.last.next=null;
        length--;
      }
    }
    private void pop_front () {
      if (!this.empty()) {
        this.first=this.first.next;
        length--;
      }
    }
    public void wypisz () {
      Console.WriteLine ("{0}, {1}, {2}", this.first.next.val, this.last.prev.val, this.last.val);

    }
  }

  public class ListEnum<T> : IEnumerator {
    wezel<T> pocz;
    wezel<T> current;
    public ListEnum(wezel<T> W) {
      this.pocz=new wezel<T>(default(T));
      this.pocz.next=W;
      this.current=this.pocz;
    }
    public bool MoveNext() {
      current= current.next;
      return (current!=null);
    }
    public void Reset () {
      current=pocz;
    }
    object IEnumerator.Current {
      get {
        return Current;
      }
    }
    public T Current {
      get {
        return current.val;
      }
    }
  }
}

namespace Dictionary {
  public class wezel<K,V> {
    public K key;
    public V val;
    public wezel<K,V> prev;
    public wezel<K,V>next;
    public wezel (K a, V b) {
      key=a;
      val=b;
    }
    public void add (K key, V val) {

        if (this.key.Equals(key))  this.val=val;
        else if (this.next==null) {
          wezel<K,V> s= new wezel<K,V> (key,val);
          this.next=s;
          s.prev=this;
        }
        else  this.next.add(key,val);
    }
    public void remove (K key) {
        if (this.key.Equals(key)) {
          if (this.prev!=null) this.prev.next=this.next;
          if (this.next!=null) this.next.prev=this.prev;
        }
        else if (this.next!=null) this.next.remove( key );
    }
    public V value (K key) {
      if (this.key.Equals(key)) return this.val;
      else if (this.next!=null) return this.next.value( key);
      return default(V);
    }
  }

  public class Slownik<K,V> : IMyCollection{
    protected wezel<K,V> beg;

    public Slownik () {
      beg=null;
    }
    public void add (object k, object v) {
      K key= (K) k;
      V val= (V) v;
      if (this.beg==null){
        this.beg= new wezel<K,V>(key, val);
      }
      else this.beg.add(key,val);
    }
    public void remove (object k) {
      K key= (K) k;
      if (this.beg!=null) {
        if (this.beg.key.Equals(key)) {
          this.beg=this.beg.next;
          if (this.beg!=null) this.beg.prev=null;
        }
        else this.beg.next.remove(key);
      }
    }
    public object value (object k) {
      K key=(K) k;
      if (this.beg!=null) return (object)this.beg.value(key);
      return default(object);
    }
  }
}

class Prog {
  public static void Main() {
    Console.WriteLine("Testowanie Listy");
    Lista<int> L = new Lista<int> ();
    L.add("back", 1);
    L.add("front", 11);
    L.add("back", 3);
    L.add("front", 12);
    L.add("back", 123);
    foreach(int x in L) Console.WriteLine("{0}", x);
    Console.WriteLine(L);
    Console.WriteLine("dlugosc listy {0}", L.Length);
    Console.WriteLine("element nr 2: {0}", L[2]);
    L.remove("back");
    L.remove("front");
    foreach(int x in L) Console.WriteLine("{0}", x);
    Console.WriteLine("Testowanie Slownika");
    Slownik<string, string> D= new Slownik<string, string> ();
    D.add("a", "A");
    D.add("b", "B");
    Console.WriteLine(D.value("a"));
    Console.WriteLine(D.value("b"));
  }
}
