class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :telegram_id
      t.references :lesson, optional: true

      t.timestamps
    end

    add_reference :phrases, :user, index: true
  end
end
