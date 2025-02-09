class Company < ApplicationRecord

  validates :name, presence: true
  
  has_one :address, as: :resource
  has_many :users
  has_many :locations
  has_many :contacts
  has_one_attached :logo

  accepts_nested_attributes_for :address, allow_destroy: true
  accepts_nested_attributes_for :locations, allow_destroy: true

  def primary_user
    users.where(primary: true).first
  end
end
