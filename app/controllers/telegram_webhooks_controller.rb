class TelegramWebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext

  before_action :delete_message, except: %w[practice! hint! message action_missing]
  before_action :current_tg_user

  def start!(*)
    respond_with :message, text: 'Чтобы начать, введите команду /choose и выберите урок'
  end

  def choose!(*)
    respond_with :message, text: 'Выберите урок', reply_markup: {
      inline_keyboard: lessons_keyboard
    }
  end

  def lesson!(*)
    lesson_text
  end

  def practice!(*)
    new_practice
  end

  def hint!(*)
    current_tg_user.phrases.last.update(hinted: true)
    respond_with :message, text: current_tg_user.phrases.last.en
  end

  def count!(*)
    respond_with :message, text: current_tg_user.phrases_count
  end

  def stat!(*)
    message = if current_tg_user.lesson.position == 8
                PhrasalVerb.where.not(id: PhrasalVerbPhrase.joins(:phrase)
                                                           .where(phrase: { hinted: false,
                                                                            user_id: current_tg_user.id })
                                                           .where.not(phrase: { en_input: nil })
                                                           .pluck(:phrasal_verb_id)).count
              elsif current_tg_user.lesson.position == 100
                Word.where.not(id: WordPhrase.joins(:phrase)
                                             .where(phrase: { hinted: false, user_id: current_tg_user.id })
                                             .where.not(phrase: { en_input: nil })
                                             .pluck(:word_id))
                    .where(level: current_tg_user.word_level).count
              else
                'не знаю'
              end

    respond_with :message, text: message
  end

  def callback_query(data)
    callback = data.split(' ')
    if callback[0] == 'chosed_lesson'
      lesson = Lesson.find_by(position: callback[1])
      lesson.users.push(current_tg_user)
      answer_callback_query "Выбран урок #{lesson.position}", show_alert: true
      lesson_text(lesson)
    elsif callback[0] == 'show_lessons'
      respond_with :message, text: 'Выберите урок', reply_markup: {
        inline_keyboard: lessons_keyboard
      }
    end
  end

  def message(message)
    @phrase = current_tg_user.phrases.last

    if @phrase&.update(en_input: message['text'])
      respond_with :message, text: 'ПРАВИЛЬНО'
      new_practice
    elsif current_tg_user.lesson.position.in?([8, 100])
      # Lesson 8 is lesson with Prasal Verbs
      # Lesson 100 is lesson with 10000 Words
      phrasal_verb_check(message)
    else
      respond_with :message, text: 'Ты можешь лучше'
      respond_with :message, text: @phrase.ru
    end
  end

  def action_missing(_action, *_args)
    respond_with :message, text: 'Неизвестная команда' if action_type == :command
  end

  private

  def lessons_keyboard
    keyboard = []

    Lesson.all.each_slice(4) do |lessons|
      keyboard << lessons.map { |lesson| {text: lesson.position, 
                                          callback_data: "chosed_lesson #{lesson.position}"} }
    end

    keyboard
  end

  def lesson_text
    respond_with :message, text: "Выбран урок #{current_tg_user.lesson.position}\n"\
                                 "/practice - Практическое занятие\n"\
                                 '/choose - Поменять в урок'
  end

  def delete_message
    bot.request(:deleteMessage, chat_id: payload_params['chat']['id'],
                                message_id: payload_params['message_id'])
  end

  def current_tg_user
    @current_tg_user ||= User.find_or_create_by(telegram_id: payload_params['chat']['id'])
  end

  def payload_params
    payload['message'] || payload
  end

  def new_practice
    phrase = if current_tg_user.lesson.position == 100
               CreateWordPhraseService.call(current_tg_user, current_tg_user.lesson)
             else
               CreatePhraseService.call(current_tg_user, current_tg_user.lesson)
             end
    respond_with :message, text: phrase.ru
  end

  def phrasal_verb_check(message)
    klass = current_tg_user.lesson.position == 8 ? PhrasalVerb : Word
    input = message['text'].downcase
    input_traslations = klass.where(en: input).pluck(:ru)
    possible_answers = klass.where(ru: @phrase.ru).pluck(:en)

    if input.in?(possible_answers)
      respond_with :message, text: 'ПРАВИЛЬНО, но нужен другой вариант'
      respond_with :message, text: @phrase.ru
      return
    end

    response_text = if input_traslations.any?
                      input_traslations.map
                                       .with_index { |tr, i| "#{i + 1}. #{tr.capitalize}" }
                                       .join("\n")
                    else
                      'Переводов не найдено'
                    end
    respond_with :message, text: response_text
    respond_with :message, text: @phrase.en
    new_practice
  end
end
