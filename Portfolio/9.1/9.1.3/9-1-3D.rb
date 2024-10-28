require 'rubygems'
require 'gosu'

TOP_COLOR = Gosu::Color.new(0xFF1EB1FA)
BOTTOM_COLOR = Gosu::Color.new(0xFF1D4DB5)

WIDTH = 1000
HEIGHT = 500

MARGIN = 10

ALBUM_WIDTH = 220
ALBUM_HEIGHT = 220

TrackLeftX = 500

module ZOrder
  BACKGROUND, PLAYER, UI = *0..2
end

module Genre
  POP, CLASSIC, JAZZ, ROCK = *1..4
end

GENRE_NAMES = ['Null', 'Pop', 'Classic', 'Jazz', 'Rock']

class ArtWork
	# alburm artwork file name are in the format of
	# album_artist+album_title.bmp => all lower case
	attr_accessor :bmp

	def initialize (file)
		@bmp = Gosu::Image.new(file)
	end
end

class Album
	attr_accessor :artist, :title, :record_label, :genre, :tracks, :artwork

	def initialize (artist, title, record_label, genre, tracks)
		# insert lines here
		@artist = artist
		@title = title
    @record_label = record_label
		@genre = genre
		@tracks = tracks
		@artwork = ArtWork.new(("artwork/"+artist.downcase + title.downcase + ".jpg").gsub(/\s+/, ""))
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

# Put your record definitions here

class MusicPlayerMain < Gosu::Window

	def initialize
		super WIDTH, HEIGHT
		self.caption = "Music Player"
		@albums = []
		@current_album = nil
		@current_track = nil
		@music_file = File.new("albums.txt", "r")
		self.read_albums(@music_file, @albums)
		@title_font = Gosu::Font.new(40)
		@track_font = Gosu::Font.new(20)
		# Reads in an array of albums from a file and then prints all the albums in the
		# array to the terminal
	end

  # Put in your code here to load albums and tracks
	# Album Reading
	def read_albums(music_file, albums)
		album_count = music_file.gets().to_i()
	
		album_id = albums.nil? ? 1 : albums.length + 1
	
		i = 0
		while i < album_count do
			albums.append(read_album(music_file,album_id))
			i += 1
			album_id += 1
		end 
	end

	def read_album(music_file, id)

		album_artist = music_file.gets()
		album_title = music_file.gets()
		album_record_label = music_file.gets()
		album_genre = music_file.gets().to_i
		tracks = read_tracks(music_file)
	
		album = Album.new(album_artist, album_title, album_record_label, album_genre, tracks)
		return album
	end

	# Track Reading
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

  # Draws the artwork on the screen for all the albums
  def draw_albums albums
    # complete this code
		index = 0
		row = 0
		while row < 2 do
			column = 0
			while column < 2 do
				album = albums[index]
				album.artwork.bmp.draw(column * (ALBUM_WIDTH + MARGIN) + 10, row * (ALBUM_HEIGHT + MARGIN) + 20, ZOrder::PLAYER)
				index += 1
				column += 1
			end
			row += 1
		end
  end

  # Detects if a 'mouse sensitive' area has been clicked on
  # i.e either an album or a track. returns true or false

  def area_clicked(leftX, topY, rightX, bottomY)
     # complete this code
		 if mouse_x > leftX && mouse_x < rightX && mouse_y > topY && mouse_y < bottomY
			return true
		 else
			return false
		 end
  end


  # Takes a String title and an Integer ypos
  # You may want to use the following:
  def display_track(title, ypos, color = Gosu::Color::BLACK)
  	@track_font.draw_text(title, TrackLeftX, ypos, ZOrder::UI, 1.0, 1.0, color)
  end

	def draw_tracks(album)
		return if album.nil?
		@title_font.draw_text("Tracks from #{album.title}", TrackLeftX, 0, ZOrder::UI, 1.0, 1.0, Gosu::Color::WHITE)

		if album.tracks.length == 0 
			display_track("No Track Avaiable!", 40, Gosu::Color::RED)
			return
		end

		i = 0
		while i < album.tracks.length do
			display_track("#{i+1}. "+album.tracks[i].title,((i+1) * 40), @current_track == album.tracks[i] ? Gosu::Color::GREEN : Gosu::Color::BLACK)
			i += 1
		end
	end


  # Takes a track index and an Album and plays the Track from the Album

  def playTrack(track, album)
  	 # complete the missing code
  			@song = Gosu::Song.new("songs/nevergonnagiveyouup.mp3")
  			@song.play(false)
    # Uncomment the following and indent correctly:
  	#	end
  	# end
  end

# Draw a coloured background using TOP_COLOR and BOTTOM_COLOR

	def draw_background
		Gosu.draw_quad(
      0, 0, TOP_COLOR,           # Top left
      WIDTH, 0, TOP_COLOR,        # Top right
      WIDTH, HEIGHT, BOTTOM_COLOR, # Bottom right
      0, HEIGHT, BOTTOM_COLOR,     # Bottom left
			ZOrder::BACKGROUND
    )
	end

# Not used? Everything depends on mouse actions.

	def update
	end

 # Draws the album images and the track list for the selected album

	def draw
		# Complete the missing code
		draw_background
		draw_albums(@albums)
		draw_tracks(@current_album)
	end

 	def needs_cursor?; true; end

	# If the button area (rectangle) has been clicked on change the background color
	# also store the mouse_x and mouse_y attributes that we 'inherit' from Gosu
	# you will learn about inheritance in the OOP unit - for now just accept that
	# these are available and filled with the latest x and y locations of the mouse click.

	def button_down(id)
		case id
			when Gosu::KB_ESCAPE
				close
	    when Gosu::MsLeft
		# What should happen here?
			# Album Clicked
			if area_clicked(10, 20, 230, 240)
				@current_album = @albums[0]
			elsif area_clicked(240, 20, 460, 240)
				@current_album = @albums[1]
			elsif area_clicked(10, 250, 230, 470)
				@current_album = @albums[2]
			elsif area_clicked(240, 250, 460, 470)
				@current_album = @albums[3]
			end

			# Track Clicked
			if area_clicked(TrackLeftX, 40, WIDTH, HEIGHT) && !@current_album.nil? && @current_album.tracks.length > 0
				index = (mouse_y - 40) / 40	
				@current_track = @current_album.tracks[index] if index < @current_album.tracks.length
				playTrack(@current_track, @current_album) if !@current_track.nil?
			end
	  end
	end

end

# Show is a method that loops through update and draw

MusicPlayerMain.new.show if __FILE__ == $0