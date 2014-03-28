class CreatePeopleRelationships < ActiveRecord::Migration
  def change
    create_table :people_relationships do |t|
      t.integer :client_id
      t.integer :proj_id
      t.integer :user_id
      t.string :client
      t.string :project
      t.string :username
      t.integer :removed

      t.timestamps
    end
  end
end
