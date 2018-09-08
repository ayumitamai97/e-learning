class CreateWordAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :word_answers do |t|
      t.integer :user_id
      t.integer :category_id
      t.integer :lesson_id
      t.integer :word_id
      t.string :answer

      t.timestamps
    end
  end
end
