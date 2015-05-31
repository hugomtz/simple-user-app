class AddAvatarImageIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :avatar_image_id, :string
  end
end
