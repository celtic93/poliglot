class LessonsController < ApplicationController
  def show
    @lesson = Lesson.find(params[:id])
    @phrase = create_phrase
    @count = Phrase.where(created_at: Time.current.all_day, lesson_id: @lesson.id)
                   .where.not(en_input: nil).count

    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def create_phrase
    if @lesson.position == 1
      pronoun = Pronoun.where(kind: 'subject').sample
      verb = Verb.all.sample
      time = [:present, :past, :future].sample
      type = [:question, :statement, :negation].sample

      case type
      when :question
        case time
        when :present
          auxiliary_word = ['he', 'she'].include?(pronoun.en) ? 'Does' : 'Do'
          verb_form = "ru_#{time}_#{pronoun.en.downcase}"
          en = "#{auxiliary_word} #{pronoun.en} #{verb.en}?"
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

      Phrase.create(en: en, ru: ru, lesson_id: @lesson.id)
    elsif @lesson.position == 2
      verb_pronoun_form = VerbPronounForm.all.sample
      subject_pronoun = Pronoun.where.not(id: verb_pronoun_form.pronoun_id)
                               .where(kind: 'subject').sample
      object_pronoun = verb_pronoun_form.pronoun_form
      question_word = Pronoun.where(kind: 'question_word').sample
      verb = verb_pronoun_form.verb
      time = [:present, :past, :future].sample

      case time
      when :present
        auxiliary_word = ['he', 'she'].include?(subject_pronoun.en) ? 'does' : 'do'
        verb_form = "ru_#{time}_#{subject_pronoun.en.downcase}"
        en = "#{question_word.en} #{auxiliary_word} #{subject_pronoun.en} #{verb.en} #{object_pronoun.en}?"
        ru = "#{question_word.ru} #{subject_pronoun.ru} #{verb[verb_form]} #{object_pronoun.ru}?"
      when :past
        verb_form = "ru_#{time}_#{subject_pronoun.en.downcase}"
        en = "#{question_word.en} did #{subject_pronoun.en} #{verb.en} #{object_pronoun.en}?"
        ru = "#{question_word.ru} #{subject_pronoun.ru} #{verb[verb_form]} #{object_pronoun.ru}?"
      when :future
        verb_form = "ru_#{time}_#{subject_pronoun.en.downcase}"
        en = "#{question_word.en} will #{subject_pronoun.en} #{verb.en} #{object_pronoun.en}?"
        ru = "#{question_word.ru} #{subject_pronoun.ru} #{verb[verb_form]} #{object_pronoun.ru}?"
      end

      Phrase.create(en: en, ru: ru, lesson_id: @lesson.id)
    end
  end
end
