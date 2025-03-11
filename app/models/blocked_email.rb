# frozen_string_literal: true

# == Schema Information
#
# Table name: blocked_emails
#
#  id         :bigint           not null, primary key
#  email      :string           not null
#  status     :string           not null
#  event      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class BlockedEmail < ApplicationRecord
  validates :email, presence: true
end
