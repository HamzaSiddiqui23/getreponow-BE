# frozen_string_literal: true

class EmailEvent < ApplicationRecord
  belongs_to :email_recipient

  validates :status, :email_recipient, presence: true

  after_commit :block_email, if: ->(i) { %w[bounce spamreport].include?(i.status) }

  def block_email
    BlockedEmail.create_with(email: email_recipient.recipient_email,
                             event: status).find_or_create_by(email: email_recipient.recipient_email)
  end
end
