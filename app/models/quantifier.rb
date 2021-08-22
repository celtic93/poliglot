class Quantifier < ApplicationRecord
  validates :en, :ru, presence: true

  enum kind: { uncountable: 0,
               plural_countable: 1 }
end
