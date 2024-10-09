# put your code here:
class Track
	attr_accessor :name, :location
	def initialize(name, location)
		@name = name
		@locatoin = location
	end
end

def read_track(a_file)
	read_name = a_file.gets().chomp.to_s
	read_location = a_file.gets().chomp.to_s
	a_file.close()

	track = Track.new(read_name, read_location)
	return track
end

def print_track(track)
	puts "Track name: #{track.name}"
	puts "Track location: #{track.location}"
end

def main()
	track_file = File.new("track.txt","r")
	track = read_track(track_file)
	print_track(track)
end

main() if _FILE_ == $0 # leave this