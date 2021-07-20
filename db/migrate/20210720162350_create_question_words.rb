class CreateQuestionWords < ActiveRecord::Migration[6.1]
  def change
    create_table :question_words do |t|
      t.string :en
      t.string :ru

      t.timestamps
    end

    create_table :question_words_verbs, id: false do |t|
      t.bigint :question_word_id
      t.bigint :verb_id
    end
  end
end
