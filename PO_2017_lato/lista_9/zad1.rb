class Funkcja

  def initialize (f)
    @f=f
  end

  def f
    @f
  end

  def value(x)
    f.call(x)
  end

  def zerowe (a, b, e)
    zeros= Array.new
    d=0.001
    while a<=b
      if (f.call(a)).abs <= e then zeros.push(a.round(3))
      end
      a+=d
      a.round(3)
    end
    if zeros.length==0 then return nil
    else return zeros
    end
  end

  def pole (a, b)
    d= (b-a).to_f/10000
    res= (f.call(a)+f.call(b))*d/2
    a+=d
    while a<b
      res+= f.call(a)*d
      a+=d
    end
    return res
  end

  def poch (x)
    h=0.00001
    (f.call(x+h)-f.call(x))/h
  end

  def narysuj_wykres (a, b, filename)
    file = File.new("data", "w")
    e=0.001
    while a<=b
      file.write("#{a} #{f.call(a)}\n")
      a+=e
    end
    IO.popen('gnuplot', 'w') { |io| io.puts "set terminal png; set output \"#{filename}.png\"; plot \"data\" using 1:2 with lines"}
  end
end

f= Funkcja.new(lambda {|x| x*x})

print "f(3) = " , f.value(3), "\n", "f(5)= " ,f.value(5), "\n"
print "miejsca zerowe : ", f.zerowe(-1, 10, 0.0000001), "\n"
print "pole od -5 do 5 : " ,f.pole(-5, 5), "\n"
print "pochodna w 2 :", f.poch(2), "\n"
f.narysuj_wykres(-1, 1, "x^2")
