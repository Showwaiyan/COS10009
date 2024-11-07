def read_array()
  # put code here
  arr = []
  print "How many integers are you entering? "
  count = gets.chomp.to_i
  i = 0
  while i < count
    print "Enter integer: "
    arr << gets.chomp.to_i
    i += 1
  end

  return arr
end

def print_array(a)
  # put code here
  puts "Printing integers:"
  i = 0
  while i < a.length
    puts a[i]
    i += 1 
  end
end

def main()
   # put code here
   print_array(read_array())
end

main()