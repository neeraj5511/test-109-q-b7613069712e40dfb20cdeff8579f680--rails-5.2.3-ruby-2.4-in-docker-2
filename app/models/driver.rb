class Driver < ApplicationRecord
	validates :name,:email,:phone_number,:license_number,:car_number, presence: true
	validates :email,uniqueness: true,format: /\w+@\w+\.{1}[a-zA-Z]{2,}/
	validates :phone_number,uniqueness: true,:format => { :with => /\A(\+1)?[0-9]{10}\z/, :message => "Not a valid 10-digit telephone number" }
	validates :car_number,uniqueness: true
	validates :license_number,uniqueness: true
	has_one :location,dependent: :destroy
end
