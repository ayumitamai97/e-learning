class AddNameAndAvatarToUsers < ActiveRecord::Migration[5.2]
  def up
    add_column :users, :name, :string
    add_column :users, :avatar, :string
  end
  def down
    remove_column :users, :name, :string
    remove_column :users, :avatar, :string
  end
end
