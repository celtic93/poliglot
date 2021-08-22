class CreateNouns < ActiveRecord::Migration[6.1]
  def change
    create_table :nouns do |t|
      t.string :en
      t.string :ru
      t.integer :kind

      t.timestamps
    end
  end
end
