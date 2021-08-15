class Lesson < ApplicationRecord
  has_many :phrases
  has_many :users
end
