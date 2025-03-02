# frozen_string_literal: true

class Contact < ApplicationRecord
  include Phonify

  belongs_to :company

  validates :first_name, :last_name, presence: true
  validates :email, format: { with: Constants::EMAIL_REGEX }

  scope :marketable_contacts, -> { where('opt_out = false') }

  def name
    "#{first_name} #{last_name}"
  end
end
