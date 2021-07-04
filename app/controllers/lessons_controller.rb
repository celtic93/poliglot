class LessonsController < ApplicationController
  def lesson1
    @phrase = create_phrase1
    @count = Phrase.where(created_at: Time.current.all_day).where.not(en_input: nil).count

    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def create_phrase1
    pronoun = Pronoun.find(Pronoun.pluck(:id).sample)
    verb = Verb.find(Verb.pluck(:id).sample)
    time = [:present, :past, :future].sample
    type = [:question, :statement, :negation].sample

    case type
    when :question
      case time
      when :present
        question_word = ['he', 'she'].include?(pronoun.en) ? 'Does' : 'Do'
        verb_form = "ru_#{time}_#{pronoun.en.downcase}"
        en = "#{question_word} #{pronoun.en} #{verb.en}?"
        ru = "#{pronoun.ru} #{verb[verb_form]}?"
      when :past
        verb_form = "ru_#{time}_#{pronoun.en.downcase}"
        en = "Did #{pronoun.en} #{verb.en}?"
        ru = "#{pronoun.ru} #{verb[verb_form]}?"
      when :future
        verb_form = "ru_#{time}_#{pronoun.en.downcase}"
        en = "Will #{pronoun.en} #{verb.en}?"
        ru = "#{pronoun.ru} #{verb[verb_form]}?"
      end
    when :statement
      case time
      when :present
        verb_en = ['he', 'she'].include?(pronoun.en) ? verb.en_with_s : verb.en 
        verb_form = "ru_#{time}_#{pronoun.en.downcase}"
        en = "#{pronoun.en} #{verb_en}"
        ru = "#{pronoun.ru} #{verb[verb_form]}"
      when :past
        verb_form = "ru_#{time}_#{pronoun.en.downcase}"
        en = "#{pronoun.en} #{verb.en_form_2}"
        ru = "#{pronoun.ru} #{verb[verb_form]}"
      when :future
        verb_form = "ru_#{time}_#{pronoun.en.downcase}"
        en = "#{pronoun.en} will #{verb.en}"
        ru = "#{pronoun.ru} #{verb[verb_form]}"
      end
    when :negation
      case time
      when :present
        negation_word = ['he', 'she'].include?(pronoun.en) ? "doesn't" : "don't"
        verb_form = "ru_#{time}_#{pronoun.en.downcase}"
        en = "#{pronoun.en} #{negation_word} #{verb.en}"
        ru = "#{pronoun.ru} не #{verb[verb_form]}"
      when :past
        verb_form = "ru_#{time}_#{pronoun.en.downcase}"
        en = "#{pronoun.en} didn't #{verb.en}"
        ru = "#{pronoun.ru} не #{verb[verb_form]}"
      when :future
        verb_form = "ru_#{time}_#{pronoun.en.downcase}"
        en = "#{pronoun.en} won't #{verb.en}"
        ru = "#{pronoun.ru} не #{verb[verb_form]}"
      end
    end

    Phrase.create(en: en, ru: ru)
  end
end
