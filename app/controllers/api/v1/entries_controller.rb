class Api::V1::EntriesController < ApplicationController
  before_action :authenticate_request
  before_action :check_subscription, only: [:create, :update, :destroy]

  def index
    journal = @current_user.journals.find(params[:journal_id])
    entries = journal.entries.order(date: :desc)
    render json: entries, status: :ok
  end

  def show
    journal = @current_user.journals.find(params[:journal_id])
    entry = journal.entries.find(params[:id])
    render json: entry, status: :ok
  end

  def create
    journal = @current_user.journals.find(params[:journal_id])
    entry = journal.entries.new(entry_params)

    if @current_user.subscription_status == "active"
      mood_analyzer = MoodAnalyzer.new
      entry.mood = mood_analyzer.analyze(entry.content)
    end

    if entry.save
      render json: entry, status: :created
    else
      render json: { errors: entry.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    journal = @current_user.journals.find(params[:journal_id])
    entry = journal.entries.find(params[:id])

    if entry.update(entry_params)
      render json: entry, status: :ok
    else
      render json: { errors: entry.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    journal = @current_user.journals.find(params[:journal_id])
    entry = journal.entries.find(params[:id])
    entry.destroy
    head :no_content
  end

  private

  def entry_params
    params.require(:entry).permit(:content, :mood, :date)
  end

  def check_subscription
    unless @current_user.subscription_status == "active" || @current_user.subscription_status == "trial"
      render json: { error: "Upgrade to premium to access this feature" }, status: :forbidden
    end
  end
end
