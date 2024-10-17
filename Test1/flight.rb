require './input_functions'

# Complete the code below
# Use input_functions to read the data from the user

class Flight 
   attr_accessor :flight_id, :flight_name,  :origin_airport, :destination_airport

    def initialize (flight_id, flight_name, origin_airport, destination_airport)
        @flight_id = flight_id
        @flight_name = flight_name
        @origin_airport = origin_airport
        @destination_airport = destination_airport
    end
end

def read_a_flight()
    # flight = Flight.new
    # flight.flight_id = read_integer("Enter Plane id: ")
    # flight.flight_name = read_string("Enter flight name: ")
    # flight.origin_airport = read_string("Enter origin airport: ")
    # flight.destination_airport = read_string("Enter destination airport: ")
    return Flight.new(read_integer("Enter plane id: "), 
                      read_string("Enter flight name: "), 
                      read_string("Enter origin airport: "), 
                      read_string("Enter destination airport: "))
end

def read_flights()
    flights = []
    puts "How many flights are you entering:"
    i = read_integer("")
    while i > 0
        flights.push(read_a_flight())
        i -= 1
    end
    return flights
end

def print_a_flight(flight)
    puts "Plan id " + flight.flight_id.to_s
    puts "Flight " + flight.flight_name.to_s
    puts "Origin " + flight.origin_airport.to_s
    puts "Destination " + flight.destination_airport.to_s
end

def print_flights(flights)
    i = 0
    while i < flights.length
        print_a_flight(flights[i])
        i += 1
    end
end

def main()
	flights = read_flights()
	print_flights(flights)
end

main()