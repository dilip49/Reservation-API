class Reservation < ApplicationRecord
  # association
  belongs_to :guest

  # validation
  validates :code, uniqueness: true, presence: true
end
