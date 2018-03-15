class Artist < ActiveRecord::Base
  has_many :songs
  has_many :genres, through: :songs

  def slug
    self.name.downcase.split(" ").join("-")
  end

  def self.find_by_slug(slug)
    out = Artist.all.select do |artist|
      artist.slug == slug
    end
    out[0]
  end
end
