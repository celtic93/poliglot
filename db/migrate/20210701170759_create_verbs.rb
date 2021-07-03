class CreateVerbs < ActiveRecord::Migration[6.1]
  def change
    create_table :verbs do |t|
      t.string :en
      t.string :en_with_s
      t.string :en_form_2
      t.string :ru
      t.string :ru_present_i
      t.string :ru_present_you
      t.string :ru_present_he
      t.string :ru_present_she
      t.string :ru_present_we
      t.string :ru_present_they
      t.string :ru_past_i
      t.string :ru_past_you
      t.string :ru_past_he
      t.string :ru_past_she
      t.string :ru_past_we
      t.string :ru_past_they
      t.string :ru_future_i
      t.string :ru_future_you
      t.string :ru_future_he
      t.string :ru_future_she
      t.string :ru_future_we
      t.string :ru_future_they

      t.timestamps
    end
  end
end
