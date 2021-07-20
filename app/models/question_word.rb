class QuestionWord < ApplicationRecord
  has_and_belongs_to_many :verbs

  validates :en, :ru, presence: true
  validates :en, uniqueness: true
end
