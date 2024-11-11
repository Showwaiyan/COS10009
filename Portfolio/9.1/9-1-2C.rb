require './input_functions'

# It is suggested that you put together code from your 
# previous tasks to start this. eg:
# 8.1T Read Album with Tracks

module Genre
  POP, CLASSIC, JAZZ, ROCK = *1..4
end

$genre_names = ['Null', 'Pop', 'Classic', 'Jazz', 'Rock']

class Album
	attr_accessor :id, :artist, :title, :record_label, :genre, :tracks 

	def initialize (id, artist, title, record_label, genre, tracks)
		# insert lines here
    @id = id
		@artist = artist
		@title = title
    @record_label = record_label
		@genre = genre
		@tracks = tracks
	end
end

class Track
	attr_accessor :id, :title, :file_location, :duration

	def initialize (id, name, location, duration)
    @id = id
		@title = name
		@file_location = location
    @duration = duration
	end
end


def read_track(music_file, id)
  track_id = id + 1
  track_title = music_file.gets().chomp
  track_file_location = music_file.gets().chomp
  track_duration = music_file.gets().chomp
	return Track.new(track_id, track_title, track_file_location, track_duration);
end

def read_tracks(music_file)
	
	track_count = music_file.gets().to_i()
  tracks = []

    i=0
  	while i< track_count do
    	track = read_track(music_file, i)
    	tracks << track
    	i+=1
  	end

	return tracks
end


def print_tracks(tracks)
  i=0
  while i<tracks.length do
    print_track(tracks[i])
    i+=1
  end
end


def read_album(music_file, id)

  album_id = id
  album_artist = music_file.gets()
  album_title = music_file.gets()
  album_record_label = music_file.gets()
  album_genre = music_file.gets().to_i
  tracks = read_tracks(music_file)

	album = Album.new(album_id, album_artist, album_title, album_record_label, album_genre, tracks)
	return album
end


def print_album(album)
  puts "-----------------------------------"
  puts "Album ID: " + album.id.to_s
  puts "Artist: " + album.artist
  puts "Title: " + album.title
  puts "Record Label: " + album.record_label
  puts "Genre: " + $genre_names[album.genre]
  puts "\n"
	# print_tracks(album.tracks)
  puts "-----------------------------------"
end

def print_track(track)
  puts "Track ID: " + track.id.to_s
  puts "Track Title: " + track.title
  puts "Track File Location: " + track.file_location
  puts "Track Duration: " + track.duration
  puts "\n"
end

def read_in_ablums(music_file, albums)
  album_count = music_file.gets().to_i()

  # to track album id dynamically, even for user added album
  album_id = albums.nil? ? 1 : albums.length + 1

  i = 0
  while i < album_count do
    albums.append(read_album(music_file,album_id))
    i += 1
    album_id += 1
  end 
end

def display_albums(albums)
  puts "Albums Display" 
  puts "1. Display all albums"
  puts "2. Display albums by genre"
  puts "3. Exit"
  choice = read_integer_in_range("Please enter your choice:", 1, 3)

  puts "***********************************"

  case choice
  when 1
    i = 0
    while i < albums.length do
      print_album(albums[i])
      i += 1
    end
  when 2
    puts "Select Genre"
    puts "1. Pop"
    puts "2. Classic"
    puts "3. Jazz"
    puts "4. Rock"
    puts "5. Exit"
    genre_choice = read_integer_in_range("Please enter your choice:", 1, 4)

    return if (genre_choice == 5)# intance of return to main menu

    puts "***********************************"

    genre_albums = albums.select { |album| album.genre === genre_choice }
    i = 0
    while i < genre_albums.length do
      print_album(genre_albums[i])
      i += 1
    end
  when 3
    return # instance of return to main menu
  end
end

def select_album_to_play(albums)
  puts "1. Select Album to play by ID" 
  puts "2. Display albums"
  puts "3. Exit"
  choice = read_integer_in_range("Please enter your choice:", 1, 3)

  puts "***********************************"

  case choice
  when 1
    album_id = read_integer("Please enter the album ID:") 
    album_found = false
    while (!album_found) do
      # check if the album id is valid
      if (album_id < 1 || album_id > albums.length) 
        puts "Invalid Album ID, Please enter the correct Album ID!"
        album_id = read_integer("Please enter the album ID:")
        puts "***********************************"
      else album_found = true
      end
    end
    print_tracks(albums[album_id - 1].tracks)
    select_track_to_play(albums[album_id - 1].tracks, albums[album_id - 1].title)
  when 2
    display_albums(albums)
  when 3
    return # instance of return to main menu
  end
