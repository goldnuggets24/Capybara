require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

namespace :capybara do
	desc "Purge stale capybara and serve new one"
	task purge_capybara: :environment do
		puts "Purging old capybara..."

	 	image = Picture.daily_capybara('')
		
		images_from_last_week = Array.new
		Picture.where("created_at >= ?", 1.week.ago.utc).each do |picture|
			images_from_last_week << picture
		end
		
		unless images_from_last_week.include?(image)
			picture = Picture.new(:image => image)
			picture.save
			puts "new capybara saved"
		else
			Rake::Task["capybara:purge_capybara"].execute
		end
	end
end