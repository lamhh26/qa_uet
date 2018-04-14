class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.string :name
      t.string :code
      t.references :course_category

      t.timestamps
    end
  end
end
