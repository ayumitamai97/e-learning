class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.integer :user_id, null: false
      t.integer :following_id
      t.integer :lesson_id

      t.timestamps
    end
  end
end
