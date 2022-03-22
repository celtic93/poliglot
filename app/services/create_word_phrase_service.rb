class CreateWordPhraseService
  def self.call(user, lesson)
    @user = user
    @lesson = lesson
    create_word_phrase
  end

  private

  def self.create_word_phrase
    used_word_ids = WordPhrase.joins(:phrase)
                              .where(phrase: { hinted: false, user_id: @user.id })
                              .where.not(phrase: { en_input: nil })
                              .pluck(:word_id)
    word = Word.where.not(id: used_word_ids)
               .where(level: @user.word_level)
               .sample

    unless word
      phrases_count = WordPhrase.joins(:phrase).where(phrase: { user_id: @user.id }).count
      words_count = Word.where(level: @user.word_level).where.not(ru: nil).count
      if phrases_count == words_count
        level = @user.word_level
        @user.update(word_level: (level+1))
      end

      WordPhrase.joins(:phrase).where(phrase: { user_id: @user.id }).destroy_all
      word = Word.where.not(id: used_word_ids, ru: nil)
                 .where(level: @user.word_level)
                 .sample
    end

    en = word.en
    ru = word.ru
    phrase = @user.phrases.create(en: en, ru: ru, lesson_id: @lesson.id)
    WordPhrase.create(phrase: phrase, word: word)
    return phrase
  end
end
