class SpendItem < ApplicationRecord
  belongs_to :category, optional: true
  belongs_to :source, optional: true

  attr_accessor :like

  after_save :change_source_amount

  default_scope { order(created_at: :desc) }

  private

  def change_source_amount
    self.source&.update(amount: source.amount - amount)
  end
end
