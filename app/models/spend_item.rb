class SpendItem < ApplicationRecord
  belongs_to :category, optional: true
  belongs_to :source, optional: true

  attr_accessor :like
end
