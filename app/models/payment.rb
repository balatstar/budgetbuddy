class Payment < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :payment_groups
  has_many :groups, through: :payment_groups

  validates :name, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 0 }
end
