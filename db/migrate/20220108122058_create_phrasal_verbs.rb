class CreatePhrasalVerbs < ActiveRecord::Migration[6.1]
  def change
    create_table :phrasal_verbs do |t|
      t.string :en
      t.string :ru

      t.timestamps
    end
  end
end
