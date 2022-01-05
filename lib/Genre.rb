class Genre
    extend Concerns::Findable


    attr_accessor :name

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

    def songs
        Song.all.select {|songs| songs.genre == self}
    end
 
    def artists
        songs.collect {|songs| songs.artist}.uniq
    end

end