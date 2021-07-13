class PronounForm < ApplicationRecord
  belongs_to :pronoun
  
  validates :en, :ru, presence: true
end
