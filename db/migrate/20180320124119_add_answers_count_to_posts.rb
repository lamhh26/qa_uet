class AddAnswersCountToPosts < ActiveRecord::Migration[5.1]
  def self.up
    add_column :posts, :answers_count, :integer, null: false, default: 0
  end

  def self.down
    remove_column :posts, :answers_count
  end
end
