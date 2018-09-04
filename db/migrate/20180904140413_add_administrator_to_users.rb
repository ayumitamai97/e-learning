class AddAdministratorToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :admin, :boolean, default: false
  end
end

# thanks to https://kyoto-diary.com/rails-admin/
