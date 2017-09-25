using System;

class proba {
  public int x;
  public proba (int x) {
    this.x=x;
  }
}

class Mojprogram {
  public static void Main() {
    proba P=new proba (123);
    Console.WriteLine ("{0}", P.x); 
  }
}





