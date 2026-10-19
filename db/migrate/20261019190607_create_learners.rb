class CreateLearners < ActiveRecord::Migration[8.1]
  def change
    create_table :learners do |t|
      t.string :name, null: false
      t.string :cefr_level, null: false

      t.timestamps
    end
  end
end
