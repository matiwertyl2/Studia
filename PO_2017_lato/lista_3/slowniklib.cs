using System;

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

  public class Slownik<K,V> {
    protected wezel<K,V> beg;

    public Slownik () {
      beg=null;
    }
    public void add (K key, V val) {
      if (this.beg==null){
        this.beg= new wezel<K,V>(key, val);
      }
      else this.beg.add(key,val);
    }
    public void remove (K key) {
      if (this.beg!=null) {
        if (this.beg.key.Equals(key)) {
          this.beg=this.beg.next;
          if (this.beg!=null) this.beg.prev=null;
        }
        else this.beg.next.remove(key);
      }
    }
    public V value (K key) {
      if (this.beg!=null) return this.beg.value(key);
      return default(V);
    }
  }
}
