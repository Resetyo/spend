class Source < ApplicationRecord
  default_scope { order(position: :desc, id: :desc) }
end
