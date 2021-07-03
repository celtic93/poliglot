class CreatePhrases < ActiveRecord::Migration[6.1]
  def change
    create_table :phrases do |t|
      t.string :en
      t.string :ru
      t.string :en_input

      t.timestamps
    end
  end
end
