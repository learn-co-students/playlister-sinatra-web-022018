module Slugifiable

  module InstanceMethods
    def slug
      arr = name.downcase.split
      arr.join("-")
    end
  end

  module ClassMethods
    def find_by_slug(slug)
      all.find {|x| x.slug == slug}
    end
  end

end
