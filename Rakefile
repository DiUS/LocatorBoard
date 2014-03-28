# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

LocatorBoard::Application.load_tasks

desc 'transform basic data into json'
task :transform => :environment do

  puts Rails.env


  	last_project = :none
  	first_user = :none

    data = []

  	PeopleRelationship.order(:proj_id).all.each do |pr|


  		if last_project != pr.proj_id
  			first_user = "#{pr.first_name} #{pr.last_name}"
  			last_project = pr.proj_id
  		else
        count = PeopleRelationship.where(:user_id=>pr.user_id).count
  			
        data << { :user1 => first_user, :user2 => "#{pr.first_name} #{pr.last_name}", :weight => count }

  		end

    end

    data = data.uniq


  File.open("#{Rails.root}/public/weighted_data.json", 'w') { |file| file.write "{\"data\":" + JSON.pretty_generate(data) + "}" }   


end