class CreateVerbPronounForms < ActiveRecord::Migration[6.1]
  def change
    create_table :verb_pronoun_forms do |t|
      t.references :verb
      t.references :pronoun
      t.references :pronoun_form

      t.timestamps
    end
  end
end
