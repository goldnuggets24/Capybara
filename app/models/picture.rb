class Picture < ActiveRecord::Base
	default_scope { order("score DESC") }

	def self.daily_capybara(s)
		s = s
		low = Random.new.rand(0..100)
		results = GoogleCustomSearchApi.search("capybara", {"searchType" => "image", "num" => "10", "imgSize" => "huge", "LowRange" => low, "highRange" => low + 9, "hq" => s})
		r = Random.new.rand(0..9)
		image = results.items[r].image.thumbnailLink
		return image
	end
end
