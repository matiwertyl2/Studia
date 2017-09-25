import java.io.*;

class SerializeDemo {

   public static void main(String [] args) {
      Employee e = new Employee();
      Employee e1=new Employee();
      e.name = "Reyan Ali";
      e.address = "Phokka Kuan, Ambehta Peer";
      e.SSN = 11122333;
      e.number = 101;
      e.p=new Para();
      e1.name="A";
      e1.address="B";
      e1.SSN=123;
      e1.number=123;
      e1.p=new Para();
      try {
         FileOutputStream fileOut =new FileOutputStream("employee.ser");
         ObjectOutputStream out = new ObjectOutputStream(fileOut);
         out.writeObject(e);
         out.writeObject(e1);
         out.close();
         fileOut.close();
         System.out.printf("Serialized data is saved in employee.ser");
      }catch(IOException i) {
         i.printStackTrace();
      }

      try {
         FileInputStream fileIn = new FileInputStream("employee.ser");
         ObjectInputStream in = new ObjectInputStream(fileIn);
         e = (Employee) in.readObject();
         e1=(Employee) in.readObject();
         in.close();
         fileIn.close();
      }catch(IOException i) {
         i.printStackTrace();
         return;
      }catch(ClassNotFoundException c) {
         System.out.println("Employee class not found");
         c.printStackTrace();
         return;
      }

      System.out.println("Deserialized Employee..." + e.p.a + " " + e.p.b);
      System.out.println("Name: " + e.name);
      System.out.println("Address: " + e.address);
      System.out.println("SSN: " + e.SSN);
      System.out.println("Number: " + e.number);
      System.out.println("Deserialized Employee..." + e1.p.a + " " + e1.p.b);
      System.out.println("Name: " + e1.name);
      System.out.println("Address: " + e1.address);
      System.out.println("SSN: " + e1.SSN);
      System.out.println("Number: " + e1.number);
   }
}

class Para implements java.io.Serializable {
  public int a;
  public int b;
  Para() {
    a=1;
    b=2;
  }
}

class Employee implements java.io.Serializable {
   public String name;
   public String address;
   public  int SSN;
   public int number;
   public  Para p;
   public void mailCheck() {
      System.out.println("Mailing a check to " + name + " " + address);
   }
}
