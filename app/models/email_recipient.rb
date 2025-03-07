# frozen_string_literal: true

class EmailRecipient < ApplicationRecord
  belongs_to :recipient, polymorphic: true
  belongs_to :email

  has_many :email_events

  validates :recipient_email, format: { with: Constants::EMAIL_REGEX }
end
