class Person < ApplicationRecord
  validates :en, :ru, :en_plural, :ru_plural, presence: true
  validates :en, uniqueness: true
end
