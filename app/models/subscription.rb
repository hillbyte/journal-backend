class Subscription < ApplicationRecord
  belongs_to :user

  validates :plan, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
end
