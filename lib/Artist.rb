class Artist
    extend Concerns::Findable

    attr_accessor :name, :genre

    @@all = []

    def initialize(name)
        @name = name
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

    def add_song(song)
        if song.artist
        else
            song.artist = self 
        end
    end

    def songs
        Song.all.select {|songs| songs.artist == self}
    end

    def genres
        songs.collect {|songs| songs.genre}.uniq
    end

end
