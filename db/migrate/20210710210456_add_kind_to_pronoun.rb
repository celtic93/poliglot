class AddKindToPronoun < ActiveRecord::Migration[6.1]
  def change
    add_column :pronouns, :kind, :integer
  end
end
