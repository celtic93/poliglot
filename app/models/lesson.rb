class Lesson < ApplicationRecord
  has_many :phrases
  has_many :users

  default_scope { order(:position) }
end
