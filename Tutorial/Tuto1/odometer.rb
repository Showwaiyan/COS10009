def main()
    print "Enter beginning odometer reading: "
    beginningOdometer = gets.chomp.to_f

    print "Enter ending odometer reading: "
    endingOdometer = gets.chomp.to_f

    travelledKilometer = (endingOdometer-beginningOdometer).round(1);
    puts "You travelled #{travelledKilometer} kilometers."

    puts "At RM0.65 per kilometer. your reimbursement is RM#{(travelledKilometer*0.65).round(1)}."
end

main()