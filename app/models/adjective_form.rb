class AdjectiveForm < ApplicationRecord
  belongs_to :adjective
  
  validates :en, :ru, :ru_2, :ru_plural, :ru_plural_2, presence: true

  enum kind: { comparative: 0,
               superlative: 1 }
end
