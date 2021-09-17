class Song < ActiveRecord::Base
  belongs_to :artist
  belongs_to :genre
  has_many :notes

  def artist_name=(name)
    self.artist = Artist.find_or_create_by(name: name)
  end

  def artist_name
    if self.artist
      self.artist.name
    else
      nil
    end
  end

  def genre_name=(name)
    self.genre = Genre.find_or_create_by(name: name)
  end

  def genre_name
    if self.genre
      self.genre
    else
      nil
    end
  end

  def note_contents=(contents)
    contents.each do |content|
      if content.strip != "" || content.strip != nil
        note_content = self.notes.new(content: content)
        note_content.song_id = self.id
        note_content.save
      end
    end
  end

  def note_contents
    notes.map{|note| note.content}
  end

  end
