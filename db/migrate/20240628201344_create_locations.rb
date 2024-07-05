class CreateLocations < ActiveRecord::Migration[7.1]
  def change
    create_table :locations do |t|
      t.string :name, null: false
      t.references :conference, null: false, foreign_key: true

      t.timestamps

      t.index %i[name conference_id], unique: true
    end
  end
end
