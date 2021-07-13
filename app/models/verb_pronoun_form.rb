class VerbPronounForm < ApplicationRecord
  belongs_to :pronoun
  belongs_to :pronoun_form
  belongs_to :verb

  validates :pronoun_id, uniqueness: { scope: [:pronoun_form_id, :verb_id] } 
  validate :pronoun_form_belongs_to_pronoun, on: :create

  private

  def pronoun_form_belongs_to_pronoun
    unless pronoun_id == pronoun_form.pronoun_id
      errors.add(:pronoun_form, "wrong pronoun") 
    end 
  end
end
