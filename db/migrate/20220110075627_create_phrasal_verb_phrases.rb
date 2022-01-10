class CreatePhrasalVerbPhrases < ActiveRecord::Migration[6.1]
  def change
    create_table :phrasal_verb_phrases do |t|
      t.references :phrasal_verb
      t.references :phrase

      t.timestamps
    end
  end
end
