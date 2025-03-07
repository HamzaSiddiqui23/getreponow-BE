# frozen_string_literal: true

class BlockedEmail < ApplicationRecord
  validates :email, presence: true
end
