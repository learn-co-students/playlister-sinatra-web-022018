class Genre < ActiveRecord::Base
  has_and_belongs_to_many :songs
  has_many :artists, through: :songs

  include Slugifiable::InstanceMethods
  extend Slugifiable::ClassMethods

end
