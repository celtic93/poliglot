class Pronoun < ApplicationRecord
  validates :en, :ru, presence: true
  validates :en, uniqueness: true
end
