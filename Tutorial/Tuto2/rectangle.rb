def calculateArea(l,w)
    return l*w
end

def calculateParameter(l,w)
    return 2*(l+w)
end

def askInput()
    return gets.chomp.to_f()
end

def printOutput(l,w)
    puts "The area of rantangle is #{calculateArea(l,w)}\nThe parameter of rantangle is #{calculateParameter(l,w)}"
end

def main()

    print "Enter lenght of Rectangle: "
    lenght = askInput()

    print "Enter width of Rectangle: "
    width = askInput()

    printOutput(lenght,width)
end

main()