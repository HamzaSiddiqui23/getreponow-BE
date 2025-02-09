class Location < ApplicationRecord

  validates :name, presence: true
  validates :location_email, format: { with: Constants::EMAIL_REGEX }
  validates :active, presence: true
  
  has_one :address, as: :resource
  belongs_to :company

  accepts_nested_attributes_for :address, allow_destroy: true

  before_validation :set_default

  def set_default
    self.active = true if active.nil?
  end
end
