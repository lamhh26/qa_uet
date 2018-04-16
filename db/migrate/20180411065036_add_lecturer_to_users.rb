class AddLecturerToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :lecturer, :boolean, default: false
  end
end
