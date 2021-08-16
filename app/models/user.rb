class User < ApplicationRecord
  has_many :phrases
  belongs_to :lesson, optional: true

  validates :telegram_id, presence: true, uniqueness: true

  def phrases_count
    phrases.where(created_at: Date.today.all_day).where.not(en_input: nil).count
  end
end
