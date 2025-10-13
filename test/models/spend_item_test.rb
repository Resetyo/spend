require "test_helper"

class SpendItemTest < ActiveSupport::TestCase
  test "change amount and source" do
    source_was = sources(:one)
    spend_item = SpendItem.create(title: 'food', source: source_was, amount: 1)
    assert source_was.amount == 99
    spend_item.update(amount: 2, source: sources(:two))
    assert source_was.reload.amount == 100
    assert spend_item.source.amount == 198
  end

  test "change amount and target" do
    target_was = sources(:one)
    spend_item = SpendItem.create(title: 'food', source: sources(:two), amount: 1, target: target_was)
    assert spend_item.source.amount == 199
    assert target_was.amount == 101
    spend_item.update(amount: 2, target: sources(:three))
    assert target_was.reload.amount == 100
    assert spend_item.target.amount == 302
  end
end
