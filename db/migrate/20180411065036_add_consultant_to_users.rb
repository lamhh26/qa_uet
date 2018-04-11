class AddConsultantToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :consultant, :boolean, default: false
  end
end
