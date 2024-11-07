def main
  print "Enter your age: "
  age = gets.chomp.to_i
  if age < 0 || age > 120
    puts "Invalid age"
  elsif age <= 12
    puts "You are a child"
  elsif age <= 19
    puts "You are a teenager"
  else 
    puts "You are an adult"
  end
end

main