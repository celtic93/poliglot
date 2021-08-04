class AddProfessionToPerson < ActiveRecord::Migration[6.1]
  def change
    add_column :people, :profession, :boolean, default: false
  end
end