end

def select_track_to_play(tracks,album_title)
  puts "1. Select Track to play by ID"
  puts "2. Exist"
  choice = read_integer_in_range("Please enter your choice:", 1, 2)

  puts "***********************************"

  case choice
  when 1
    track_id = read_integer("Please enter the track ID:") 
    track_found = false
    while (!track_found) do
      # check if the track id is valid
      if (track_id < 1 || track_id > tracks.length) 
        puts "Invalid Track ID, Please enter the correct Track ID!"
        track_id = read_integer("Please enter the track ID:")
      else track_found = true
      end
    end
    puts "Playing Track: " + tracks[track_id - 1].title + " from album: " + album_title
    sleep(5)
    puts "***********************************"
  when 2
    return # instance of return to main menu
  end
end

def add_an_album(albums)
  puts "++++++++++++++++++++++++++++++++++++++++++++"
  puts "Add an Album"
  if !albums.nil?
    album_id = albums.length + 1
  else
    album_id = 1
  end
  album_artist = read_string("Please enter the artist name:")
  album_title = read_string("Please enter the album title:")
  album_record_label = read_string("Please enter the record label:")
  puts "Select Genre"
  puts "1. Pop"
  puts "2. Classic"
  puts "3. Jazz"
  puts "4. Rock"
  genre_choice = read_integer_in_range("Please enter your choice:", 1, 4)
  tracks = read_tracks_from_user

  album = Album.new(album_id, album_artist, album_title, album_record_label, genre_choice, tracks)
  albums.append(album)
  puts "++++++++++++++++++++++++++++++++++++++++++++"
  puts "Alnum added: #{album.title}."
  read_string("Press Enter to continue")
end

def read_tracks_from_user()
  tracks = []
  puts "-----------------------------------"
  puts "Enter number of tracks"
  track_count = read_integer("Please enter the number of tracks:")
  i = 0
  while i < track_count do
    track_id = i + 1
    track_title = read_string("Enter a name for new track:")
    track_file_location = read_string("Please a location for new track file:")
    track_duration = 0.to_s # making defualt duration to 0
    track = Track.new(track_id, track_title, track_file_location, track_duration)
    tracks.append(track)
    i += 1
  end
  puts "-----------------------------------"

  return tracks
end

def main()
	music_file = nil
  albums = []

  finished = false
  begin
    puts "1. Read in Albums"
    puts "2. Display Albums"
    puts "3. Select Album to play"
    puts "4. Add an Album"
    puts "5. Exit the applicatoin"

    choice = read_integer_in_range("Please enter your choice:", 1, 5)
    puts "***********************************"

    case choice
    when 1
      # Checking file existance
      file_found = false
      while (!file_found) do
        file_name = read_string("Please enter the file name:") 

        if (File.exist?(file_name))
          music_file = File.new(file_name, "r")
          file_found = true
        else
          puts "File not found, please enter the correct file name!"
        end
      end
      
      puts "***********************************"

      # read the album file if file exists
      read_in_ablums(music_file, albums)
    when 2
      if albums.empty?
        # in case user enter this option without reading the file
        puts "!!!!!!!!!!!!!!!!!!!!!!!!"
        puts "No Albums are not loaded yet, Please go to Read in Alnums section!" 
        puts "!!!!!!!!!!!!!!!!!!!!!!!!"
        next
      end
      display_albums(albums)
    when 3
      if albums.empty?
        # in case user enter this option without reading the file
        puts "!!!!!!!!!!!!!!!!!!!!!!!!"
        puts "No Albums are not loaded yet, Please go to Read in Alnums section!" 
        puts "!!!!!!!!!!!!!!!!!!!!!!!!"
        next
      end
      select_album_to_play(albums)
    when 4
      add_an_album(albums)
    when 5
      finished = true
    end
  end until finished
end

main()