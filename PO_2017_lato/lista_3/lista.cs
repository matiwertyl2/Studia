using System;
using Listlib;

class zadanie {
  public static void Main() {
    Lista<string> L= new Lista<string>();
    while (true) {
      string op=Console.ReadLine();
      string x= "";
      if (op=="push_back" || op=="push_front") x=(Console.ReadLine());
      if (op=="push_back") {
        L.push_back(x);
        Console.WriteLine("push back: {0}", x);
      }
      else if (op=="push_front") {
        L.push_front(x);
        Console.WriteLine("push front: {0}", x);
      }
      else if (op=="pop_back") Console.WriteLine("back: {0}",L.pop_back());
      else if (op=="pop_front") Console.WriteLine("front : {0}", L.pop_front());
      else if (op=="end") break;
    }
  }
}
