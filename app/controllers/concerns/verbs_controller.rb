class VerbsController < ApplicationController
  before_action :find_verb, only: %w(edit update)

  def index
    @verbs = Verb.all
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
    params.require(:verb).permit(:en, :ru, question_word_ids: [])
  end
end
