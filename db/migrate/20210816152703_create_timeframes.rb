class CreateTimeframes < ActiveRecord::Migration[6.1]
  def change
    create_table :timeframes do |t|
      t.string :en
      t.string :ru
      t.integer :kind

      t.timestamps
    end
  end
end
