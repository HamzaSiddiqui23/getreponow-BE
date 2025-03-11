# frozen_string_literal: true

# == Schema Information
#
# Table name: email_recipients
#
#  id              :bigint           not null, primary key
#  recipient_type  :string           not null
#  recipient_id    :bigint           not null
#  recipient_email :string           not null
#  email_id        :bigint           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class EmailRecipient < ApplicationRecord
  belongs_to :recipient, polymorphic: true
  belongs_to :email

  has_many :email_events, as: :recipient

  validates :recipient_email, format: { with: Constants::EMAIL_REGEX }
end
