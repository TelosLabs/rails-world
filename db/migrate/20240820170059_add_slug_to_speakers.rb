class AddSlugToSpeakers < ActiveRecord::Migration[7.1]
  def change
    add_column :speakers, :slug, :string
    add_index :speakers, :slug, unique: true
  end
end
