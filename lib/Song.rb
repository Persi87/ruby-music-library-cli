class Song

        attr_accessor :name 
        attr_reader :artist, :genre

        @@all = []

    def initialize(name, artist = nil, genre = nil)
        @name = name
        self.artist = artist if artist
        self.genre = genre if genre
    end

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end

    def genre=(genre)
        @genre = genre
    end
        
    def self.all
        @@all
    end

    def self.destroy_all
        @@all.clear
    end

    def save
        @@all << self
    end

    def self.create(name)
        self.new(name).save
        self.all.last
    end

    def self.find_by_name(name)
        all.find {|songs| songs.name == name}
    end

    def self.find_or_create_by_name(name)
       if find_by_name(name)
          find_by_name(name)
       else
        create(name)
       end
    end
    
    def self.new_from_filename(filename)
        file_array = filename.split(" - ")
        artist = Artist.find_or_create_by_name(file_array[0])
        genre = Genre.find_or_create_by_name(file_array[2].chomp(".mp3"))
        new(file_array[1], artist, genre)
    end

    def self.create_from_filename(filename)
        new_from_filename(filename).save
    end




end
