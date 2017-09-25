class Jawna

  def initialize(slowo)
    @slowo= slowo
  end

  def slowo
    @slowo
  end

  def to_s
    return self.slowo
  end

  def zaszyfruj (klucz)
    szyfrowane=""
    self.slowo.split("").each { | c | szyfrowane+=klucz[c]}
    return Zaszyfrowane.new(szyfrowane)
  end
end

class Zaszyfrowane
  def initialize(slowo)
    @slowo =slowo
  end

  def slowo
    @slowo
  end

  def to_s
    return self.slowo
  end

  def odszyfruj (klucz)
    alfabet="abcdefghijklmnopqrstuwxyz"
    odszyfrowane=""
    self.slowo.split("").each { |c|
      alfabet.split("").each{ |letter|
        if klucz[letter]==c then odszyfrowane+=letter
        end
      }
    }
    return Jawna.new(odszyfrowane)
  end
end

X= Jawna.new("abcdef")
Y=Zaszyfrowane.new("abcdef")
szyfr = {
'a' => 'b',
'b' => 'c',
'c' => 'd',
'd' => 'e',
'e' => 'f',
'f' => 'g',
'g' => 'h',
'h' => 'i',
'i' => 'j',
'j' => 'k',
'k' => 'l',
'l' => 'm',
'm' => 'n',
'n' => 'o',
'o' => 'p',
'p' => 'q',
'q' => 'r',
'r' => 's',
's' => 't',
't' => 'u',
'u' => 'v',
'v' => 'w',
'w' => 'x',
'x' => 'y',
'y' => 'z',
'z' => 'a'
}

print "jawne : ", X, " zaszyfrowane : ", X.zaszyfruj(szyfr), "\n"
print "zaszyfrowane :", Y, " jawne : ", Y.odszyfruj(szyfr), "\n"
