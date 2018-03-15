module Slugifier
	module Instance
		def slug
			self.name.gsub(' ', '-').downcase
		end
	end

	module Class
		def find_by_slug(slug)
			self.all.find {|item| slug == item.slug}
		end
	end
end

