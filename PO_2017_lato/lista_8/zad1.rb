class Fixnum

  def czynniki
    divisors= Array.new
    x=1
    while x<=self
      if self % x ==0 then divisors.push(x)
      end
      x=x+1
    end
    return divisors
  end

  def ack (y)
    if self==0 then return y+1
    elsif y==0 then return (self-1).ack(1)
    else return (self-1).ack(self.ack(y-1))
    end
  end

  def doskonala
    divisors= self.czynniki
    suma=0
    divisors.each{| d | suma+=d}
    if suma==2*self then return true
    else return false
    end
  end

  def slownie
    slownik= {
      0 => "zero",
      1 => "jeden",
      2 => "dwa",
      3 => "trzy",
      4 => "cztery",
      5 => "piec",
      6 => "szesc",
      7 => "siedem",
      8 => "osiem",
      9 => "dziewiec"
    }
    if self==0 then return ""
    else return (self/10).slownie + slownik[self % 10] + " "
    end
  end
end


print "Ack (2, 1) = " , 2.ack(1) ,"\n"
print "Ack (2, 2) = " , 2.ack(2) , "\n"
print "Ack (3, 3) = " , 3.ack(3) , "\n"
print "Ack (3, 4) = ", 3.ack(4),  "\n"
print "Liczby doskonale od 1 do 500\n"
1.upto(500) do |x|
  if x.doskonala then print x, "\n"
  end
end
print 123, " slownie : ", 123.slownie, "\n"
print 32122908, " slownie : ", 32122908.slownie, "\n"
