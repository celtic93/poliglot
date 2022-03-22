class CreateWords < ActiveRecord::Migration[6.1]
  def change
    create_table :words do |t|
      t.string :en
      t.string :ru
      t.integer :position
      t.integer :level

      t.timestamps
    end
  end
end
