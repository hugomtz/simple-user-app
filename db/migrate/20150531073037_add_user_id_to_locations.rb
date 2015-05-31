class AddUserIdToLocations < ActiveRecord::Migration
  def up
    add_column :locations, :user_id, :integer
  end
  
  def down
    remove_column :locations, :user_id
  end
end
