class Song

  attr_accessor :name, :album, :id

  def initialize(name:, album:, id: nil)
    @id = id
    @name = name
    @album = album
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS songs (
        id INTERGER PRIMARY KEY,
        name TEXT,
        album TEXT
      )
      SQL
    DB[:conn].execute(sql) 
  end

  def save
    sql = <<-SQL
    INSERT INTO songs (nam, album)
    VALUES (?, ?)
    SQL

    #insert the song
    DB[:conn].execute(sql, self.name, self.album)
  

  #get the song ID from the database and save it to the ruby instatnce
  self.id = DB[:conn].execute("SELECT last_insert rowid() FROM songs")[0][0]

  #return the Ruby instance
  self
  end

   def self.create(name:, album:)
    song = Song.new(name: name, album: album)
    song.save
  end

end

# hello = Song.new(name: "Hello", album: "25")
# hello.save
# gold_digger = Song.new(name: "Gold Digger", album: "Late Registration")
# gold_digger.save

 song = Song.create(name: "Hello", album: "25")
 song.name
 song.album
