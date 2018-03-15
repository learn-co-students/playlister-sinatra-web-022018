class Artist < ActiveRecord::Base
  has_many :songs
  has_many :genres, through: :songs

  def slug
    temp = self.name
    temp.gsub(/[^\s0-9A-Za-z]/, '') if temp.gsub(/[^\s0-9A-Za-z]/, '') != nil
    temp.gsub(" ", '-').downcase
  end

  def self.find_by_slug(slug)
    Artist.all.find {|artist| artist.slug == slug}
  end
end
