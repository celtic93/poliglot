class Adjective < ApplicationRecord
  has_many :adjective_forms, dependent: :destroy
  
  validates :en, :ru, presence: true
end
