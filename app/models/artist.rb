class Artist < ActiveRecord::Base
	include Slugifier::Instance
	extend Slugifier::Class
	has_many :songs
	has_many :genres, through: :songs
end