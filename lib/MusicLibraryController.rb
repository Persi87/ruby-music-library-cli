class MusicLibraryController

    def initialize(path = "./db/mp3s")
        MusicImporter.new(path).import
    end


    def call
        user_input = ""
        until user_input == "exit" do
            puts "Welcome to your music library!"
            puts "To list all of your songs, enter 'list songs'."
            puts "To list all of the artists in your library, enter 'list artists'."
            puts "To list all of the genres in your library, enter 'list genres'."
            puts "To list all of the songs by a particular artist, enter 'list artist'."
            puts "To list all of the songs of a particular genre, enter 'list genre'."
            puts "To play a song, enter 'play song'."
            puts "To quit, type 'exit'."
            puts "What would you like to do?"
                user_input = gets.chomp
        
        

            if user_input == "list songs"
                list_songs
            elsif user_input == "list artists"
                list_artists
            elsif user_input == "list genres"
                list_genres
            elsif user_input == "list artist"
                list_songs_by_artist
            elsif user_input == "list genre"
                list_songs_by_genre
            elsif user_input == "play song"
                play_song
            end
        end
    end

    def list_songs
        Song.all.sort {|a, b| a.name <=> b.name}.each_with_index do |song, index|
            puts "#{index + 1}. #{song.artist.name} - #{song.name} - #{song.genre.name}" 
        end
    end

    def list_artists
        Artist.all.sort {|a, b| a.name <=> b.name}.each_with_index do |artist, index|
            puts "#{index + 1}. #{artist.name}" 
        end
    end

    def list_genres
        Genre.all.sort {|a, b| a.name <=> b.name}.each_with_index do |genre, index|
            puts "#{index + 1}. #{genre.name}" 
        end
    end

    def list_songs_by_artist                        
        puts "Please enter the name of an artist:"
        input = gets.chomp
        artist = Artist.find_by_name(input) 
        if artist
            artist.songs.sort {|a, b| a.name <=> b.name}.each_with_index do |song, index|
                puts "#{index + 1}. #{song.name} - #{song.genre.name}"
            end
        end
    end

    # if input doesn't match an genre, it will evaluate as nil, if it does match a genre, it will evaluate as true
    # The output of Genre.find_By_name(input) saves to variable genre - if genre is true, if will run
    # if genre is nil, if will not run (the only things that evaluate as false are "nil" and "false")

    def list_songs_by_genre                       
        puts "Please enter the name of a genre:"
        input = gets.chomp
        if genre = Genre.find_by_name(input)    
            genre.songs.sort {|a, b| a.name <=> b.name}.each_with_index do |song, index| 
                puts "#{index + 1}. #{song.artist.name} - #{song.name}"
            end
        end
    end

    def play_song
        puts "Which song number would you like to play?"
        song_number = gets.strip.to_i
            if (1..Song.all.length).include?(song_number)
                song = Song.all.sort {|a, b| a.name <=> b.name}[song_number - 1]
            end
        puts "Playing #{song.name} by #{song.artist.name}" if song
    end

end