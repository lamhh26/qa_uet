class AddLocationAndBirthdayToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :location, :string
    add_column :users, :birth_day, :date
  end
end
