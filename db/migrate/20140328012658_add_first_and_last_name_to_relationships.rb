class AddFirstAndLastNameToRelationships < ActiveRecord::Migration
  def change
  	add_column :people_relationships, :first_name, :string
  	add_column :people_relationships, :last_name, :string
  end
end
