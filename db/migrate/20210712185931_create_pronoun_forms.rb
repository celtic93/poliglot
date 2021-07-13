class CreatePronounForms < ActiveRecord::Migration[6.1]
  def change
    create_table :pronoun_forms do |t|
      t.string :en
      t.string :ru
      t.references :pronoun

      t.timestamps
    end
  end
end
