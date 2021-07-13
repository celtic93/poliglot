class PronounFormsController < ApplicationController
  before_action :find_pronoun_form, only: %w(edit update destroy)

  def index
    @pronoun_forms = PronounForm.all
  end

  def new
    @pronoun_form = PronounForm.new
  end

  def create
    @pronoun_form = PronounForm.create(pronoun_form_params)

    if @pronoun_form.save
      redirect_to pronoun_forms_path, notice: 'Pronoun form created'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @pronoun_form.update(pronoun_form_params)
      redirect_to pronoun_forms_path, notice: 'Pronoun form updated'
    else
      render :edit
    end
  end

  def destroy
    @pronoun_form.destroy
    redirect_to pronoun_forms_path, notice: 'Pronoun form deleted'
  end

  private

  def pronoun_form_params
    params.require(:pronoun_form).permit(:en, :ru, :pronoun_id)
  end

  def find_pronoun_form
    @pronoun_form = PronounForm.find(params[:id])
  end
end
