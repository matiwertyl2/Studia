import java.io.*;

class Node<T extends Serializable> implements java.io.Serializable {
    private static final long serialVersionUID =  1234;
    public T value;
    public Node<T> next;
    public Node (T value) {
      this.value=value;
      this.next=null;
    }
}

class List<T extends Serializable> implements java.io.Serializable {
  private static final long serialVersionUID = 123455;
  private Node<T> head;
  public List() {
    this.head=null;
  }
  public void Add (T S) {
    Node<T> current=this.head;
    if (current==null) {
      this.head=new Node<T>(S);
    }
    else {
      while (current.next!=null) {
        current=current.next;
      }
      current.next= new Node<T>(S);
    }
  }
  public void Print () {
    Node<T> current= this.head;
    while(current!=null) {
      System.out.println(current.value);
      current=current.next;
    }
  }
  public void save(String filename) {
    try {
    FileOutputStream fos = new FileOutputStream(filename);
    ObjectOutputStream oos = new ObjectOutputStream(fos);
    oos.writeObject(this.head);
    oos.close();
    }
    catch (Exception e) {
      System.out.println("Unable to save");
    }
  }
  public void load(String filename) {
    try{
      FileInputStream fis = new FileInputStream(filename);
      ObjectInputStream ois = new ObjectInputStream(fis);
      this.head = (Node<T>) ois.readObject();
      ois.close();
    }
    catch (Exception e) {
      System.out.println("Unable to load");
    }
  }
}


class zad1 {
  public static void main(String [] args) {
    List<String> L= new List<String>();
    L.Add("jeden");
    L.Add("dwa");
    L.Add("trzy");
    L.Add("cztery");
    L.Add("piec");
    System.out.println("Input List :");
    L.Print();
    L.save("lista.ser");
    L= new List<String>();
    List<String> P= new List<String>();
    P.load("lista.ser");
    System.out.println("Loaded List :");
    P.Print();
  }
}
