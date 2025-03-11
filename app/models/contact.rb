# frozen_string_literal: true

# == Schema Information
#
# Table name: contacts
#
#  id         :bigint           not null, primary key
#  first_name :string           not null
#  last_name  :string           not null
#  email      :string
#  phone      :string
#  opt_out    :boolean          default(FALSE)
#  company_id :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
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
