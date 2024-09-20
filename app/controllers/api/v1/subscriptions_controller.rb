class Api::V1::SubscriptionsController < ApplicationController
  before_action :authenticate_request

  def index
    subscriptions = @current_user.subscriptions
    render json: subscriptions, status: :ok
  end

  def show
    subscription = @current_user.subscriptions.find(params[:id])
    render json: subscription, status: :ok
  end

  def create
    subscription = @current_user.subscriptions.new(subscription_params)
    if subscription.save
      render json: subscription, status: :created
    else
      render json: { errors: subscription.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def subscription_params
    params.require(:subscription).permit(:plan, :start_date, :end_date)
  end
end
