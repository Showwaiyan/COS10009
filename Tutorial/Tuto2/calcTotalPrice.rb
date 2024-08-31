def readPrice()
    print "Enter the price of item: "
    return gets.chomp.to_f()
end

def readQuantity()
    print "Enter the quantity of item: "
    return gets.chomp.to_f()
end

def calculateTotalPrice(price,quantity,discountRate)
    return (price*quantity)-((price*quantity)*discountRate)/100
end

def printTotalPrice(price,quantity,discountRate,totalPrice)
    puts "Total #{quantity} of item with #{price}$ costs #{totalPrice}$ at the disocount rate of #{discountRate}"
end

def main()
    price = readPrice()
    quantity = readQuantity()
    discountRate = 20
    totalPrice =calculateTotalPrice(price,quantity,discountRate)
    printTotalPrice(price,quantity,discountRate,totalPrice)
end

main()