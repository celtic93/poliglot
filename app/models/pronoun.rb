class Pronoun < ApplicationRecord
  has_many :pronoun_forms
  has_many :verb_pronoun_forms, dependent: :destroy
  
  validates :en, :ru, presence: true
  validates :en, uniqueness: true

  enum kind: { subject: 0,
               object: 1,
               question_word: 2 }
end
