class Phrase < ApplicationRecord
  belongs_to :lesson
  belongs_to :user
  
  validates :en, :ru, presence: true
  validate :case_insensitive_eql

  private

  def case_insensitive_eql
    if en_input.present?
      errors.add(:en_input, 'You can do better!') unless en_input.downcase == en.downcase
    end
  end
end
