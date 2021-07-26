class CreatePlaces < ActiveRecord::Migration[6.1]
  def change
    create_table :places do |t|
      t.string :en
      t.string :ru

      t.timestamps
    end
  end
end
