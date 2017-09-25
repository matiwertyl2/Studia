def run
  puts "zaraz sie zacznie\n"
  yield
  yield
  yield
  puts "juz sie skonczylo\n"
end


run {print "dwa dodac dwa to", 2+2, "\n"}


def dodawanie
  yield 2,2
  yield 3,4
end
dodawanie {|x, y| puts x + y }


blok = lambda {|x| x*x}

print blok.call(3)
