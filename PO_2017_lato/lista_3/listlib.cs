using System;

namespace Listlib {
  public class wezel<T> {
    public wezel<T> next;
    public wezel<T> prev;
    public T val;
    public wezel (T  x) {
      val= x;
    }
  }

  public class Lista<T> {
    protected wezel<T> first;
    protected wezel<T> last;
    protected int length;
    public Lista () {
      length=0;
    }
    public bool empty() {
      if (this.length==0) return true;
      return false;
    }
    public void push_back (T x) {
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
    public void push_front (T x) {
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
    public T pop_back () {
      if (this.empty()) return default(T);
      T res= this.last.val;
      this.last=this.last.prev;
      length--;
      return res;
    }
    public T pop_front () {
      if (this.empty()) return default(T);
      T res= this.first.val;
      this.first=this.first.next;
      length--;
      return res;
    }
    public void wypisz () {
      Console.WriteLine ("{0}, {1}, {2}", this.first.next.val, this.last.prev.val, this.last.val);

    }
  }
}
