require "./input_functions"

# put your code here - make sure you use the input_functions to read strings and integers
def read_labelinput()
	# Reading title
	title = read_string("Pleaes enter your title: (Mr, Mrs, Ms, Miss, Dr)")

	# Reading first name
	firstName = read_string("Please enter your first name:")

	# Reading last name
	lastName = read_string("Please enter your last name:")

	# Reading address
		# house or unit number
	unit = read_string("Please enter the house or unit number:")

		# street name 
	street = read_string("Please enter the street name:")

		# suburh
	suburh = read_string("Please enter the suburh:")

		# postcode
	postCode = read_integer_in_range("Please enter a postcode (0000 - 9999)",0,9999).to_s()

	# return the label string in the format of letter
	return "#{title} #{firstName} #{lastName}\n#{unit} #{street}\n#{suburh} #{postCode.to_s}\n"
end

def read_message()
	# Reading subject line
	subject = read_string("Please enter your message subject line:")

	# Reading the content of message 
	message = read_string("Please enter your message content:")

	# Return the subject and content in the format
	return "RE: #{subject}\n\n#{message}"
end

def print_labelandmessage(label, message)
	puts label+message
end

def main()
    # Reading labels and assign to variables
    labels = read_labelinput()

    # Reading subject line and message ,and assign to varibales
    message = read_message()

    # Printing the label and message
    print_labelandmessage(labels, message)
end

main()