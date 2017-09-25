using System;
using Dictionary;


class zadanie {
  public static void Main() {
    Slownik<string, string> S= new Slownik<string, string>();
    while (true) {
      string op=Console.ReadLine();
      if (op=="add") {
        string key=Console.ReadLine();
        string val=Console.ReadLine();
        S.add(key,val);
        Console.WriteLine("dodalem");
      }
      else if (op=="remove") {
        string key=Console.ReadLine();
        S.remove(key);
        Console.WriteLine("usunalem");
      }
      else if (op=="value") {
        string key=Console.ReadLine();
        Console.WriteLine("key: {0} value : {1}", key, S.value(key));
      }
      else if (op=="end") break;
    }
  }
}
