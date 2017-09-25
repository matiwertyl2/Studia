using System;
using System.Collections;


public class PrimeCollection : IEnumerable {
  int max_int;
  public PrimeCollection (int maks) {
    this.max_int=maks;
  }
  IEnumerator IEnumerable.GetEnumerator() {
    return (IEnumerator)  GetEnumerator();
  }
  public PrimeEnum GetEnumerator() {
    return new PrimeEnum(max_int);
  }
}

public class PrimeEnum : IEnumerator {
  int pocz;
  int current;
  int max_int;
  public PrimeEnum(int x) {
    this.pocz=1;
    this.current=1;
    this.max_int=x;
  }
  public bool MoveNext() {
    current= next_prime(current);
    return (current < max_int);
  }
  public void Reset () {
    current=pocz;
  }
  object IEnumerator.Current {
    get {
      return Current;
    }
  }
  public int Current {
    get {
      return current;
    }
  }
  bool pierwsza (int x) {
    for (int i=2; i<x; i++) {
      if (x % i==0) return false;
    }
    return true;
  }
  int next_prime(int x) {
    int res=x+1;
    while (true) {
      if (pierwsza(res)) return res;
      res++;
    }
  }
}

class Prog {
  public static void Main () {
    int max_int= Convert.ToInt32(Console.ReadLine());
    PrimeCollection X= new PrimeCollection(max_int);
    foreach (int x in X) {
      Console.WriteLine("{0}", x);
    }
  }
}
