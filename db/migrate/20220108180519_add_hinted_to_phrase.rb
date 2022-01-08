class AddHintedToPhrase < ActiveRecord::Migration[6.1]
  def change
    add_column :phrases, :hinted, :boolean, default: false
  end
end
