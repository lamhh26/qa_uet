class CreateCourseCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :course_categories do |t|
      t.string :name
      t.datetime :date_from
      t.datetime :date_to

      t.timestamps
    end
  end
end
