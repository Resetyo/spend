class SpendItem < ApplicationRecord
  belongs_to :category, optional: true
  belongs_to :source, optional: true

  attr_accessor :like, :replenishment

  before_save :revert_amount, if: :replenishment?
  after_save :change_source_amount
  after_destroy :revert_source_amount

  default_scope { order(created_at: :desc) }

  private

  def replenishment?
    replenishment.to_i == 1
  end

  def revert_amount
    self.amount = -amount
  end

  def change_source_amount
    source_was = Source.find_by(id: source_id_previously_was)
    source_was&.update(amount: source_was.amount + amount)
    self.source&.update(amount: source.amount - amount)
  end

  def revert_source_amount
    self.source&.update(amount: source.amount + amount)
  end
end
