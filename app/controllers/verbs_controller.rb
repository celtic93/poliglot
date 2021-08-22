class VerbsController < ApplicationController
  before_action :find_verb, only: %w(edit update)

  def index
    @verbs = Verb.all.order(:updated_at)
  end

  def edit; end

  def update
    if @verb.update(verb_params)
      redirect_to verbs_path, notice: 'Verb updated'
    else
      render :edit
    end
  end

  private

  def find_verb
    @verb = Verb.find(params[:id])
  end

  def verb_params
    params.require(:verb).permit(:en, :ru, :ru_present_i, :ru_present_you, :ru_present_he,
                                 :ru_present_she, :ru_present_we, :ru_present_they, :ru_past_i,
                                 :ru_past_you, :ru_past_he, :ru_past_she, :ru_past_we,
                                 :ru_past_they, :ru_future_i, :ru_future_you, :ru_future_he,
                                 :ru_future_she, :ru_future_we, :ru_future_they, question_word_ids: [])
  end
end
