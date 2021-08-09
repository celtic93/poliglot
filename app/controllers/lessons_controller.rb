class LessonsController < ApplicationController
  def show
    @lesson = Lesson.find(params[:id])
    @phrase = create_phrase
    @count = Phrase.where(created_at: Time.current.all_day, lesson_id: @lesson.id)
                   .where.not(en_input: nil).count
  end

  private

  def create_phrase
    if @lesson.position == 1
      pronoun = Pronoun.where(kind: 'subject').sample
      verb = Verb.where.not(en: 'be').sample
      time = [:present, :past, :future].sample
      type = [:question, :statement, :negation].sample
      verb_form = "ru_#{time}_#{pronoun.en.downcase}"

      case type
      when :question
        case time
        when :present
          auxiliary_word = ['he', 'she'].include?(pronoun.en) ? 'Does' : 'Do'
          en = "#{auxiliary_word} #{pronoun.en} #{verb.en}?"
          ru = "#{pronoun.ru.capitalize} #{verb[verb_form]}?"
        when :past
          en = "Did #{pronoun.en} #{verb.en}?"
          ru = "#{pronoun.ru.capitalize} #{verb[verb_form]}?"
        when :future
          en = "Will #{pronoun.en} #{verb.en}?"
          ru = "#{pronoun.ru.capitalize} #{verb[verb_form]}?"
        end
      when :statement
        case time
        when :present
          verb_en = ['he', 'she'].include?(pronoun.en) ? verb.en_with_s : verb.en
          en = "#{pronoun.en} #{verb_en}"
          ru = "#{pronoun.ru.capitalize} #{verb[verb_form]}"
        when :past
          en = "#{pronoun.en} #{verb.en_form_2}"
          ru = "#{pronoun.ru.capitalize} #{verb[verb_form]}"
        when :future
          en = "#{pronoun.en} will #{verb.en}"
          ru = "#{pronoun.ru.capitalize} #{verb[verb_form]}"
        end
      when :negation
        case time
        when :present
          negation_word = ['he', 'she'].include?(pronoun.en) ? "does not" : "do not"
          en = "#{pronoun.en} #{negation_word} #{verb.en}"
          ru = "#{pronoun.ru.capitalize} не #{verb[verb_form]}"
        when :past
          en = "#{pronoun.en} did not #{verb.en}"
          ru = "#{pronoun.ru.capitalize} не #{verb[verb_form]}"
        when :future
          en = "#{pronoun.en} will not #{verb.en}"
          ru = "#{pronoun.ru.capitalize} не #{verb[verb_form]}"
        end
      end

      Phrase.create(en: en, ru: ru, lesson_id: @lesson.id)
    elsif @lesson.position == 2
      verb_pronoun_form = VerbPronounForm.all.sample
      subject_pronoun_ids = [3, 5].include?(verb_pronoun_form.pronoun_id) ? [3, 5] : verb_pronoun_form.pronoun_id
      subject_pronoun = Pronoun.where.not(id: subject_pronoun_ids)
                               .where(kind: 'subject').sample
      object_pronoun = verb_pronoun_form.pronoun_form
      verb = verb_pronoun_form.verb
      type = [:question, :statement, :negation].sample
      time = [:present, :past, :future].sample
      verb_form = "ru_#{time}_#{subject_pronoun.en.downcase}"

      case type
      when :question
        question_word = verb.question_words.sample
        case time
        when :present
          auxiliary_word = ['he', 'she'].include?(subject_pronoun.en) ? 'does' : 'do'
          en = "#{question_word.en} #{auxiliary_word} #{subject_pronoun.en} #{verb.en} #{object_pronoun.en}?"
          ru = "#{question_word.ru.capitalize} #{subject_pronoun.ru} #{verb[verb_form]} #{object_pronoun.ru}?"
        when :past
          en = "#{question_word.en} did #{subject_pronoun.en} #{verb.en} #{object_pronoun.en}?"
          ru = "#{question_word.ru.capitalize} #{subject_pronoun.ru} #{verb[verb_form]} #{object_pronoun.ru}?"
        when :future
          en = "#{question_word.en} will #{subject_pronoun.en} #{verb.en} #{object_pronoun.en}?"
          ru = "#{question_word.ru.capitalize} #{subject_pronoun.ru} #{verb[verb_form]} #{object_pronoun.ru}?"
        end
      when :statement
        case time
        when :present
          verb_en = ['he', 'she'].include?(subject_pronoun.en) ? verb.en_with_s : verb.en
          en = "#{subject_pronoun.en} #{verb_en} #{object_pronoun.en}"
          ru = "#{subject_pronoun.ru.capitalize} #{verb[verb_form]} #{object_pronoun.ru}"
        when :past
          en = "#{subject_pronoun.en} #{verb.en_form_2} #{object_pronoun.en}"
          ru = "#{subject_pronoun.ru.capitalize} #{verb[verb_form]} #{object_pronoun.ru}"
        when :future
          en = "#{subject_pronoun.en} will #{verb.en} #{object_pronoun.en}"
          ru = "#{subject_pronoun.ru.capitalize} #{verb[verb_form]} #{object_pronoun.ru}"
        end
      when :negation
        case time
        when :present
          negation_word = ['he', 'she'].include?(subject_pronoun.en) ? "does not" : "do not"
          en = "#{subject_pronoun.en} #{negation_word} #{verb.en} #{object_pronoun.en}"
          ru = "#{subject_pronoun.ru.capitalize} не #{verb[verb_form]} #{object_pronoun.ru}"
        when :past
          en = "#{subject_pronoun.en} did not #{verb.en} #{object_pronoun.en}"
          ru = "#{subject_pronoun.ru.capitalize} не #{verb[verb_form]} #{object_pronoun.ru}"
        when :future
          en = "#{subject_pronoun.en} will not #{verb.en} #{object_pronoun.en}"
          ru = "#{subject_pronoun.ru.capitalize} не #{verb[verb_form]} #{object_pronoun.ru}"
        end
      end

      Phrase.create(en: en, ru: ru, lesson_id: @lesson.id)
    elsif @lesson.position == 3
      verb = Verb.find_by(en: 'be')
      subject_pronoun = Pronoun.where(kind: 'subject').sample
      type = [:question, :statement, :negation].sample
      time = [:present, :past, :future].sample
      end_word = [Person, Place].sample.all.sample
      verb_form = "ru_#{time}_#{subject_pronoun.en.downcase}"

      if end_word.is_a?(Person)
        possessive_determiner_ids = [3, 4, 5].include?(subject_pronoun.id) ? [27, 28, 30] : []
        possessive_determiner = Pronoun.where.not(id: possessive_determiner_ids)
                                       .where(kind: 'possessive_determiner').sample
        is_plural = ['we', 'you', 'they'].include?(subject_pronoun.en)
        possessive_determiner = if time == :present
                                  is_plural ? possessive_determiner.pronoun_forms[1] : possessive_determiner.pronoun_forms[0]
                                else
                                  is_plural ? possessive_determiner.pronoun_forms[3] : possessive_determiner.pronoun_forms[2]
                                end
        word_ru_form = is_plural ? 'ru_plural' : 'ru'
        word_en_form = is_plural ? 'en_plural' : 'en'
        word_ru_form += '_2' unless time == :present
        en_end_of_sentance = "#{possessive_determiner.en} #{end_word[word_en_form]}"
        ru_end_of_sentance = "#{possessive_determiner.ru} #{end_word[word_ru_form]}"
      elsif end_word.is_a?(Place)
        en_end_of_sentance = end_word.en
        ru_end_of_sentance = end_word.ru
      end

      case type
      when :question
        case time
        when :present
          auxiliary_word = ['he', 'she'].include?(subject_pronoun.en) ? 'is' : 'I' == subject_pronoun.en ? 'am' : 'are'
          en = "#{auxiliary_word} #{subject_pronoun.en} #{en_end_of_sentance}?"
          ru = "#{subject_pronoun.ru.capitalize} #{ru_end_of_sentance}?"
        when :past
          auxiliary_word = ['I', 'he', 'she'].include?(subject_pronoun.en) ? 'was' : 'were'
          en = "#{auxiliary_word} #{subject_pronoun.en} #{en_end_of_sentance}?"
          ru = "#{subject_pronoun.ru.capitalize} #{verb[verb_form]} #{ru_end_of_sentance}?"
        when :future
          en = "will #{subject_pronoun.en} #{verb.en} #{en_end_of_sentance}?"
          ru = "#{subject_pronoun.ru.capitalize} #{verb[verb_form]} #{ru_end_of_sentance}?"
        end
      when :statement
        case time
        when :present
          auxiliary_word = ['he', 'she'].include?(subject_pronoun.en) ? 'is' : 'I' == subject_pronoun.en ? 'am' : 'are'
          en = "#{subject_pronoun.en} #{auxiliary_word} #{en_end_of_sentance}"
          ru = "#{subject_pronoun.ru.capitalize} #{ru_end_of_sentance}"
        when :past
          auxiliary_word = ['I', 'he', 'she'].include?(subject_pronoun.en) ? 'was' : 'were'
          en = "#{subject_pronoun.en} #{auxiliary_word} #{en_end_of_sentance}"
          ru = "#{subject_pronoun.ru.capitalize} #{verb[verb_form]} #{ru_end_of_sentance}"
        when :future
          en = "#{subject_pronoun.en} will #{verb.en} #{en_end_of_sentance}"
          ru = "#{subject_pronoun.ru.capitalize} #{verb[verb_form]} #{ru_end_of_sentance}"
        end
      when :negation
        case time
        when :present
          auxiliary_word = ['he', 'she'].include?(subject_pronoun.en) ? 'is' : 'I' == subject_pronoun.en ? 'am' : 'are'
          en = "#{subject_pronoun.en} #{auxiliary_word} not #{en_end_of_sentance}"
          ru = "#{subject_pronoun.ru.capitalize} не #{ru_end_of_sentance}"
        when :past
          auxiliary_word = ['I', 'he', 'she'].include?(subject_pronoun.en) ? 'was' : 'were'
          en = "#{subject_pronoun.en} #{auxiliary_word} not #{en_end_of_sentance}"
          ru = "#{subject_pronoun.ru.capitalize} не #{verb[verb_form]} #{ru_end_of_sentance}"
        when :future
          en = "#{subject_pronoun.en} will not #{verb.en} #{en_end_of_sentance}"
          ru = "#{subject_pronoun.ru.capitalize} не #{verb[verb_form]} #{ru_end_of_sentance}"
        end
      end

      Phrase.create(en: en, ru: ru, lesson_id: @lesson.id)
    elsif @lesson.position == 4
      verb = Verb.find_by(en: 'work')
      subject_pronoun = Pronoun.where(en: ['I', 'he', 'she'], kind: 'subject').sample
      type = [:question, :statement, :negation].sample
      time = [:present, :past, :future].sample
      verb_form = "ru_#{time}_#{subject_pronoun.en.downcase}"
      profession = Person.where(profession: true).sample
      article = profession.en.start_with?('a', 'e', 'i', 'o', 'u') ? 'an' : 'a'

      case type
      when :question
        case time
        when :present
          auxiliary_word = ['he', 'she'].include?(subject_pronoun.en) ? 'Does' : 'Do'
          en = "#{auxiliary_word} #{subject_pronoun.en} #{verb.en} as #{article} #{profession.en}?"
          ru = "#{subject_pronoun.ru.capitalize} #{verb[verb_form]} #{profession.ru_2}?"
        when :past
          en = "Did #{subject_pronoun.en} #{verb.en} as #{article} #{profession.en}?"
          ru = "#{subject_pronoun.ru.capitalize} #{verb[verb_form]} #{profession.ru_2}?"
        when :future
          en = "will #{subject_pronoun.en} #{verb.en} as #{article} #{profession.en}?"
          ru = "#{subject_pronoun.ru.capitalize} #{verb[verb_form]} #{profession.ru_2}?"
        end
      when :statement
        case time
        when :present
          verb_en = ['he', 'she'].include?(subject_pronoun.en) ? verb.en_with_s : verb.en 
          en = "#{subject_pronoun.en} #{verb_en} as #{article} #{profession.en}"
          ru = "#{subject_pronoun.ru.capitalize} #{verb[verb_form]} #{profession.ru_2}"
        when :past
          en = "#{subject_pronoun.en} #{verb.en_form_2} as #{article} #{profession.en}"
          ru = "#{subject_pronoun.ru.capitalize} #{verb[verb_form]} #{profession.ru_2}"
        when :future
          en = "#{subject_pronoun.en} will #{verb.en} as #{article} #{profession.en}"
          ru = "#{subject_pronoun.ru.capitalize} #{verb[verb_form]} #{profession.ru_2}"
        end
      when :negation
        case time
        when :present
          negation_word = ['he', 'she'].include?(subject_pronoun.en) ? "does not" : "do not"
          en = "#{subject_pronoun.en} #{negation_word} #{verb.en} as #{article} #{profession.en}"
          ru = "#{subject_pronoun.ru.capitalize} не #{verb[verb_form]} #{profession.ru_2}"
        when :past
          en = "#{subject_pronoun.en} did not #{verb.en} as #{article} #{profession.en}"
          ru = "#{subject_pronoun.ru.capitalize} не #{verb[verb_form]} #{profession.ru_2}"
        when :future
          en = "#{subject_pronoun.en} will not #{verb.en} as #{article} #{profession.en}"
          ru = "#{subject_pronoun.ru.capitalize} не #{verb[verb_form]} #{profession.ru_2}"
        end
      end

      Phrase.create(en: en, ru: ru, lesson_id: @lesson.id)
    elsif @lesson.position == 5
      verb = Verb.find_by(en: 'be')
      subject_pronoun = Pronoun.where(kind: 'subject').sample
      type = [:question, :statement, :negation].sample
      time = [:present, :past, :future].sample
      adjective = AdjectiveForm.all.sample
      verb_form = "ru_#{time}_#{subject_pronoun.en.downcase}"

      if adjective.en.start_with?('the ')
        person = Person.where(profession: true).all.sample
        is_plural = ['we', 'you', 'they'].include?(subject_pronoun.en)
        ru_form = is_plural ? 'ru_plural' : 'ru'
        en_form = is_plural ? 'en_plural' : 'en'
        ru_form += '_2' unless time == :present
        en_end_of_sentance = "#{adjective.en} #{person[en_form]}"
        ru_end_of_sentance = "#{adjective[ru_form]} #{person[ru_form]}"
      else
        ru_form = is_plural ? 'ru_plural' : 'ru'
        en_form = is_plural ? 'en_plural' : 'en'
        ru_form += '_2' unless time == :present
        object_pronoun = Pronoun.where.not(id: subject_pronoun_ids)
                               .where(kind: 'object').sample
        en_end_of_sentance = "#{adjective.en} than #{object_pronoun.en}"
        ru_end_of_sentance = "#{adjective[ru_form]} #{object_pronoun.ru}"
      end

      case type
      when :question
        case time
        when :present
          auxiliary_word = ['he', 'she'].include?(subject_pronoun.en) ? 'is' : 'I' == subject_pronoun.en ? 'am' : 'are'
          en = "#{auxiliary_word} #{subject_pronoun.en} #{en_end_of_sentance}?"
          ru = "#{subject_pronoun.ru.capitalize} #{ru_end_of_sentance}?"
        when :past
          auxiliary_word = ['I', 'he', 'she'].include?(subject_pronoun.en) ? 'was' : 'were'
          en = "#{auxiliary_word} #{subject_pronoun.en} #{en_end_of_sentance}?"
          ru = "#{subject_pronoun.ru.capitalize} #{verb[verb_form]} #{ru_end_of_sentance}?"
        when :future
          en = "will #{subject_pronoun.en} #{verb.en} #{en_end_of_sentance}?"
          ru = "#{subject_pronoun.ru.capitalize} #{verb[verb_form]} #{ru_end_of_sentance}?"
        end
      when :statement
        case time
        when :present
          auxiliary_word = ['he', 'she'].include?(subject_pronoun.en) ? 'is' : 'I' == subject_pronoun.en ? 'am' : 'are'
          en = "#{subject_pronoun.en} #{auxiliary_word} #{en_end_of_sentance}"
          ru = "#{subject_pronoun.ru.capitalize} #{ru_end_of_sentance}"
        when :past
          auxiliary_word = ['I', 'he', 'she'].include?(subject_pronoun.en) ? 'was' : 'were'
          en = "#{subject_pronoun.en} #{auxiliary_word} #{en_end_of_sentance}"
          ru = "#{subject_pronoun.ru.capitalize} #{verb[verb_form]} #{ru_end_of_sentance}"
        when :future
          en = "#{subject_pronoun.en} will #{verb.en} #{en_end_of_sentance}"
          ru = "#{subject_pronoun.ru.capitalize} #{verb[verb_form]} #{ru_end_of_sentance}"
        end
      when :negation
        case time
        when :present
          auxiliary_word = ['he', 'she'].include?(subject_pronoun.en) ? 'is' : 'I' == subject_pronoun.en ? 'am' : 'are'
          en = "#{subject_pronoun.en} #{auxiliary_word} not #{en_end_of_sentance}"
          ru = "#{subject_pronoun.ru.capitalize} не #{ru_end_of_sentance}"
        when :past
          auxiliary_word = ['I', 'he', 'she'].include?(subject_pronoun.en) ? 'was' : 'were'
          en = "#{subject_pronoun.en} #{auxiliary_word} not #{en_end_of_sentance}"
          ru = "#{subject_pronoun.ru.capitalize} не #{verb[verb_form]} #{ru_end_of_sentance}"
        when :future
          en = "#{subject_pronoun.en} will not #{verb.en} #{en_end_of_sentance}"
          ru = "#{subject_pronoun.ru.capitalize} не #{verb[verb_form]} #{ru_end_of_sentance}"
        end
      end

      Phrase.create(en: en, ru: ru, lesson_id: @lesson.id)
    end
  end
end
