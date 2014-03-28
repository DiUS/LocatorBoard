# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

LocatorBoard::Application.load_tasks

desc 'transform basic data into json'
task :transform => :environment do

  puts Rails.env

  File.open("#{Rails.root}/public/data.json", 'w') do |file|
  	
  	file.write("{data: [")

  	last_project = :none
  	first_user = :none

  	PeopleRelationship.order(:proj_id).all.each do |pr|


  		if last_project != pr.proj_id
  			first_user = "#{pr.first_name} #{pr.last_name}"
  			last_project = pr.proj_id
  		else
  			file.write "{\"user1\": \"#{first_user}\", \"user2:\" \"#{pr.first_name} #{pr.last_name}\"},\n"

  		end


  	end

  	file.write "]}"
  	
  end


end