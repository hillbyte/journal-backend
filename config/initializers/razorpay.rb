# config/initializers/razorpay.rb
Razorpay.setup(Rails.application.credentials.dig(:razorpay, :key_id), Rails.application.credentials.dig(:razorpay, :key_secret))
