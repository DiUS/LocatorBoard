# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


config = LocatorBoard::Application.config.database_configuration[::Rails.env]
dbhost, dbuser, dbname = config['host'], config['username'], config['database']

dbhost = "localhost"

copy_command = "\\copy people_relationships (client_id, proj_id, user_id, client, project, username, removed) from '#{Rails.root}/db/people_relationships.csv' csv header;"
sql_command = "psql -U #{dbuser} -h #{dbhost} #{dbname} -c \"#{copy_command}\""

puts sql_command

`#{sql_command}`