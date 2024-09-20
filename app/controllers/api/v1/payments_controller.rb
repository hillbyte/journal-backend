class Api::V1::PaymentsController < ApplicationController
  before_action :authenticate_request

  def index
    payments = @current_user.payments
    render json: payments, status: :ok
  end

  def show
    payment = @current_user.payments.find(params[:id])
    render json: payment, status: :ok
  end

  def create
    amount = params[:amount]
    payment = Razorpay::Order.create(amount: amount, currency: "INR", receipt: "TEST")
    render json: { payment: payment }, status: :created
  end

  def verify
    payment = Razorpay::Payment.fetch(params[:razorpay_payment_id])
    if payment.status == "captured"
      subscription = Subscription.create(
        user: @current_user,
        plan: params[:plan],
        start_date: Date.today,
        end_date: Date.today + 1.month,
      )
      Payment.create(
        user: @current_user,
        amount: payment.amount / 100.0,
        subscription: subscription,
        status: "completed",
      )
      render json: { message: "Payment successful" }, status: :ok
    else
      render json: { error: "Payment failed" }, status: :unprocessable_entity
    end
  end
end
