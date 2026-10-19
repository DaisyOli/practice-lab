class CreateDialogueTurns < ActiveRecord::Migration[8.1]
  def change
    create_table :dialogue_turns do |t|
      t.references :dialogue, null: false, foreign_key: true
      t.integer :position, null: false
      t.string :text, null: false

      t.timestamps
    end
    add_index :dialogue_turns, [ :dialogue_id, :position ], unique: true
  end
end
