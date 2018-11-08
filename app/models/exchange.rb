class Exchange < ApplicationRecord
  has_many :payins
  has_many :payouts
end
