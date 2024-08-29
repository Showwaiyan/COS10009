def main()
    print "Enter hourly wage: "
    hourlyWage = gets.chomp.to_i

    print "Enter number of hour worked: "
    numberOfHourWork = gets.chomp.to_i

    print "Enter number of holding percentage: "
    holdingPercentage =gets.chomp.to_i

    netWeeklyPay = (hourlyWage*numberOfHourWork)-holdingPercentage
    puts "Weekly net rate is #{netWeeklyPay}"
end

main()