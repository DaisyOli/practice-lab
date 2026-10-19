class CreateExperiments < ActiveRecord::Migration[8.1]
  def change
    create_table :experiments do |t|
      t.string :title, null: false
      t.string :slug, null: false
      t.text :purpose, null: false
      t.string :status, null: false, default: "idea"

      t.timestamps
    end
    add_index :experiments, :slug, unique: true
  end
end
