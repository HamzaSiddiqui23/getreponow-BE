# frozen_string_literal: true

# == Schema Information
#
# Table name: email_events
#
#  id             :bigint           not null, primary key
#  recipient_type :string           not null
#  recipient_id   :bigint           not null
#  status         :string           not null
#  timestamp      :datetime         not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class EmailEvent < ApplicationRecord
  belongs_to :recipient, polymorphic: true

  validates :status, :recipient, presence: true

  after_commit :block_email, if: ->(i) { %w[bounce spamreport].include?(i.status) }

  def block_email
    BlockedEmail.create_with(email: email_recipient.recipient_email,
                             event: status).find_or_create_by(email: email_recipient.recipient_email)
  end
end
