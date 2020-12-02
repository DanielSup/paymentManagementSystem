class Payment < ApplicationRecord
  belongs_to :user
  acts_as_taggable_on :tags

  scope :payments_of_user, lambda { |user_id| where(user_id: user_id) }

  validates :description, presence: true
  validates :amount, presence: true

  def self.incomes(user_id)
    incomes_table = Payment.arel_table[:amount].gt(0)
    incomes_scope = payments_of_user(user_id).where(incomes_table)
    incomes_scope.sum(:amount)
  end

  def self.expenses(user_id)
    expenses_table = Payment.arel_table[:amount].lt(0)
    expenses_scope = payments_of_user(user_id).where(expenses_table)
    expenses_scope.sum(:amount).abs
  end

  def self.balance(user_id)
    payments_of_user(user_id).sum(:amount)
  end

end
