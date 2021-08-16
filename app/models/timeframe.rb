class Timeframe < ApplicationRecord
  validates :en, :ru, presence: true

  enum kind: { past: 0,
               present: 1,
               future: 2,
               always: 3 }
end
