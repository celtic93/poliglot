class Verb < ApplicationRecord
  has_many :verb_pronoun_forms, dependent: :destroy
  has_and_belongs_to_many :question_words
  before_destroy do
    question_words.each { |question_word| question_word.destroy }
  end
  
  validates :en, :en_with_s, :en_form_2, :ru, :ru_present_i, :ru_present_you, :ru_present_he,
            :ru_present_she, :ru_present_we, :ru_present_they, :ru_past_i, :ru_past_you,
            :ru_past_he, :ru_past_she, :ru_past_we, :ru_past_they, :ru_future_i, :ru_future_you,
            :ru_future_he, :ru_future_she, :ru_future_we, :ru_future_they, presence: true
  validates :en, uniqueness: true
end
