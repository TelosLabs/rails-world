class RenameEventToSession < ActiveRecord::Migration[7.1]
  def change
    rename_table :events, :sessions
  end
end
