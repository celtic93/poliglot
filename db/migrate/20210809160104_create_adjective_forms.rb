class CreateAdjectiveForms < ActiveRecord::Migration[6.1]
  def change
    create_table :adjective_forms do |t|
      t.string :en
      t.string :ru
      t.string :ru_2
      t.string :ru_plural
      t.string :ru_plural_2
      t.integer :kind
      t.references :adjective

      t.timestamps
    end
  end
end
