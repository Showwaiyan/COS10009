def main()
    # Ticket variable for all
    ticketA = 0
    ticketB = 0
    ticketC = 0

    print "Enter number of tickets sold for Class A: "
    ticketA = gets.chomp.to_i
    classATotalTicket = ticketA*15

    print "Enter number of tickets sold for Class B: "
    ticketB = gets.chomp.to_i
    classBTotalTicket = ticketB*12

    print "Enter number of tickets sold for Class C: "
    ticketC = gets.chomp.to_i
    classCTotalTicket = ticketC*9

    puts "Total amount of income generate from ticket sales: "+(classATotalTicket+classBTotalTicket+classCTotalTicket).to_s
end

main()