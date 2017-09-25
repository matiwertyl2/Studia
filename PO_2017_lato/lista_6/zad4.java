import java.io.*;
import java.util.Arrays;

class Array implements Runnable {
  int[] tab;
  private Array(int tab[]) {
      this.tab=tab;
  }
  private void Merge(Array L, Array R) {
    int d1=L.tab.length;
    int d2=R.tab.length;
    int w1=0, w2=0;
    int w=0;
    while (w1<d1 && w2<d2) {
      if (L.tab[w1]<R.tab[w2]) {
        this.tab[w]=L.tab[w1];
        w++;
        w1++;
      }
      else {
        this.tab[w]=R.tab[w2];
        w++;
        w2++;
      }
    }
    if (w1<d1) {
      while(w1<d1) {
        this.tab[w]=L.tab[w1];
        w++;
        w1++;
      }
    }
    else {
      while(w2<d2) {
        this.tab[w]=R.tab[w2];
        w++;
        w2++;
      }
    }
  }
  public static void Sort(int[] tab) {
    Array A= new Array(tab);
    A.run();
  }
  public void run() {
    if (this.tab.length==1) return;
    int d= this.tab.length;
    int[] L= new int[d/2];
    int[] P= new int[d-d/2];
    for (int i=0; i<d/2; i++) {
      L[i]=this.tab[i];
    }
    for (int i=d/2; i<d; i++) {
      P[i-d/2]=this.tab[i];
    }
    Array left= new Array(L);
    Array right= new Array(P);
    Thread thread1 = new Thread(left);
    thread1.start();
    Thread thread2 = new Thread(right);
    thread2.start();
    try {
      thread1.join();
      thread2.join();
    }
    catch(InterruptedException e) {
      System.out.println("Something went wrong while sorting");
    }
    this.Merge(left, right);
  }
}


class zad4 {
  public static void main (String[] args) {
    int[] tab={2,3,6,1,1,2,5,4,6,7, 123, 21, 1, 3, 4, 5};
    System.out.println("Input Array :");
    System.out.println(Arrays.toString(tab));
    Array.Sort(tab);
    System.out.println("Sorted Array :");
    System.out.println(Arrays.toString(tab));
  }
}
