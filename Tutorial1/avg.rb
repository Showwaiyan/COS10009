def calculateAvg(num1, num2, num3)
    return (num1+num2+num3)/3
end

def main()
    print "Enter number: "
    num1 = gets.chomp.to_i()


    print "Enter number: "
    num2 = gets.chomp.to_i()


    print "Enter number: "
    num3 = gets.chomp.to_i()

    puts "The average is "+calculateAvg(num1,num2,num3).to_s()
end


main()