def calculateArea(l,w)
    return l*w
end

def calculateParameter(l,w)
    return 2*(l+w)
end

def main()

    print "Enter lenght of Rectangle: "
    lenght = gets.chomp.to_f()

    print "Enter width of Rectangle: "
    width = gets.chomp.to_f()

    puts "The area of rantangle is #{calculateArea(lenght,width)}"
    puts "The parameter of rantangle is #{calculateParameter(lenght,width)}"
end

main()