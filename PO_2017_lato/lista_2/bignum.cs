using System;

class BigNum {
  const int max_size=100;
  int pos=0;
  int[] cyfry= new int[max_size];
  int znak;
  public BigNum (int x) {
    if (x<0) {
      znak=0;
      x*=-1;
    }
    else znak=1;
    while (x!=0) {
      cyfry[pos]=x % 10;
      x/=10;
      pos++;
    }
    if (pos!=0) pos--;
  }
  bool mniejsze (BigNum A) {
    if (this.pos <A.pos) return true;
    if (this.pos>A.pos) return false;
    for (int i=this.pos; i>=0; i--) {
      if (this.cyfry[i]!=A.cyfry[i]) {
	if (this.cyfry[i]<A.cyfry[i]) return true;
	return false;
      }
    }
    return false;
  }
  void przypisz (BigNum A) {
    this.znak=A.znak;
    this.pos=A.pos;
    for (int i=0; i<max_size; i++) this.cyfry[i]=A.cyfry[i];
  }
  void single_razy (int x) {
    int reszta=0;
    for (int i=0; i<=this.pos; i++) {
      int r= this.cyfry[i]*x+ reszta;
      this.cyfry[i]= r % 10;
      reszta = r/10;
    }
    if (reszta!=0) {
      this.pos++;
      this.cyfry[pos]=reszta;
    }
  }
  void przesun (int x) {
    for (int i=this.pos; i>=0; i--) {
      this.cyfry[i+x]=this.cyfry[i];
    }
    for (int i=0; i<x; i++) this.cyfry[i]=0;
    this.pos+=x;
  }
  void pol () {
    for (int i=0; i<=this.pos; i++) {
      if (this.cyfry[i]%2==1 && i>0) this.cyfry[i-1]+=5;
      this.cyfry[i]/=2;
    }
    if (this.cyfry[pos]==0 && pos>0)  pos--;
  }
  
  public void plus (BigNum A) {
    if (this.znak==0 && A.znak==0) {
      BigNum C= new BigNum(0);
      C.przypisz(A);
      C.znak=1;
      this.minus(C);
    }
    else if (this.znak==0 && A.znak==1) {
      BigNum C= new BigNum(0);
      C.przypisz(A);
      this.znak=1;
      C.minus(this);
      this.przypisz(C);
    }
    else if (this.znak==1 && A.znak==0) {
      BigNum C= new BigNum (0);
      C.przypisz(A);
      C.znak=1;
      this.minus(C);
    }
    else if (this.znak==1 && A.znak==1) {
      int reszta=0;
      for (int i=0; i<= Math.Max (this.pos, A.pos); i++) {
	int x= this.cyfry[i]+A.cyfry[i]+reszta;
	this.cyfry[i]=x % 10;
	reszta= x/10;
      }
      this.pos=Math.Max (this.pos, A.pos);
      if (reszta!=0) {
	pos++;
	this.cyfry[pos]=reszta;
      }
    }
  }
  public static BigNum suma (BigNum A, BigNum B) {
    BigNum res= new BigNum(0);
    res.przypisz (A);
    res.plus(B);
    return res;
  }
  public void minus (BigNum A) {
    if (this.znak==0 && A.znak==0) {
      BigNum C=new BigNum(0);
      C.przypisz(A);
      C.znak=1;
      this.plus(C);
    }
    else if (this.znak==0 && A.znak==1) {
      this.znak=1;
      this.plus(A);
      this.znak=0;
    }
    else if (this.znak==1 && A.znak==0) {
      BigNum C=new BigNum(0);
      C.przypisz (A);
      C.znak=1;
      this.plus (C);
    }
    else if (this.znak==1 && A.znak==1) {
      if (this.mniejsze(A)) {
	BigNum C= new BigNum (0);
	C.przypisz (A);
	C.minus(this);
	this.przypisz(C);
	this.znak=0;
      }
      else {
	for (int i=0; i<=this.pos; i++) {
	  if (this.cyfry[i]<A.cyfry[i]) {
	    int dokad=0;
	    for (int j=i+1; j<=pos; j++) {
	      if (this.cyfry[j]>A.cyfry[j]) {
		dokad=j;
		this.cyfry[j]--;
		break;
	      }
	    }
	    this.cyfry[i]+=10;
	    for (int j=i+1; j<dokad; j++) this.cyfry[j]+=9;
	  }
	  this.cyfry[i]-=A.cyfry[i];
	}
	this.pos=0;
	for (int i=max_size-1; i>=0; i--) {
	  if (this.cyfry[i]!=0) {
	    this.pos=i;
	    break;
	  }
	}
      }
    }
  }
  public static BigNum roznica (BigNum A, BigNum B) {
    BigNum res=new BigNum(0);
    res.przypisz (A);
    res.minus(B);
    return res;
  }
  
  public void razy (BigNum A) {
    BigNum Res= new BigNum (0);
    for (int i=0; i<=A.pos; i++) {
      BigNum C= new BigNum(0);
      C.przypisz (this);
      C.single_razy(A.cyfry[i]);
      C.przesun (i);
      Res.plus (C);
    }
    if (this.znak==A.znak) Res.znak=1;
    else Res.znak=0;
    this.przypisz (Res);
    
  }
  public static BigNum iloczyn (BigNum A, BigNum B) {
    BigNum res= new BigNum(0);
    res.przypisz (A);
    res.razy(B);
    return res;
  }
  public void podziel (BigNum A) {
    BigNum pocz= new BigNum (0);
    BigNum kon= new BigNum(0);
    kon.przypisz (this);
    kon.znak=1;
    BigNum jeden = new BigNum (1);
    kon.plus(jeden);
    BigNum s= new BigNum(0);
    BigNum C= new BigNum (0);
    C.przypisz (A);
    C.znak=1;
    while (pocz.mniejsze ( roznica(kon, jeden))) {
      s= suma (pocz, kon);
      s.pol();
      if (this.mniejsze (iloczyn(s, C))) kon.przypisz (s);
      else pocz.przypisz (s);
    }
    if (this.znak==A.znak) pocz.znak=1;
    else pocz.znak=0;
    this.przypisz (pocz);
  }
  
  public static BigNum iloraz (BigNum A, BigNum B) {
    BigNum res= new BigNum (0);
    res.przypisz (A);
    res.podziel (B);
    return res;
  }
  public void wypisz () {
    if (this.znak==0) Console.Write ("-");
    for (int i=pos; i>=0; i--) Console.Write ("{0}", this.cyfry[i]);
    Console.WriteLine();
  }
}


class MojProgram {
  public static void Main () {
    int x= Convert.ToInt32(Console.ReadLine());
    string znak=Console.ReadLine();
    int y= Convert.ToInt32(Console.ReadLine());
    BigNum A= new BigNum (x);
    BigNum B= new BigNum (y);
    BigNum C= new BigNum (0);
    if (znak=="*")  C= BigNum.iloczyn(A,B);
    else if (znak=="+") C= BigNum.suma(A,B);
    else if (znak=="-") C=BigNum.roznica(A,B);
    else if (znak=="/") C=BigNum.iloraz(A,B);
    C.wypisz();
  }
}
