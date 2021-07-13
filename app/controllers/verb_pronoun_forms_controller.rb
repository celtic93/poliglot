class VerbPronounFormsController < ApplicationController
  def index
    @verb_pronoun_forms = VerbPronounForm.all.order(id: :desc)
  end

  def new
    @verb_pronoun_form = VerbPronounForm.new
  end

  def create
    @verb_pronoun_form = VerbPronounForm.create(verb_pronoun_form_params)

    if @verb_pronoun_form.save
      redirect_to verb_pronoun_forms_path, notice: 'VerbPronoun form created'
    else
      render :new
    end
  end

  def destroy
    @verb_pronoun_form = VerbPronounForm.find(params[:id])
    @verb_pronoun_form.destroy
    redirect_to verb_pronoun_forms_path, notice: 'VerbPronoun form deleted'
  end

  private

  def verb_pronoun_form_params
    params.require(:verb_pronoun_form).permit(:verb_id, :pronoun_form_id, :pronoun_id)
  end
end
