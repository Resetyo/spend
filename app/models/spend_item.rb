class SpendItem < ApplicationRecord
  belongs_to :category, optional: true
  belongs_to :source, optional: true
  belongs_to :target, optional: true, class_name: 'Source'

  attr_accessor :like, :replenishment

  before_save :negative_amount, if: :replenishment?
  after_save :change_source_amount
  after_destroy :revert_source_amount

  default_scope { order(created_at: :desc) }

  private

  def replenishment?
    replenishment.to_i == 1
  end

  def negative_amount
    self.amount = -amount
  end

  def change_source_amount
    return unless amount_previously_changed? || source_id_previously_changed? || target_id_previously_changed?

    if source_id_previously_changed?
      source_was = Source.find_by(id: source_id_previously_was)
      source_was&.update(amount: source_was.amount + amount_previously_was)
    else
      self.source&.update(amount: source.amount + amount_previously_was) if amount_previously_changed?
    end

    if target_id_previously_changed?
      target_was = Source.find_by(id: target_id_previously_was)
      target_was&.update(amount: target_was.amount - amount_previously_was)
    end

    self.source&.update(amount: source.amount - amount)
    self.target&.update(amount: target.amount + amount)
  end

  def revert_source_amount
    self.source&.update(amount: source.amount + amount)
    self.target&.update(amount: target.amount - amount)
  end
end
