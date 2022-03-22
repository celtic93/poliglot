class Word < ApplicationRecord
  validates :en, uniqueness: { scope: :ru }

  default_scope { order(:position) }
end
