class RemoveDescriptionFromSessions < ActiveRecord::Migration[7.2]
  def change
    remove_column :sessions, :description, :string
  end
end
