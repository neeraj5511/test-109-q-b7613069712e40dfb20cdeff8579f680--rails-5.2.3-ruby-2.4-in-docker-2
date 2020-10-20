class Location < ApplicationRecord
  validates :latitude,:longitude, presence: true
  belongs_to :driver
end
