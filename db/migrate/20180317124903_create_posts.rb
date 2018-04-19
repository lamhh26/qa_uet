class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.integer :post_type, default: 0
      t.string :title
      t.text :body
      t.boolean :closed, default: false
      t.boolean :best_answer, default: false
      t.datetime :mark_best_answer_at
      t.references :parent
      t.references :owner_user, references: :users, foreign_key: {to_table: :users}
      t.references :marker, references: :users, foreign_key: {to_table: :users}

      t.timestamps
    end
  end
end
