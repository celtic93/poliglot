class Pronoun < ApplicationRecord
  has_many :pronoun_forms, dependent: :destroy
  has_many :verb_pronoun_forms, dependent: :destroy

  validates :en, :ru, presence: true

  enum kind: { subject: 0,
               object: 1,
               possessive_determiner: 2 }
end
