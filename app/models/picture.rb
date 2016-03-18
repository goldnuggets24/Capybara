class Picture < ActiveRecord::Base
	scope :top_ten, -> {order('score DESC')}

	def self.home
		where("created_at >= ? AND created_at < ?", Date.today, Date.tomorrow).order('created_at ASC')
  	end

	def self.daily_capybara(s)
		low = Random.new.rand(0..100)
		results = GoogleCustomSearchApi.search("capybara", {"searchType" => "image", "num" => "10", "imgSize" => "huge", "LowRange" => low, "highRange" => low + 9, "hq" => s})
		r = Random.new.rand(0..9)
		image = results.items[r].image.thumbnailLink
		return image
	end
end