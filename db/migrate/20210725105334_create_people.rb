class CreatePeople < ActiveRecord::Migration[6.1]
  def change
    create_table :people do |t|
      t.string :en
      t.string :ru
      t.string :ru_2
      t.string :en_plural
      t.string :ru_plural
      t.string :ru_plural_2

      t.timestamps
    end
  end
end
