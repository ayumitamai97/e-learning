class AddCategoryIdToWords < ActiveRecord::Migration[5.2]
  def up
    add_column :words, :category_id, :integer
  end
  def down
    remove_column :words, :category_id, :integer
  end
end
