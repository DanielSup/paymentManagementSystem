require 'test_helper'

class PaymentTest < ActiveSupport::TestCase

  test "create valid payment with tags" do
    payment = payments(:one)
    new_payment = Payment.new(description: payment.description, amount: payment.amount, user: payment.user, tag_list: ['tag1', 'tag2'])
    assert_nothing_raised { new_payment.save! }
    new_payment.save
    new_payment.reload
    assert_equal(new_payment.tags.count, 2)
    assert_equal(new_payment.tags.map { |tag| tag.name }, ['tag1', 'tag2'])
  end

  test "not create payment without user" do
    payment = payments(:one)
    new_payment = Payment.new(description: payment.description, amount: payment.amount)
    assert_raises(ActiveRecord::RecordInvalid) { new_payment.save! }
  end

  test "not create payment without description" do
    payment = payments(:one)
    new_payment = Payment.new(amount: payment.amount, user: payment.user)
    assert_raises(ActiveRecord::RecordInvalid) { new_payment.save! }
  end

  test "not create payment without amount" do
    payment = payments(:one)
    new_payment = Payment.new(description: payment.description, user: payment.user)
    assert_raises(ActiveRecord::RecordInvalid) { new_payment.save! }
  end

  test "incomes, expenses and balance for first user" do
    user = users(:one)
    assert_equal(Payment.incomes(user.id), 4.5)
    assert_equal(Payment.expenses(user.id), 2)
    assert_equal(Payment.balance(user.id), 2.5)
  end

  test "incomes, expenses and balance for second user" do
    user = users(:two)
    assert_equal(Payment.incomes(user.id), 2.25)
    assert_equal(Payment.expenses(user.id), 2)
    assert_equal(Payment.balance(user.id), 0.25)
  end
end
