class CreateWordPhrases < ActiveRecord::Migration[6.1]
  def change
    create_table :word_phrases do |t|
      t.references :word
      t.references :phrase

      t.timestamps
    end

    add_column :users, :word_level, :integer, default: 1
  end
end
