class PagesController < ApplicationController
  def index
  end

  def create
    from = CadSystem.find_by(name: params[:from_system_type])
    to = CadSystem.find_by(name: params[:to_system_type])
    result = Translator.call(input_text: params[:input_text], from: from.name, to: to.name)
    p params[:input_text]
    page = Session.create!(input_text: params[:input_text], result: result, from: from, to: to)
    render "index", locals: {page: page} # redirect_to root_path
  end

  private

  def pages_params
    params.permit(:text, :system_type)
  end
end
