class User < ApplicationRecord
  has_secure_password
  has_many :journals
  has_many :subscriptions
  has_many :payments

  validates :email, presence: true, uniqueness: true
  validates :name, presence: true
end
