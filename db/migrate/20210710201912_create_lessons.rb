class CreateLessons < ActiveRecord::Migration[6.1]
  def change
    create_table :lessons do |t|
      t.integer :position

      t.timestamps
    end
  end
end
