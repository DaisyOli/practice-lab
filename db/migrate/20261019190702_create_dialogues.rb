class CreateDialogues < ActiveRecord::Migration[8.1]
  def change
    create_table :dialogues do |t|
      t.string :title, null: false
      t.string :cefr_level, null: false
      t.string :language, null: false

      t.timestamps
    end
  end
end
