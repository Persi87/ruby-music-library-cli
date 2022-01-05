class MusicImporter

    attr_accessor :path

    def initialize(path)
        @path = path
    end

    def files
        mp3_files = Dir.entries(@path)
        mp3_files.delete_if {|files| files == ".." || files == "."}
    end

    def import
        files.each {|music_files| Song.create_from_filename(music_files)} #uses the return array from #files
    end                                     # iterates through the files and sends each one to the create_from_filename method
    
end