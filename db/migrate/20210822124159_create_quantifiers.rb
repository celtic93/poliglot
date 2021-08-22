class CreateQuantifiers < ActiveRecord::Migration[6.1]
  def change
    create_table :quantifiers do |t|
      t.string :en
      t.string :ru
      t.integer :kind

      t.timestamps
    end
  end
end
