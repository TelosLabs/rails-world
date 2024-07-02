class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.references :location, null: false, foreign_key: true
      t.references :conference, null: false, foreign_key: true
      t.string :title
      t.string :description
      t.datetime :start_datetime
      t.datetime :end_datetime

      t.timestamps
    end
  end
end
