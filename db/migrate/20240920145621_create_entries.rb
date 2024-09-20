class CreateEntries < ActiveRecord::Migration[7.2]
  def change
    create_table :entries do |t|
      t.references :journal, null: false, foreign_key: true
      t.text :content
      t.string :mood
      t.date :date

      t.timestamps
    end
  end
end
