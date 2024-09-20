class Api::V1::JournalsController < ApplicationController
  before_action :authenticate_request

  def index
    journals = @current_user.journals
    render json: journals, status: :ok
  end

  def show
    journal = @current_user.journals.find(params[:id])
    render json: journal, status: :ok
  end

  def create
    journal = @current_user.journals.new(journal_params)
    if journal.save
      render json: journal, status: :created
    else
      render json: { errors: journal.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    journal = @current_user.journals.find(params[:id])
    if journal.update(journal_params)
      render json: journal, status: :ok
    else
      render json: { errors: journal.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    journal = @current_user.journals.find(params[:id])
    journal.destroy
    head :no_content
  end

  private

  def journal_params
    params.require(:journal).permit(:title)
  end
end
