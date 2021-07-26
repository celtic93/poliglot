class Phrase < ApplicationRecord
  belongs_to :lesson
  
  validates :en, :ru, presence: true
  validates :en_input, inclusion: { in: ->(phrase) { [phrase.en.downcase, phrase.en.capitalize, phrase.en] },
                                    message: 'You can do better!' },
                       allow_nil: true
end
