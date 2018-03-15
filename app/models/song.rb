class Song < ActiveRecord::Base
  has_many :song_genres
  has_many :genres, through: :song_genres
  belongs_to :artist

  def slug
    temp = self.name
    temp.gsub(/[^\s0-9A-Za-z]/, '') if temp.gsub(/[^\s0-9A-Za-z]/, '') != nil
    temp.gsub(" ", '-').downcase
  end

  def self.find_by_slug(slug)
    Song.all.find {|song| song.slug == slug}
  end
end
