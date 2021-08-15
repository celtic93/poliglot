class LessonsController < ApplicationController
  def show
    @lesson = Lesson.find(params[:id])
    @phrase = CreatePhraseService.call(@lesson)
    @count = Phrase.where(created_at: Time.current.all_day, lesson_id: @lesson.id)
                   .where.not(en_input: nil).count
  end
end
