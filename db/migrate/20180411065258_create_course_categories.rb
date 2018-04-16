class CreateCourseCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :course_categories do |t|
      t.string :name
      t.integer :year_from
      t.integer :year_to

      t.timestamps
    end
  end
end
