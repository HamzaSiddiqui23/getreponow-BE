# frozen_string_literal: true

# == Schema Information
#
# Table name: locations
#
#  id                :bigint           not null, primary key
#  name              :string
#  active            :boolean
#  location_email    :string
#  google_review_url :string
#  company_id        :bigint
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
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
