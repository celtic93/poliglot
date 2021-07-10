class PhrasesController < ApplicationController
  def check_phrase
    @phrase = Phrase.find(params[:phrase][:id])

    if @phrase.update(phrase_params)
      redirect_to @phrase.lesson
    else
      render 'lessons/error', phrase: @phrase
    end
  end

  private

  def phrase_params
    params.require(:phrase).permit(:en_input)
  end
end
