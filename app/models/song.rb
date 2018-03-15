class Song < ActiveRecord::Base
	include Slugifier::Instance
	extend Slugifier::Class
	belongs_to :artist
	has_many :song_genres
	has_many :genres, through: :song_genres
end
