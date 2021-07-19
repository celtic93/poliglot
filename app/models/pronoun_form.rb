class PronounForm < ApplicationRecord
  has_many :verb_pronoun_forms, dependent: :destroy
  belongs_to :pronoun
  
  validates :en, :ru, presence: true
end
