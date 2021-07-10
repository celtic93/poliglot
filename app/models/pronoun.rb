class Pronoun < ApplicationRecord
  validates :en, :ru, presence: true
  validates :en, uniqueness: true

  enum kind: { subject: 0,
               object: 1,
               question_word: 2 }
end
