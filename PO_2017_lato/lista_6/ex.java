import java.io.*;

class TestClass implements Serializable {

  private static final long serialVersionUID = -2518143671167959230L;

  private String propertyOne;
  private String propertyTwo;
  public TestClass next;

  public TestClass(String propertyOne, String propertyTwo) {
    this.propertyOne = propertyOne;
    this.propertyTwo = propertyTwo;
    next=null;
    validate();
  }

/*  private void writeObject(ObjectOutputStream o)  throws IOException {

    o.writeObject(propertyOne);
    o.writeObject(propertyTwo);
    o.writeObject(next);
  }

  private void readObject(ObjectInputStream o)
    throws IOException, ClassNotFoundException {

    propertyOne = (String) o.readObject();
    propertyTwo = (String) o.readObject();
    next= (TestClass) o.readObject();
    validate();
  } */

  private void validate(){
    if(propertyOne == null ||
      propertyOne.length() == 0 ||
      propertyTwo == null ||
      propertyTwo.length() == 0){

      throw new IllegalArgumentException();
    }
  }

  public String getPropertyOne() {
    return propertyOne;
  }

  public String getPropertyTwo() {
    return propertyTwo;
  }

}


class Main {

  public static void main(String[] args)
    throws Exception {

    TestClass testWrite = new TestClass("valueOne", "valueTwo");
    testWrite.next= new TestClass("val1", "val2");
    FileOutputStream fos = new FileOutputStream("testfile");
    ObjectOutputStream oos = new ObjectOutputStream(fos);
    oos.writeObject(testWrite);
    oos.flush();
    oos.close();

    TestClass testRead;
    FileInputStream fis = new FileInputStream("testfile");
    ObjectInputStream ois = new ObjectInputStream(fis);
    testRead = (TestClass) ois.readObject();
    ois.close();

    System.out.println("--Serialized object--");
    System.out.println("propertyOne: " + testWrite.getPropertyOne());
    System.out.println("propertyTwo: " + testWrite.getPropertyTwo());
    System.out.println("propertyTwo: " + testWrite.next.getPropertyOne());
    System.out.println("propertyTwo: " + testWrite.next.getPropertyTwo());

    System.out.println("");
    System.out.println("--Read object--");
    System.out.println("propertyOne: " + testRead.getPropertyOne());
    System.out.println("propertyTwo: " + testRead.getPropertyTwo());

  }

}
