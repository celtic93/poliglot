class WordPhrase < ApplicationRecord
  belongs_to :word
  belongs_to :phrase
end
