class Payin < ApplicationRecord
  belongs_to :exchange

  validates_presence_of :exchange_id, :timestamp, :amount
end
