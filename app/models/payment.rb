class Payment < ApplicationRecord
  belongs_to :user
  belongs_to :subscription

  validates :amount, presence: true
  validates :status, presence: true
end
