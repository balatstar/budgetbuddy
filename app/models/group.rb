class Group < ApplicationRecord
  belongs_to :user
  has_many :payment_groups
  has_many :payments, through: :payment_groups

  validates :name, presence: true
  validates :icon, presence: true

  def total_payments_amount
    payments.sum(:amount)
  end
end
