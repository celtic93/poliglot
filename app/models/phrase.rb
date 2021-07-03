class Phrase < ApplicationRecord
  validates :en, :ru, presence: true
  validates :en_input, inclusion: { in: ->(phrase) { [phrase.en, phrase.en.downcase, phrase.en.capitalize] },
                                    message: 'You can do better!' },
                       allow_nil: true
end
